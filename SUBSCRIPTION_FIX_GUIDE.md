# Subscription System Fix Guide

## Issues Found & Fixed

### 1. Webhook Configuration
- **Problem**: Missing/invalid Stripe webhook secret
- **Fix**: Updated `.env.production` with proper webhook configuration
- **Action Required**: Set up webhook in Stripe Dashboard

### 2. Database Content
- **Problem**: Limited course content (only Spanish had basic lessons)
- **Fix**: Created enhanced seed script with 6 languages and comprehensive content
- **Action Required**: Run enhanced seeding

### 3. Webhook Handler Bug
- **Problem**: Invoice payment handler used wrong object type
- **Fix**: Corrected to use `Stripe.Invoice` instead of `Stripe.Checkout.Session`

## Setup Instructions

### Step 1: Configure Stripe Webhook
1. Go to [Stripe Dashboard > Webhooks](https://dashboard.stripe.com/webhooks)
2. Click "Add endpoint"
3. Set URL: `https://lingo-kappa-eight.vercel.app/api/webhooks/stripe`
4. Select events:
   - `checkout.session.completed`
   - `invoice.payment_succeeded`
5. Copy the webhook secret and update `.env.production`:
   ```
   STRIPE_WEBHOOK_SECRET="whsec_your_actual_secret_here"
   ```

### Step 2: Seed Enhanced Content
Run the enhanced seeding to populate all courses:
```bash
npm run db:enhanced-seed
```

This creates:
- 6 languages (Spanish, Italian, French, Croatian, German, Portuguese)
- 3 units per language
- 5 lessons per unit
- Multiple challenges per lesson

### Step 3: Debug Current State
Check your subscription system status:
```bash
npm run subscription:debug
```

### Step 4: Fix Existing Issues
Sync any missing subscription data:
```bash
npm run subscription:fix
```

### Step 5: Test Payment Flow
1. Visit your app's subscription page
2. Use Stripe test cards:
   - Success: `4242 4242 4242 4242`
   - Decline: `4000 0000 0000 0002`
3. Check webhook delivery in Stripe Dashboard
4. Verify subscription appears in your account

## Debugging Tools

### API Endpoint
Visit `/api/subscription/debug` (when logged in) to see:
- Database subscription record
- Stripe subscription status
- Active status calculation
- Debug information

### Scripts
- `npm run subscription:debug` - Check system status
- `npm run subscription:fix` - Sync missing data
- `npm run db:enhanced-seed` - Populate all courses

## Common Issues & Solutions

### Payment Completes but No Subscription
1. Check webhook is configured correctly
2. Verify webhook secret matches
3. Check webhook delivery logs in Stripe
4. Run `npm run subscription:fix` to sync missing data

### Subscription Shows as Inactive
1. Check if `stripeCurrentPeriodEnd` is in the future
2. Verify `stripePriceId` is set
3. Run debug script to see exact values

### Missing Course Content
1. Run `npm run db:enhanced-seed` to populate all languages
2. Check database has units, lessons, and challenges

## Environment Variables Checklist
- ✅ `STRIPE_API_KEY` - Your Stripe secret key
- ✅ `STRIPE_WEBHOOK_SECRET` - Webhook endpoint secret
- ✅ `DATABASE_URL` - PostgreSQL connection string
- ✅ `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY` - Clerk auth
- ✅ `CLERK_SECRET_KEY` - Clerk secret
- ✅ `NEXT_PUBLIC_APP_URL` - Your app URL

## Next Steps
1. Set up proper webhook secret in production
2. Run enhanced seeding for full course content
3. Test payment flow end-to-end
4. Monitor webhook delivery in Stripe Dashboard

The subscription system should now work correctly with proper webhook handling and comprehensive course content!