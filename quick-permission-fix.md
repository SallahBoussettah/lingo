# Quick Database Permission Fix

## The Problem
The `portfolio_user` doesn't have proper permissions on the tables that were created by the postgres user.

## Quick Fix Commands

Run these on your Ubuntu server:

```bash
# Method 1: Run the SQL file
sudo -u postgres psql -d lingo -f fix-database-permissions.sql
```

## Or Method 2: Manual commands

```bash
# Connect to PostgreSQL as postgres user
sudo -u postgres psql -d lingo

# Run these commands one by one:
GRANT ALL PRIVILEGES ON DATABASE lingo TO portfolio_user;
GRANT ALL ON SCHEMA public TO portfolio_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO portfolio_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO portfolio_user;

# Make portfolio_user the owner of all tables
ALTER TABLE courses OWNER TO portfolio_user;
ALTER TABLE units OWNER TO portfolio_user;
ALTER TABLE lessons OWNER TO portfolio_user;
ALTER TABLE challenges OWNER TO portfolio_user;
ALTER TABLE challenge_options OWNER TO portfolio_user;
ALTER TABLE challenge_progress OWNER TO portfolio_user;
ALTER TABLE user_progress OWNER TO portfolio_user;
ALTER TABLE user_subscription OWNER TO portfolio_user;

# Exit PostgreSQL
\q
```

## Test the Fix

After running the permission fix, test your Vercel app again. The permission denied error should be gone.

## Alternative: Recreate Tables as portfolio_user

If you still have issues, you can recreate everything as the portfolio_user:

```bash
# Connect as portfolio_user
psql -h localhost -U portfolio_user -d lingo

# Drop all tables (if they exist)
DROP TABLE IF EXISTS challenge_progress CASCADE;
DROP TABLE IF EXISTS challenge_options CASCADE;
DROP TABLE IF EXISTS challenges CASCADE;
DROP TABLE IF EXISTS lessons CASCADE;
DROP TABLE IF EXISTS units CASCADE;
DROP TABLE IF EXISTS user_progress CASCADE;
DROP TABLE IF EXISTS user_subscription CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TYPE IF EXISTS "type";

# Exit and run the setup script as portfolio_user
\q

# Run the setup script as portfolio_user instead of postgres
psql -h localhost -U portfolio_user -d lingo -f setup-database.sql
```

This will ensure all tables are owned by portfolio_user from the start.