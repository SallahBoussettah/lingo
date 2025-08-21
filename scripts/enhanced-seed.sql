-- Enhanced Seed Data for Lingo App
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
(4, 'Croatian', '/hr.svg'),
(5, 'German', '/de.svg'),
(6, 'Portuguese', '/pt.svg');

-- Insert units (3 units per course)
INSERT INTO units (id, course_id, title, description, "order") VALUES
-- Spanish units
(11, 1, 'Unit 1', 'Learn the basics', 1),
(12, 1, 'Unit 2', 'Common phrases', 2),
(13, 1, 'Unit 3', 'Advanced vocabulary', 3),
-- Italian units
(21, 2, 'Unit 1', 'Learn the basics', 1),
(22, 2, 'Unit 2', 'Common phrases', 2),
(23, 2, 'Unit 3', 'Advanced vocabulary', 3),
-- French units
(31, 3, 'Unit 1', 'Learn the basics', 1),
(32, 3, 'Unit 2', 'Common phrases', 2),
(33, 3, 'Unit 3', 'Advanced vocabulary', 3),
-- Croatian units
(41, 4, 'Unit 1', 'Learn the basics', 1),
(42, 4, 'Unit 2', 'Common phrases', 2),
(43, 4, 'Unit 3', 'Advanced vocabulary', 3),
-- German units
(51, 5, 'Unit 1', 'Learn the basics', 1),
(52, 5, 'Unit 2', 'Common phrases', 2),
(53, 5, 'Unit 3', 'Advanced vocabulary', 3),
-- Portuguese units
(61, 6, 'Unit 1', 'Learn the basics', 1),
(62, 6, 'Unit 2', 'Common phrases', 2),
(63, 6, 'Unit 3', 'Advanced vocabulary', 3);

-- Insert lessons (5 lessons per unit)
INSERT INTO lessons (id, unit_id, title, "order") VALUES
-- Spanish lessons (Unit 11, 12, 13)
(1, 11, 'Nouns', 1), (2, 11, 'Verbs', 2), (3, 11, 'Adjectives', 3), (4, 11, 'Phrases', 4), (5, 11, 'Practice', 5),
(6, 12, 'Nouns', 1), (7, 12, 'Verbs', 2), (8, 12, 'Adjectives', 3), (9, 12, 'Phrases', 4), (10, 12, 'Practice', 5),
(11, 13, 'Nouns', 1), (12, 13, 'Verbs', 2), (13, 13, 'Adjectives', 3), (14, 13, 'Phrases', 4), (15, 13, 'Practice', 5),
-- Italian lessons (Unit 21, 22, 23)
(16, 21, 'Nouns', 1), (17, 21, 'Verbs', 2), (18, 21, 'Adjectives', 3), (19, 21, 'Phrases', 4), (20, 21, 'Practice', 5),
(21, 22, 'Nouns', 1), (22, 22, 'Verbs', 2), (23, 22, 'Adjectives', 3), (24, 22, 'Phrases', 4), (25, 22, 'Practice', 5),
(26, 23, 'Nouns', 1), (27, 23, 'Verbs', 2), (28, 23, 'Adjectives', 3), (29, 23, 'Phrases', 4), (30, 23, 'Practice', 5),
-- French lessons (Unit 31, 32, 33)
(31, 31, 'Nouns', 1), (32, 31, 'Verbs', 2), (33, 31, 'Adjectives', 3), (34, 31, 'Phrases', 4), (35, 31, 'Practice', 5),
(36, 32, 'Nouns', 1), (37, 32, 'Verbs', 2), (38, 32, 'Adjectives', 3), (39, 32, 'Phrases', 4), (40, 32, 'Practice', 5),
(41, 33, 'Nouns', 1), (42, 33, 'Verbs', 2), (43, 33, 'Adjectives', 3), (44, 33, 'Phrases', 4), (45, 33, 'Practice', 5),
-- Croatian lessons (Unit 41, 42, 43)
(46, 41, 'Nouns', 1), (47, 41, 'Verbs', 2), (48, 41, 'Adjectives', 3), (49, 41, 'Phrases', 4), (50, 41, 'Practice', 5),
(51, 42, 'Nouns', 1), (52, 42, 'Verbs', 2), (53, 42, 'Adjectives', 3), (54, 42, 'Phrases', 4), (55, 42, 'Practice', 5),
(56, 43, 'Nouns', 1), (57, 43, 'Verbs', 2), (58, 43, 'Adjectives', 3), (59, 43, 'Phrases', 4), (60, 43, 'Practice', 5),
-- German lessons (Unit 51, 52, 53)
(61, 51, 'Nouns', 1), (62, 51, 'Verbs', 2), (63, 51, 'Adjectives', 3), (64, 51, 'Phrases', 4), (65, 51, 'Practice', 5),
(66, 52, 'Nouns', 1), (67, 52, 'Verbs', 2), (68, 52, 'Adjectives', 3), (69, 52, 'Phrases', 4), (70, 52, 'Practice', 5),
(71, 53, 'Nouns', 1), (72, 53, 'Verbs', 2), (73, 53, 'Adjectives', 3), (74, 53, 'Phrases', 4), (75, 53, 'Practice', 5),
-- Portuguese lessons (Unit 61, 62, 63)
(76, 61, 'Nouns', 1), (77, 61, 'Verbs', 2), (78, 61, 'Adjectives', 3), (79, 61, 'Phrases', 4), (80, 61, 'Practice', 5),
(81, 62, 'Nouns', 1), (82, 62, 'Verbs', 2), (83, 62, 'Adjectives', 3), (84, 62, 'Phrases', 4), (85, 62, 'Practice', 5),
(86, 63, 'Nouns', 1), (87, 63, 'Verbs', 2), (88, 63, 'Adjectives', 3), (89, 63, 'Phrases', 4), (90, 63, 'Practice', 5);

