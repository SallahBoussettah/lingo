# Database Setup for Oracle Cloud Ubuntu Server

Since you're deploying the app on Vercel and only using the Ubuntu server for PostgreSQL, here's how to set up the database:

## Method 1: Install Node.js dependencies temporarily

```bash
# On your Ubuntu server
cd /var/www/lingo

# Install dependencies (this will install drizzle-kit and tsx)
npm install

# Now run the database commands
npm run db:push
npm run db:seed

# Optional: Clean up node_modules after setup if you want
# rm -rf node_modules
```

## Method 2: Use npx to run commands directly

```bash
# On your Ubuntu server
cd /var/www/lingo

# Install only the required packages globally or use npx
npx drizzle-kit push:pg
npx tsx ./scripts/seed.ts
```

## Method 3: Manual Database Setup (Recommended for server-only setup)

Since you're only using the server for the database, this is the cleanest approach:

### 1. Upload the SQL file to your server

```bash
# Copy the setup-database.sql file to your server
scp setup-database.sql ubuntu@your-server:/tmp/
```

### 2. Connect to PostgreSQL and run the setup

```bash
# On your Ubuntu server
sudo -u postgres psql -d lingo -f /tmp/setup-database.sql
```

### 3. Verify the setup

```bash
sudo -u postgres psql -d lingo -c "
SELECT 'Courses' as table_name, COUNT(*) as count FROM courses
UNION ALL
SELECT 'Units', COUNT(*) FROM units
UNION ALL
SELECT 'Lessons', COUNT(*) FROM lessons
UNION ALL
SELECT 'Challenge Options', COUNT(*) FROM challenge_options;"
```

You should see:

```
 table_name      | count
-----------------+-------
 Courses         |     4
 Units           |     1
 Lessons         |     5
 Challenge Options|     9
```

## Method 4: Quick Fix for npm commands

If you want to use the npm commands, just install the dependencies temporarily:

```bash
# On your Ubuntu server
cd /var/www/lingo
npm install
npm run db:push
npm run db:seed

# Optional: Remove node_modules after setup
rm -rf node_modules package-lock.json
```
