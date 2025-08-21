-- Fixed Seed Data - Matches Original Working Setup
-- Run this on Oracle Cloud PostgreSQL

-- Clear existing data
DELETE FROM challenge_options;
DELETE FROM challenges;
DELETE FROM challenge_progress;
DELETE FROM lessons;
DELETE FROM units;
DELETE FROM user_progress;
DELETE FROM user_subscription;
DELETE FROM courses;

-- Reset sequences
ALTER SEQUENCE courses_id_seq RESTART WITH 1;
ALTER SEQUENCE units_id_seq RESTART WITH 1;
ALTER SEQUENCE lessons_id_seq RESTART WITH 1;
ALTER SEQUENCE challenges_id_seq RESTART WITH 1;
ALTER SEQUENCE challenge_options_id_seq RESTART WITH 1;
ALTER SEQUENCE challenge_progress_id_seq RESTART WITH 1;
ALTER SEQUENCE user_subscription_id_seq RESTART WITH 1;

-- Insert courses
INSERT INTO courses (id, title, image_src) VALUES
(1, 'Spanish', '/es.svg'),
(2, 'Italian', '/it.svg'),
(3, 'French', '/fr.svg'),
(4, 'Croatian', '/hr.svg');

-- Insert units (1 unit per course for now)
INSERT INTO units (id, course_id, title, description, "order") VALUES
(1, 1, 'Unit 1', 'Learn the basics of Spanish', 1),
(2, 2, 'Unit 1', 'Learn the basics of Italian', 1),
(3, 3, 'Unit 1', 'Learn the basics of French', 1),
(4, 4, 'Unit 1', 'Learn the basics of Croatian', 1);

-- Insert lessons (5 lessons per unit)
INSERT INTO lessons (id, unit_id, title, "order") VALUES
-- Spanish lessons
(1, 1, 'Nouns', 1),
(2, 1, 'Verbs', 2),
(3, 1, 'Verbs', 3),
(4, 1, 'Verbs', 4),
(5, 1, 'Verbs', 5),
-- Italian lessons
(6, 2, 'Nouns', 1),
(7, 2, 'Verbs', 2),
(8, 2, 'Verbs', 3),
(9, 2, 'Verbs', 4),
(10, 2, 'Verbs', 5),
-- French lessons
(11, 3, 'Nouns', 1),
(12, 3, 'Verbs', 2),
(13, 3, 'Verbs', 3),
(14, 3, 'Verbs', 4),
(15, 3, 'Verbs', 5),
-- Croatian lessons
(16, 4, 'Nouns', 1),
(17, 4, 'Verbs', 2),
(18, 4, 'Verbs', 3),
(19, 4, 'Verbs', 4),
(20, 4, 'Verbs', 5);

-- Insert challenges (3 challenges for first lesson of each course)
INSERT INTO challenges (id, lesson_id, type, question, "order") VALUES
-- Spanish challenges (lesson 1)
(1, 1, 'SELECT', 'Which one of these is the "the man"?', 1),
(2, 1, 'ASSIST', '"the man"', 2),
(3, 1, 'SELECT', 'Which one of these is the "the robot"?', 3),
-- Italian challenges (lesson 6)
(4, 6, 'SELECT', 'Which one of these is the "the man"?', 1),
(5, 6, 'ASSIST', '"the man"', 2),
(6, 6, 'SELECT', 'Which one of these is the "the robot"?', 3),
-- French challenges (lesson 11)
(7, 11, 'SELECT', 'Which one of these is the "the man"?', 1),
(8, 11, 'ASSIST', '"the man"', 2),
(9, 11, 'SELECT', 'Which one of these is the "the robot"?', 3),
-- Croatian challenges (lesson 16)
(10, 16, 'SELECT', 'Which one of these is the "the man"?', 1),
(11, 16, 'ASSIST', '"the man"', 2),
(12, 16, 'SELECT', 'Which one of these is the "the robot"?', 3);

-- Insert challenge options (NO AUDIO - matches original)
INSERT INTO challenge_options (id, challenge_id, text, correct, image_src, audio_src) VALUES
-- Spanish options (challenges 1, 2, 3)
-- Challenge 1: Which one is "the man"?
(1, 1, 'el hombre', true, '/man.svg', '/es_man.mp3'),
(2, 1, 'la mujer', false, '/woman.svg', '/es_woman.mp3'),
(3, 1, 'el robot', false, '/robot.svg', '/es_robot.mp3'),
-- Challenge 2: "the man" (ASSIST)
(4, 2, 'el hombre', true, null, '/es_man.mp3'),
(5, 2, 'la mujer', false, null, '/es_woman.mp3'),
(6, 2, 'el robot', false, null, '/es_robot.mp3'),
-- Challenge 3: Which one is "the robot"?
(7, 3, 'el hombre', false, '/man.svg', '/es_man.mp3'),
(8, 3, 'la mujer', false, '/woman.svg', '/es_woman.mp3'),
(9, 3, 'el robot', true, '/robot.svg', '/es_robot.mp3'),