-- Insert challenges (3 challenges per first lesson of each course)
INSERT INTO challenges (id, lesson_id, type, question, "order") VALUES
-- Spanish challenges (lesson 1)
(1, 1, 'SELECT', 'Which one of these is "the man"?', 1),
(2, 1, 'ASSIST', '"the man"', 2),
(3, 1, 'SELECT', 'Which one of these is "the robot"?', 3),
-- Italian challenges (lesson 16)
(4, 16, 'SELECT', 'Which one of these is "the man"?', 1),
(5, 16, 'ASSIST', '"the man"', 2),
(6, 16, 'SELECT', 'Which one of these is "the robot"?', 3),
-- French challenges (lesson 31)
(7, 31, 'SELECT', 'Which one of these is "the man"?', 1),
(8, 31, 'ASSIST', '"the man"', 2),
(9, 31, 'SELECT', 'Which one of these is "the robot"?', 3),
-- Croatian challenges (lesson 46)
(10, 46, 'SELECT', 'Which one of these is "the man"?', 1),
(11, 46, 'ASSIST', '"the man"', 2),
(12, 46, 'SELECT', 'Which one of these is "the robot"?', 3),
-- German challenges (lesson 61)
(13, 61, 'SELECT', 'Which one of these is "the man"?', 1),
(14, 61, 'ASSIST', '"the man"', 2),
(15, 61, 'SELECT', 'Which one of these is "the robot"?', 3),
-- Portuguese challenges (lesson 76)
(16, 76, 'SELECT', 'Which one of these is "the man"?', 1),
(17, 76, 'ASSIST', '"the man"', 2),
(18, 76, 'SELECT', 'Which one of these is "the robot"?', 3);

-- Insert challenge options
INSERT INTO challenge_options (id, challenge_id, text, correct, image_src, audio_src) VALUES
-- Spanish options (challenges 1, 2, 3)
-- Challenge 1: Which one is "the man"?
(1, 1, 'el hombre', true, '/man.svg', '/audio/1_man.mp3'),
(2, 1, 'la mujer', false, '/woman.svg', '/audio/1_woman.mp3'),
(3, 1, 'el robot', false, '/robot.svg', '/audio/1_robot.mp3'),
-- Challenge 2: "the man" (ASSIST)
(4, 2, 'el hombre', true, null, '/audio/1_man.mp3'),
(5, 2, 'la mujer', false, null, '/audio/1_woman.mp3'),
(6, 2, 'el robot', false, null, '/audio/1_robot.mp3'),
-- Challenge 3: Which one is "the robot"?
(7, 3, 'el hombre', false, '/man.svg', '/audio/1_man.mp3'),
(8, 3, 'la mujer', false, '/woman.svg', '/audio/1_woman.mp3'),
(9, 3, 'el robot', true, '/robot.svg', '/audio/1_robot.mp3'),

-- Italian options (challenges 4, 5, 6)
-- Challenge 4: Which one is "the man"?
(10, 4, 'l''uomo', true, '/man.svg', '/audio/2_man.mp3'),
(11, 4, 'la donna', false, '/woman.svg', '/audio/2_woman.mp3'),
(12, 4, 'il robot', false, '/robot.svg', '/audio/2_robot.mp3'),
-- Challenge 5: "the man" (ASSIST)
(13, 5, 'l''uomo', true, null, '/audio/2_man.mp3'),
(14, 5, 'la donna', false, null, '/audio/2_woman.mp3'),
(15, 5, 'il robot', false, null, '/audio/2_robot.mp3'),
-- Challenge 6: Which one is "the robot"?
(16, 6, 'l''uomo', false, '/man.svg', '/audio/2_man.mp3'),
(17, 6, 'la donna', false, '/woman.svg', '/audio/2_woman.mp3'),
(18, 6, 'il robot', true, '/robot.svg', '/audio/2_robot.mp3'),

