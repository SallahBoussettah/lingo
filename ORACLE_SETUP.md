# Oracle Cloud Database Setup

## One-Command Installation

Run this single command on your Ubuntu server to install everything needed for database operations:

```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && \
sudo apt-get install -y nodejs postgresql-client && \
npm install -g tsx && \
echo "✅ Setup complete! Node.js, PostgreSQL client, and tsx installed."
```

## Alternative: Step-by-Step Installation

If you prefer to install step by step:

```bash
# 1. Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# 2. Install PostgreSQL client
sudo apt-get install -y postgresql-client

# 3. Install TypeScript runner globally
npm install -g tsx

# 4. Verify installation
node --version
psql --version
tsx --version
```

## Database Operations

### Connect to Database
```bash
psql "postgresql://portfolio_user:SATOSANb6...@158.178.204.36:5432/lingo"
```

### Run SQL Seed Script
```bash
# Download the SQL file first, then:
psql "postgresql://portfolio_user:SATOSANb6...@158.178.204.36:5432/lingo" -f enhanced-seed.sql
```

### Run TypeScript Scripts (if you have the project files)
```bash
# Copy your .env.production file first
tsx scripts/debug-subscription.ts
tsx scripts/enhanced-seed.ts
```

## Quick Database Seeding

If you just want to seed the database with the enhanced content:

1. **Copy the SQL content** from `scripts/enhanced-seed.sql`
2. **Connect to your database**:
   ```bash
   psql "postgresql://portfolio_user:SATOSANb6...@158.178.204.36:5432/lingo"
   ```
3. **Paste and execute** the SQL content

## Minimal Project Setup (Optional)

If you want to run the TypeScript scripts on the server:

```bash
# Create minimal project
mkdir lingo-db && cd lingo-db

# Copy essential files
# - .env.production
# - scripts/enhanced-seed.ts
# - scripts/debug-subscription.ts
# - db/schema.ts
# - db/drizzle.ts

# Install minimal dependencies
npm init -y
npm install dotenv drizzle-orm postgres stripe

# Run scripts
tsx scripts/enhanced-seed.ts
```

## What Each Tool Does

- **Node.js**: Runtime for JavaScript/TypeScript
- **psql**: PostgreSQL command-line client
- **tsx**: TypeScript runner (no compilation needed)

## Total Installation Size
- Node.js: ~50MB
- PostgreSQL client: ~5MB  
- tsx: ~10MB
- **Total: ~65MB**

This is much lighter than installing the full Next.js project dependencies!