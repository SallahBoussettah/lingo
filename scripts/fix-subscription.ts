import "dotenv/config";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { eq } from "drizzle-orm";
import Stripe from "stripe";

import * as schema from "../db/schema";

const sql = postgres(process.env.DATABASE_URL!);
const db = drizzle(sql, { schema });

const stripe = new Stripe(process.env.STRIPE_API_KEY!, {
  apiVersion: "2023-10-16",
});

const main = async () => {
  try {
    console.log("🔧 Fixing subscription system...\n");

    // 1. Check for orphaned subscriptions in Stripe
    console.log("1️⃣ Checking Stripe subscriptions...");
    
    const stripeSubscriptions = await stripe.subscriptions.list({
      limit: 100,
      status: 'active'
    });

    console.log(`Found ${stripeSubscriptions.data.length} active Stripe subscriptions`);

    // 2. Check database subscriptions
    console.log("\n2️⃣ Checking database subscriptions...");
    const dbSubscriptions = await db.query.userSubscription.findMany();
    console.log(`Found ${dbSubscriptions.data.length} database subscription records`);

    // 3. Sync missing subscriptions
    console.log("\n3️⃣ Syncing missing subscriptions...");
    
    for (const stripeSub of stripeSubscriptions.data) {
      const existingDbSub = dbSubscriptions.find(
        dbSub => dbSub.stripeSubscriptionId === stripeSub.id
      );

      if (!existingDbSub && stripeSub.metadata?.userId) {
        console.log(`📝 Creating missing database record for subscription ${stripeSub.id}`);
        
        await db.insert(schema.userSubscription).values({
          userId: stripeSub.metadata.userId,
          stripeSubscriptionId: stripeSub.id,
          stripeCustomerId: stripeSub.customer as string,
          stripePriceId: stripeSub.items.data[0].price.id,
          stripeCurrentPeriodEnd: new Date(stripeSub.current_period_end * 1000),
        });
        
        console.log(`✅ Created subscription record for user ${stripeSub.metadata.userId}`);
      }
    }

    // 4. Update expired subscriptions
    console.log("\n4️⃣ Updating subscription statuses...");
    
    for (const dbSub of dbSubscriptions) {
      try {
        const stripeSub = await stripe.subscriptions.retrieve(dbSub.stripeSubscriptionId);
        
        if (stripeSub.status !== 'active') {
          console.log(`⚠️ Subscription ${dbSub.stripeSubscriptionId} is ${stripeSub.status}`);
        }

        // Update period end if different
        const stripeEndDate = new Date(stripeSub.current_period_end * 1000);
        if (dbSub.stripeCurrentPeriodEnd.getTime() !== stripeEndDate.getTime()) {
          await db.update(schema.userSubscription)
            .set({
              stripeCurrentPeriodEnd: stripeEndDate,
              stripePriceId: stripeSub.items.data[0].price.id,
            })
            .where(eq(schema.userSubscription.id, dbSub.id));
          
          console.log(`🔄 Updated subscription ${dbSub.stripeSubscriptionId} period end`);
        }
      } catch (error) {
        console.error(`❌ Error checking subscription ${dbSub.stripeSubscriptionId}:`, error);
      }
    }

    console.log("\n✅ Subscription fix completed!");
    
  } catch (error) {
    console.error("❌ Fix error:", error);
  } finally {
    await sql.end();
  }
};

main();