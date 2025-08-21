const https = require('https');

console.log('🔧 Stripe Webhook Setup Guide\n');

console.log('1️⃣ Go to: https://dashboard.stripe.com/webhooks');
console.log('2️⃣ Click "Add endpoint"');
console.log('3️⃣ Set endpoint URL to:');
console.log('   https://lingo-kappa-eight.vercel.app/api/webhooks/stripe');
console.log('4️⃣ Select these events:');
console.log('   - checkout.session.completed');
console.log('   - invoice.payment_succeeded');
console.log('5️⃣ Copy the webhook secret (starts with whsec_)');
console.log('6️⃣ Update your .env.production file');
console.log('\n🧪 Test Cards:');
console.log('   Success: 4242 4242 4242 4242');
console.log('   Decline: 4000 0000 0000 0002');
console.log('\n✅ Your app is ready for payments once webhook is configured!');