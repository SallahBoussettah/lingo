# Vercel Environment Variables Setup

## The Problem
The Stripe error occurs because `NEXT_PUBLIC_APP_URL` is missing the `https://` scheme or is not set properly in Vercel.

## Fix Applied
Updated the `absoluteUrl` function in `lib/utils.ts` to automatically add `https://` if missing.

## Vercel Environment Variables

Set these in your Vercel dashboard (Project Settings → Environment Variables):

### Required Variables:

```env
# App URL (your Vercel domain)
NEXT_PUBLIC_APP_URL=https://your-app-name.vercel.app

# Clerk Authentication (Production)
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_live_your_production_key
CLERK_SECRET_KEY=sk_live_your_production_secret

# Database (Oracle Cloud)
DATABASE_URL=postgresql://portfolio_user:SATOSANb6...@158.178.204.36:5432/lingo

# Stripe (Production)
STRIPE_API_KEY=sk_live_your_stripe_live_key
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret

# Node Environment
NODE_ENV=production
```

## How to Set Environment Variables in Vercel:

1. Go to your Vercel dashboard
2. Select your project
3. Go to Settings → Environment Variables
4. Add each variable with the correct value
5. Make sure to set them for "Production" environment

## Important Notes:

### NEXT_PUBLIC_APP_URL
- Must include `https://` 
- Should be your actual Vercel domain
- Example: `https://lingo-app.vercel.app`

### Clerk Keys
- Use **production** keys from Clerk dashboard
- Make sure your Vercel domain is added to Clerk's allowed origins

### Stripe Keys
- Use **live** keys for production (not test keys)
- Set up webhook endpoint in Stripe dashboard pointing to your Vercel domain

### Database URL
- Should point to your Oracle Cloud PostgreSQL
- Format: `postgresql://portfolio_user:SATOSANb6...@158.178.204.36:5432/lingo`

## Testing the Fix:

After setting the environment variables:

1. Redeploy your Vercel app
2. Try the subscription flow again
3. The Stripe checkout should work without URL errors

## Webhook Setup (Important for Stripe):

1. Go to Stripe Dashboard → Webhooks
2. Add endpoint: `https://your-app.vercel.app/api/webhooks/stripe`
3. Select events: `checkout.session.completed`, `invoice.payment_succeeded`
4. Copy the webhook secret to `STRIPE_WEBHOOK_SECRET`

## Common Issues:

### "Invalid URL" Error
- Check `NEXT_PUBLIC_APP_URL` has `https://`
- Verify the domain is correct

### Clerk Authentication Issues
- Ensure production keys are used
- Add Vercel domain to Clerk allowed origins

### Database Connection Issues
- Verify Oracle Cloud security rules allow Vercel IPs
- Test database connection from local machine first