-- Italian options (challenges 4, 5, 6)
-- Challenge 4: Which one is "the man"?
(10, 4, 'l''uomo', true, '/man.svg', '/es_man.mp3'),
(11, 4, 'la donna', false, '/woman.svg', '/es_woman.mp3'),
(12, 4, 'il robot', false, '/robot.svg', '/es_robot.mp3'),
-- Challenge 5: "the man" (ASSIST)
(13, 5, 'l''uomo', true, null, '/es_man.mp3'),
(14, 5, 'la donna', false, null, '/es_woman.mp3'),
(15, 5, 'il robot', false, null, '/es_robot.mp3'),
-- Challenge 6: Which one is "the robot"?
(16, 6, 'l''uomo', false, '/man.svg', '/es_man.mp3'),
(17, 6, 'la donna', false, '/woman.svg', '/es_woman.mp3'),
(18, 6, 'il robot', true, '/robot.svg', '/es_robot.mp3'),

-- French options (challenges 7, 8, 9)
-- Challenge 7: Which one is "the man"?
(19, 7, 'l''homme', true, '/man.svg', '/es_man.mp3'),
(20, 7, 'la femme', false, '/woman.svg', '/es_woman.mp3'),
(21, 7, 'le robot', false, '/robot.svg', '/es_robot.mp3'),
-- Challenge 8: "the man" (ASSIST)
(22, 8, 'l''homme', true, null, '/es_man.mp3'),
(23, 8, 'la femme', false, null, '/es_woman.mp3'),
(24, 8, 'le robot', false, null, '/es_robot.mp3'),
-- Challenge 9: Which one is "the robot"?
(25, 9, 'l''homme', false, '/man.svg', '/es_man.mp3'),
(26, 9, 'la femme', false, '/woman.svg', '/es_woman.mp3'),
(27, 9, 'le robot', true, '/robot.svg', '/es_robot.mp3'),

-- Croatian options (challenges 10, 11, 12)
-- Challenge 10: Which one is "the man"?
(28, 10, 'čovjek', true, '/man.svg', '/es_man.mp3'),
(29, 10, 'žena', false, '/woman.svg', '/es_woman.mp3'),
(30, 10, 'robot', false, '/robot.svg', '/es_robot.mp3'),
-- Challenge 11: "the man" (ASSIST)
(31, 11, 'čovjek', true, null, '/es_man.mp3'),
(32, 11, 'žena', false, null, '/es_woman.mp3'),
(33, 11, 'robot', false, null, '/es_robot.mp3'),
-- Challenge 12: Which one is "the robot"?
(34, 12, 'čovjek', false, '/man.svg', '/es_man.mp3'),
(35, 12, 'žena', false, '/woman.svg', '/es_woman.mp3'),
(36, 12, 'robot', true, '/robot.svg', '/es_robot.mp3');

-- Add challenges for lesson 2 (Verbs) for Spanish to enable progression
INSERT INTO challenges (id, lesson_id, type, question, "order") VALUES
(37, 2, 'SELECT', 'Which one of these is the "the man"?', 1),
(38, 2, 'ASSIST', '"the man"', 2),
(39, 2, 'SELECT', 'Which one of these is the "the robot"?', 3);

-- Add options for lesson 2 challenges
INSERT INTO challenge_options (id, challenge_id, text, correct, image_src, audio_src) VALUES
-- Challenge 37: Which one is "the man"?
(37, 37, 'el hombre', true, '/man.svg', '/es_man.mp3'),
(38, 37, 'la mujer', false, '/woman.svg', '/es_woman.mp3'),
(39, 37, 'el robot', false, '/robot.svg', '/es_robot.mp3'),
-- Challenge 38: "the man" (ASSIST)
(40, 38, 'el hombre', true, null, '/es_man.mp3'),
(41, 38, 'la mujer', false, null, '/es_woman.mp3'),
(42, 38, 'el robot', false, null, '/es_robot.mp3'),
-- Challenge 39: Which one is "the robot"?
(43, 39, 'el hombre', false, '/man.svg', '/es_man.mp3'),
(44, 39, 'la mujer', false, '/woman.svg', '/es_woman.mp3'),
(45, 39, 'el robot', true, '/robot.svg', '/es_robot.mp3');

-- Update sequences to current max values
SELECT setval('courses_id_seq', (SELECT MAX(id) FROM courses));
SELECT setval('units_id_seq', (SELECT MAX(id) FROM units));
SELECT setval('lessons_id_seq', (SELECT MAX(id) FROM lessons));
SELECT setval('challenges_id_seq', (SELECT MAX(id) FROM challenges));
SELECT setval('challenge_options_id_seq', (SELECT MAX(id) FROM challenge_options));

-- Verify the data
SELECT 'Courses' as table_name, COUNT(*) as count FROM courses
UNION ALL
SELECT 'Units', COUNT(*) FROM units
UNION ALL
SELECT 'Lessons', COUNT(*) FROM lessons
UNION ALL
SELECT 'Challenges', COUNT(*) FROM challenges
UNION ALL
SELECT 'Challenge Options', COUNT(*) FROM challenge_options;