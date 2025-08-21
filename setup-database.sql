-- Lingo Database Setup SQL
-- Run this on your Ubuntu PostgreSQL server

-- Connect to the lingo database first
-- \c lingo

-- Create the challenge type enum
CREATE TYPE "type" AS ENUM ('SELECT', 'ASSIST');

-- Create courses table
CREATE TABLE IF NOT EXISTS "courses" (
    "id" SERIAL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "image_src" TEXT NOT NULL
);

-- Create units table
CREATE TABLE IF NOT EXISTS "units" (
    "id" SERIAL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "course_id" INTEGER NOT NULL REFERENCES "courses"("id") ON DELETE CASCADE,
    "order" INTEGER NOT NULL
);

-- Create lessons table
CREATE TABLE IF NOT EXISTS "lessons" (
    "id" SERIAL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "unit_id" INTEGER NOT NULL REFERENCES "units"("id") ON DELETE CASCADE,
    "order" INTEGER NOT NULL
);

-- Create challenges table
CREATE TABLE IF NOT EXISTS "challenges" (
    "id" SERIAL PRIMARY KEY,
    "lesson_id" INTEGER NOT NULL REFERENCES "lessons"("id") ON DELETE CASCADE,
    "type" "type" NOT NULL,
    "question" TEXT NOT NULL,
    "order" INTEGER NOT NULL
);

-- Create challenge_options table
CREATE TABLE IF NOT EXISTS "challenge_options" (
    "id" SERIAL PRIMARY KEY,
    "challenge_id" INTEGER NOT NULL REFERENCES "challenges"("id") ON DELETE CASCADE,
    "text" TEXT NOT NULL,
    "correct" BOOLEAN NOT NULL,
    "image_src" TEXT,
    "audio_src" TEXT
);

-- Create challenge_progress table
CREATE TABLE IF NOT EXISTS "challenge_progress" (
    "id" SERIAL PRIMARY KEY,
    "user_id" TEXT NOT NULL,
    "challenge_id" INTEGER NOT NULL REFERENCES "challenges"("id") ON DELETE CASCADE,
    "completed" BOOLEAN NOT NULL DEFAULT FALSE
);

-- Create user_progress table
CREATE TABLE IF NOT EXISTS "user_progress" (
    "user_id" TEXT PRIMARY KEY,
    "user_name" TEXT NOT NULL DEFAULT 'User',
    "user_image_src" TEXT NOT NULL DEFAULT '/mascot.svg',
    "active_course_id" INTEGER REFERENCES "courses"("id") ON DELETE CASCADE,
    "hearts" INTEGER NOT NULL DEFAULT 5,
    "points" INTEGER NOT NULL DEFAULT 0
);

-- Create user_subscription table
CREATE TABLE IF NOT EXISTS "user_subscription" (
    "id" SERIAL PRIMARY KEY,
    "user_id" TEXT NOT NULL UNIQUE,
    "stripe_customer_id" TEXT NOT NULL UNIQUE,
    "stripe_subscription_id" TEXT NOT NULL UNIQUE,
    "stripe_price_id" TEXT NOT NULL,
    "stripe_current_period_end" TIMESTAMP NOT NULL
);

-- Clear existing data (optional - remove if you want to keep existing data)
DELETE FROM "challenge_options";
DELETE FROM "challenge_progress";
DELETE FROM "challenges";
DELETE FROM "lessons";
DELETE FROM "units";
DELETE FROM "courses";
DELETE FROM "user_progress";
DELETE FROM "user_subscription";

-- Insert sample courses
INSERT INTO "courses" ("id", "title", "image_src") VALUES
(1, 'Spanish', '/es.svg'),
(2, 'Italian', '/it.svg'),
(3, 'French', '/fr.svg'),
(4, 'Croatian', '/hr.svg');

-- Insert sample unit
INSERT INTO "units" ("id", "course_id", "title", "description", "order") VALUES
(1, 1, 'Unit 1', 'Learn the basics of Spanish', 1);

-- Insert sample lessons
INSERT INTO "lessons" ("id", "unit_id", "order", "title") VALUES
(1, 1, 1, 'Nouns'),
(2, 1, 2, 'Verbs'),
(3, 1, 3, 'Verbs'),
(4, 1, 4, 'Verbs'),
(5, 1, 5, 'Verbs');

-- Insert sample challenges
INSERT INTO "challenges" ("id", "lesson_id", "type", "order", "question") VALUES
(1, 1, 'SELECT', 1, 'Which one of these is the "the man"?'),
(2, 1, 'ASSIST', 2, '"the man"'),
(3, 1, 'SELECT', 3, 'Which one of these is the "the robot"?'),
(4, 2, 'SELECT', 1, 'Which one of these is the "the man"?'),
(5, 2, 'ASSIST', 2, '"the man"'),
(6, 2, 'SELECT', 3, 'Which one of these is the "the robot"?');

-- Insert challenge options for challenge 1
INSERT INTO "challenge_options" ("challenge_id", "image_src", "correct", "text", "audio_src") VALUES
(1, '/man.svg', TRUE, 'el hombre', '/es_man.mp3'),
(1, '/woman.svg', FALSE, 'la mujer', '/es_woman.mp3'),
(1, '/robot.svg', FALSE, 'el robot', '/es_robot.mp3');

-- Insert challenge options for challenge 2
INSERT INTO "challenge_options" ("challenge_id", "correct", "text", "audio_src") VALUES
(2, TRUE, 'el hombre', '/es_man.mp3'),
(2, FALSE, 'la mujer', '/es_woman.mp3'),
(2, FALSE, 'el robot', '/es_robot.mp3');

-- Insert challenge options for challenge 3
INSERT INTO "challenge_options" ("challenge_id", "image_src", "correct", "text", "audio_src") VALUES
(3, '/man.svg', FALSE, 'el hombre', '/es_man.mp3'),
(3, '/woman.svg', FALSE, 'la mujer', '/es_woman.mp3'),
(3, '/robot.svg', TRUE, 'el robot', '/es_robot.mp3');

-- Reset sequences to ensure proper auto-increment
SELECT setval('courses_id_seq', (SELECT MAX(id) FROM courses));
SELECT setval('units_id_seq', (SELECT MAX(id) FROM units));
SELECT setval('lessons_id_seq', (SELECT MAX(id) FROM lessons));
SELECT setval('challenges_id_seq', (SELECT MAX(id) FROM challenges));
SELECT setval('challenge_options_id_seq', (SELECT MAX(id) FROM challenge_options));
SELECT setval('challenge_progress_id_seq', (SELECT MAX(id) FROM challenge_progress));
SELECT setval('user_subscription_id_seq', (SELECT MAX(id) FROM user_subscription));

-- Verify the setup
SELECT 'Courses' as table_name, COUNT(*) as count FROM courses
UNION ALL
SELECT 'Units', COUNT(*) FROM units
UNION ALL
SELECT 'Lessons', COUNT(*) FROM lessons
UNION ALL
SELECT 'Challenges', COUNT(*) FROM challenges
UNION ALL
SELECT 'Challenge Options', COUNT(*) FROM challenge_options;