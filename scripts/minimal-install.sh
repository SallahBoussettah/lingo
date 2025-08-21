#!/bin/bash

# Minimal installation for Oracle Cloud database operations
# Run this on your Ubuntu server

echo "🔧 Installing minimal dependencies for database operations..."

# Update package list
sudo apt-get update

# Install Node.js 18 (LTS)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PostgreSQL client
sudo apt-get install -y postgresql-client

# Install only required npm packages globally for database operations
npm install -g tsx dotenv-cli

# Create a simple package.json for local dependencies
cat > package.json << 'EOF'
{
  "name": "lingo-db-minimal",
  "version": "1.0.0",
  "scripts": {
    "db:connect": "psql $DATABASE_URL",
    "db:seed-sql": "psql $DATABASE_URL -f scripts/enhanced-seed.sql"
  },
  "dependencies": {
    "dotenv": "^16.4.5",
    "drizzle-orm": "^0.30.1", 
    "postgres": "^3.4.7",
    "stripe": "^14.20.0"
  }
}
EOF

# Install minimal local dependencies
npm install --production

echo "✅ Minimal setup complete!"
echo ""
echo "📋 What's installed:"
echo "  ✓ Node.js 18"
echo "  ✓ PostgreSQL client (psql)"
echo "  ✓ tsx (TypeScript runner)"
echo "  ✓ Essential database packages"
echo ""
echo "🚀 Usage:"
echo "  # Connect to database:"
echo "  psql \"postgresql://user:pass@host:port/dbname\""
echo ""
echo "  # Run SQL seed script:"
echo "  psql \"postgresql://user:pass@host:port/dbname\" -f scripts/enhanced-seed.sql"
echo ""
echo "  # Run TypeScript scripts:"
echo "  tsx scripts/debug-subscription.ts"
echo "  tsx scripts/enhanced-seed.ts"