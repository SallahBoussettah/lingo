import { auth } from "@clerk/nextjs";
import { NextResponse } from "next/server";
import { eq } from "drizzle-orm";

import db from "@/db/drizzle";
import { userSubscription } from "@/db/schema";
import { stripe } from "@/lib/stripe";

export async function GET() {
  try {
    const { userId } = await auth();

    if (!userId) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    // Get user subscription from database
    const dbSubscription = await db.query.userSubscription.findFirst({
      where: eq(userSubscription.userId, userId),
    });

    let stripeSubscription = null;
    if (dbSubscription?.stripeSubscriptionId) {
      try {
        stripeSubscription = await stripe.subscriptions.retrieve(
          dbSubscription.stripeSubscriptionId
        );
      } catch (error) {
        console.error("Error fetching Stripe subscription:", error);
      }
    }

    const DAY_IN_MS = 86_400_000;
    const isActive = dbSubscription?.stripePriceId &&
      dbSubscription?.stripeCurrentPeriodEnd?.getTime()! + DAY_IN_MS > Date.now();

    return NextResponse.json({
      userId,
      database: dbSubscription,
      stripe: stripeSubscription ? {
        id: stripeSubscription.id,
        status: stripeSubscription.status,
        current_period_end: new Date(stripeSubscription.current_period_end * 1000),
        customer: stripeSubscription.customer,
        items: stripeSubscription.items.data.map(item => ({
          price_id: item.price.id,
          product: item.price.product,
        }))
      } : null,
      isActive,
      debug: {
        hasDbRecord: !!dbSubscription,
        hasStripeRecord: !!stripeSubscription,
        periodEndTimestamp: dbSubscription?.stripeCurrentPeriodEnd?.getTime(),
        currentTimestamp: Date.now(),
        gracePeriod: DAY_IN_MS,
      }
    });
  } catch (error) {
    console.error("Subscription debug error:", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}

export async function DELETE() {
  try {
    const { userId } = await auth();

    if (!userId) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    // Remove subscription record (for testing purposes)
    await db.delete(userSubscription).where(eq(userSubscription.userId, userId));

    return NextResponse.json({ message: "Subscription record deleted" });
  } catch (error) {
    console.error("Subscription delete error:", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}