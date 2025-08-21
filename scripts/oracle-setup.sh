#!/bin/bash

# Oracle Cloud Database Setup Script
# Minimal dependencies for database operations only

echo "🚀 Setting up minimal dependencies for Oracle Cloud database operations..."

# Install Node.js if not present
if ! command -v node &> /dev/null; then
    echo "📦 Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# Install PostgreSQL client tools
if ! command -v psql &> /dev/null; then
    echo "🐘 Installing PostgreSQL client..."
    sudo apt-get update
    sudo apt-get install -y postgresql-client
fi

# Create minimal package.json for database operations
cat > package-db.json << 'EOF'
{
  "name": "lingo-db-tools",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "db:seed": "node --loader tsx/esm scripts/enhanced-seed.ts",
    "db:debug": "node --loader tsx/esm scripts/debug-subscription.ts",
    "db:fix": "node --loader tsx/esm scripts/fix-subscription.ts"
  },
  "dependencies": {
    "dotenv": "^16.4.5",
    "drizzle-orm": "^0.30.1",
    "postgres": "^3.4.7",
    "stripe": "^14.20.0",
    "tsx": "^4.7.1"
  }
}
EOF

# Install only database dependencies
echo "📚 Installing minimal database dependencies..."
npm install --production --package-lock-only=false \
  dotenv@^16.4.5 \
  drizzle-orm@^0.30.1 \
  postgres@^3.4.7 \
  stripe@^14.20.0 \
  tsx@^4.7.1

echo "✅ Setup complete!"
echo ""
echo "🔧 Available commands:"
echo "  npm run db:seed   - Seed database with enhanced content"
echo "  npm run db:debug  - Debug subscription system"
echo "  npm run db:fix    - Fix subscription issues"
echo ""
echo "🐘 PostgreSQL commands:"
echo "  psql \"postgresql://user:pass@host:port/db\" - Connect to database"
echo "  \\i scripts/enhanced-seed.sql              - Run SQL script"
echo ""
echo "📋 Next steps:"
echo "1. Copy your .env.production file to this server"
echo "2. Run: npm run db:seed"
echo "3. Test with: npm run db:debug"