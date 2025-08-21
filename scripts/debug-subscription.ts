import "dotenv/config";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { eq } from "drizzle-orm";

import * as schema from "../db/schema";

const sql = postgres(process.env.DATABASE_URL!);
const db = drizzle(sql, { schema });

const main = async () => {
  try {
    console.log("🔍 Debugging subscription system...\n");

    // Check environment variables
    console.log("📋 Environment Check:");
    console.log("- STRIPE_API_KEY:", process.env.STRIPE_API_KEY ? "✅ Set" : "❌ Missing");
    console.log("- STRIPE_WEBHOOK_SECRET:", process.env.STRIPE_WEBHOOK_SECRET ? "✅ Set" : "❌ Missing");
    console.log("- DATABASE_URL:", process.env.DATABASE_URL ? "✅ Set" : "❌ Missing");
    console.log();

    // Check database tables
    console.log("🗄️ Database Tables Check:");
    
    const courses = await db.query.courses.findMany();
    console.log(`- Courses: ${courses.length} found`);
    
    const subscriptions = await db.query.userSubscription.findMany();
    console.log(`- User Subscriptions: ${subscriptions.length} found`);
    
    if (subscriptions.length > 0) {
      console.log("\n📊 Subscription Details:");
      subscriptions.forEach((sub, index) => {
        const isActive = sub.stripePriceId && 
          sub.stripeCurrentPeriodEnd && 
          sub.stripeCurrentPeriodEnd.getTime() + 86400000 > Date.now();
        
        console.log(`  ${index + 1}. User: ${sub.userId}`);
        console.log(`     Customer ID: ${sub.stripeCustomerId}`);
        console.log(`     Subscription ID: ${sub.stripeSubscriptionId}`);
        console.log(`     Price ID: ${sub.stripePriceId}`);
        console.log(`     Period End: ${sub.stripeCurrentPeriodEnd}`);
        console.log(`     Status: ${isActive ? "✅ Active" : "❌ Inactive"}`);
        console.log();
      });
    }

    const userProgress = await db.query.userProgress.findMany();
    console.log(`- User Progress Records: ${userProgress.length} found`);
    
    console.log("\n🎯 Recommendations:");
    
    if (!process.env.STRIPE_WEBHOOK_SECRET || process.env.STRIPE_WEBHOOK_SECRET.includes("YOUR_")) {
      console.log("❌ Set up proper Stripe webhook secret in production");
      console.log("   1. Go to Stripe Dashboard > Webhooks");
      console.log("   2. Create endpoint: https://your-domain.com/api/webhooks/stripe");
      console.log("   3. Select events: checkout.session.completed, invoice.payment_succeeded");
      console.log("   4. Copy webhook secret to STRIPE_WEBHOOK_SECRET");
    }
    
    if (subscriptions.length === 0) {
      console.log("ℹ️ No subscriptions found - this is normal for new installations");
    }
    
    console.log("✅ Test payment flow:");
    console.log("   1. Make sure webhook is configured in Stripe");
    console.log("   2. Test with Stripe test cards");
    console.log("   3. Check webhook delivery in Stripe dashboard");
    
  } catch (error) {
    console.error("❌ Debug error:", error);
  } finally {
    await sql.end();
  }
};

main();