-- Fix Database Permissions for portfolio_user
-- Run this as postgres user on your Ubuntu server

-- Connect to the lingo database
\c lingo

-- Grant all privileges on the database
GRANT ALL PRIVILEGES ON DATABASE lingo TO portfolio_user;

-- Grant all privileges on the public schema
GRANT ALL ON SCHEMA public TO portfolio_user;

-- Grant all privileges on all existing tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO portfolio_user;

-- Grant all privileges on all sequences (for auto-increment IDs)
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO portfolio_user;

-- Grant privileges on future tables and sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO portfolio_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO portfolio_user;

-- Make portfolio_user the owner of all tables (most comprehensive fix)
ALTER TABLE courses OWNER TO portfolio_user;
ALTER TABLE units OWNER TO portfolio_user;
ALTER TABLE lessons OWNER TO portfolio_user;
ALTER TABLE challenges OWNER TO portfolio_user;
ALTER TABLE challenge_options OWNER TO portfolio_user;
ALTER TABLE challenge_progress OWNER TO portfolio_user;
ALTER TABLE user_progress OWNER TO portfolio_user;
ALTER TABLE user_subscription OWNER TO portfolio_user;

-- Also change ownership of sequences
ALTER SEQUENCE courses_id_seq OWNER TO portfolio_user;
ALTER SEQUENCE units_id_seq OWNER TO portfolio_user;
ALTER SEQUENCE lessons_id_seq OWNER TO portfolio_user;
ALTER SEQUENCE challenges_id_seq OWNER TO portfolio_user;
ALTER SEQUENCE challenge_options_id_seq OWNER TO portfolio_user;
ALTER SEQUENCE challenge_progress_id_seq OWNER TO portfolio_user;
ALTER SEQUENCE user_subscription_id_seq OWNER TO portfolio_user;

-- Change ownership of the enum type
ALTER TYPE "type" OWNER TO portfolio_user;

-- Verify permissions
SELECT 
    schemaname,
    tablename,
    tableowner,
    hasinsert,
    hasselect,
    hasupdate,
    hasdelete
FROM pg_tables 
LEFT JOIN (
    SELECT 
        schemaname as schema_name,
        tablename as table_name,
        has_table_privilege('portfolio_user', schemaname||'.'||tablename, 'INSERT') as hasinsert,
        has_table_privilege('portfolio_user', schemaname||'.'||tablename, 'SELECT') as hasselect,
        has_table_privilege('portfolio_user', schemaname||'.'||tablename, 'UPDATE') as hasupdate,
        has_table_privilege('portfolio_user', schemaname||'.'||tablename, 'DELETE') as hasdelete
    FROM pg_tables 
    WHERE schemaname = 'public'
) perms ON pg_tables.schemaname = perms.schema_name AND pg_tables.tablename = perms.table_name
WHERE schemaname = 'public';

-- Test insert permission
INSERT INTO user_progress (user_id, user_name, hearts, points) 
VALUES ('test_user_123', 'Test User', 5, 0) 
ON CONFLICT (user_id) DO UPDATE SET user_name = EXCLUDED.user_name;

-- Clean up test data
DELETE FROM user_progress WHERE user_id = 'test_user_123';

SELECT 'Permissions fixed successfully!' as status;