-- French options (challenges 7, 8, 9)
-- Challenge 7: Which one is "the man"?
(19, 7, 'l''homme', true, '/man.svg', '/audio/3_man.mp3'),
(20, 7, 'la femme', false, '/woman.svg', '/audio/3_woman.mp3'),
(21, 7, 'le robot', false, '/robot.svg', '/audio/3_robot.mp3'),
-- Challenge 8: "the man" (ASSIST)
(22, 8, 'l''homme', true, null, '/audio/3_man.mp3'),
(23, 8, 'la femme', false, null, '/audio/3_woman.mp3'),
(24, 8, 'le robot', false, null, '/audio/3_robot.mp3'),
-- Challenge 9: Which one is "the robot"?
(25, 9, 'l''homme', false, '/man.svg', '/audio/3_man.mp3'),
(26, 9, 'la femme', false, '/woman.svg', '/audio/3_woman.mp3'),
(27, 9, 'le robot', true, '/robot.svg', '/audio/3_robot.mp3'),

-- Croatian options (challenges 10, 11, 12)
-- Challenge 10: Which one is "the man"?
(28, 10, 'čovjek', true, '/man.svg', '/audio/4_man.mp3'),
(29, 10, 'žena', false, '/woman.svg', '/audio/4_woman.mp3'),
(30, 10, 'robot', false, '/robot.svg', '/audio/4_robot.mp3'),
-- Challenge 11: "the man" (ASSIST)
(31, 11, 'čovjek', true, null, '/audio/4_man.mp3'),
(32, 11, 'žena', false, null, '/audio/4_woman.mp3'),
(33, 11, 'robot', false, null, '/audio/4_robot.mp3'),
-- Challenge 12: Which one is "the robot"?
(34, 12, 'čovjek', false, '/man.svg', '/audio/4_man.mp3'),
(35, 12, 'žena', false, '/woman.svg', '/audio/4_woman.mp3'),
(36, 12, 'robot', true, '/robot.svg', '/audio/4_robot.mp3'),

-- German options (challenges 13, 14, 15)
-- Challenge 13: Which one is "the man"?
(37, 13, 'der Mann', true, '/man.svg', '/audio/5_man.mp3'),
(38, 13, 'die Frau', false, '/woman.svg', '/audio/5_woman.mp3'),
(39, 13, 'der Roboter', false, '/robot.svg', '/audio/5_robot.mp3'),
-- Challenge 14: "the man" (ASSIST)
(40, 14, 'der Mann', true, null, '/audio/5_man.mp3'),
(41, 14, 'die Frau', false, null, '/audio/5_woman.mp3'),
(42, 14, 'der Roboter', false, null, '/audio/5_robot.mp3'),
-- Challenge 15: Which one is "the robot"?
(43, 15, 'der Mann', false, '/man.svg', '/audio/5_man.mp3'),
(44, 15, 'die Frau', false, '/woman.svg', '/audio/5_woman.mp3'),
(45, 15, 'der Roboter', true, '/robot.svg', '/audio/5_robot.mp3'),

-- Portuguese options (challenges 16, 17, 18)
-- Challenge 16: Which one is "the man"?
(46, 16, 'o homem', true, '/man.svg', '/audio/6_man.mp3'),
(47, 16, 'a mulher', false, '/woman.svg', '/audio/6_woman.mp3'),
(48, 16, 'o robô', false, '/robot.svg', '/audio/6_robot.mp3'),
-- Challenge 17: "the man" (ASSIST)
(49, 17, 'o homem', true, null, '/audio/6_man.mp3'),
(50, 17, 'a mulher', false, null, '/audio/6_woman.mp3'),
(51, 17, 'o robô', false, null, '/audio/6_robot.mp3'),
-- Challenge 18: Which one is "the robot"?
(52, 18, 'o homem', false, '/man.svg', '/audio/6_man.mp3'),
(53, 18, 'a mulher', false, '/woman.svg', '/audio/6_woman.mp3'),
(54, 18, 'o robô', true, '/robot.svg', '/audio/6_robot.mp3');

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

-- Show course summary
SELECT 
    c.title as course,
    COUNT(DISTINCT u.id) as units,
    COUNT(DISTINCT l.id) as lessons,
    COUNT(DISTINCT ch.id) as challenges
FROM courses c
LEFT JOIN units u ON c.id = u.course_id
LEFT JOIN lessons l ON u.id = l.unit_id
LEFT JOIN challenges ch ON l.id = ch.lesson_id
GROUP BY c.id, c.title
ORDER BY c.id;