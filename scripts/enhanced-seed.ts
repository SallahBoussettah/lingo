import "dotenv/config";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";

import * as schema from "../db/schema";

const sql = postgres(process.env.DATABASE_URL!);
const db = drizzle(sql, { schema });

const main = async () => {
  try {
    console.log("Seeding database with enhanced content");

    // Clear existing data
    await db.delete(schema.courses);
    await db.delete(schema.userProgress);
    await db.delete(schema.units);
    await db.delete(schema.lessons);
    await db.delete(schema.challenges);
    await db.delete(schema.challengeOptions);
    await db.delete(schema.challengeProgress);
    await db.delete(schema.userSubscription);

    // Insert courses
    await db.insert(schema.courses).values([
      {
        id: 1,
        title: "Spanish",
        imageSrc: "/es.svg",
      },
      {
        id: 2,
        title: "Italian",
        imageSrc: "/it.svg",
      },
      {
        id: 3,
        title: "French",
        imageSrc: "/fr.svg",
      },
      {
        id: 4,
        title: "Croatian",
        imageSrc: "/hr.svg",
      },
      {
        id: 5,
        title: "German",
        imageSrc: "/de.svg",
      },
      {
        id: 6,
        title: "Portuguese",
        imageSrc: "/pt.svg",
      },
    ]);

    // Insert units for all courses
    const units = [];
    for (let courseId = 1; courseId <= 6; courseId++) {
      units.push(
        {
          id: courseId * 10 + 1,
          courseId,
          title: "Unit 1",
          description: "Learn the basics",
          order: 1,
        },
        {
          id: courseId * 10 + 2,
          courseId,
          title: "Unit 2",
          description: "Common phrases",
          order: 2,
        },
        {
          id: courseId * 10 + 3,
          courseId,
          title: "Unit 3",
          description: "Advanced vocabulary",
          order: 3,
        }
      );
    }
    await db.insert(schema.units).values(units);

    // Insert lessons for each unit
    const lessons = [];
    let lessonId = 1;
    for (let courseId = 1; courseId <= 6; courseId++) {
      for (let unitOrder = 1; unitOrder <= 3; unitOrder++) {
        const unitId = courseId * 10 + unitOrder;
        lessons.push(
          {
            id: lessonId++,
            unitId,
            order: 1,
            title: "Nouns",
          },
          {
            id: lessonId++,
            unitId,
            order: 2,
            title: "Verbs",
          },
          {
            id: lessonId++,
            unitId,
            order: 3,
            title: "Adjectives",
          },
          {
            id: lessonId++,
            unitId,
            order: 4,
            title: "Phrases",
          },
          {
            id: lessonId++,
            unitId,
            order: 5,
            title: "Practice",
          }
        );
      }
    }
    await db.insert(schema.lessons).values(lessons);

    // Language-specific vocabulary
    const vocabularies = {
      1: { // Spanish
        man: "el hombre",
        woman: "la mujer",
        robot: "el robot",
        hello: "hola",
        goodbye: "adiós",
        please: "por favor",
        thankyou: "gracias"
      },
      2: { // Italian
        man: "l'uomo",
        woman: "la donna",
        robot: "il robot",
        hello: "ciao",
        goodbye: "arrivederci",
        please: "per favore",
        thankyou: "grazie"
      },
      3: { // French
        man: "l'homme",
        woman: "la femme",
        robot: "le robot",
        hello: "bonjour",
        goodbye: "au revoir",
        please: "s'il vous plaît",
        thankyou: "merci"
      },
      4: { // Croatian
        man: "čovjek",
        woman: "žena",
        robot: "robot",
        hello: "zdravo",
        goodbye: "doviđenja",
        please: "molim",
        thankyou: "hvala"
      },
      5: { // German
        man: "der Mann",
        woman: "die Frau",
        robot: "der Roboter",
        hello: "hallo",
        goodbye: "auf Wiedersehen",
        please: "bitte",
        thankyou: "danke"
      },
      6: { // Portuguese
        man: "o homem",
        woman: "a mulher",
        robot: "o robô",
        hello: "olá",
        goodbye: "tchau",
        please: "por favor",
        thankyou: "obrigado"
      }
    };

    // Insert challenges for first lesson of each course
    const challenges = [];
    const challengeOptions = [];
    let challengeId = 1;
    let optionId = 1;

    for (let courseId = 1; courseId <= 6; courseId++) {
      const vocab = vocabularies[courseId as keyof typeof vocabularies];
      const firstLessonId = (courseId - 1) * 15 + 1; // First lesson of first unit for each course

      // Challenge 1: Which one is "the man"?
      challenges.push({
        id: challengeId,
        lessonId: firstLessonId,
        type: "SELECT" as const,
        order: 1,
        question: 'Which one of these is "the man"?',
      });

      challengeOptions.push(
        {
          id: optionId++,
          challengeId,
          imageSrc: "/man.svg",
          correct: true,
          text: vocab.man,
          audioSrc: `/audio/${courseId}_man.mp3`,
        },
        {
          id: optionId++,
          challengeId,
          imageSrc: "/woman.svg",
          correct: false,
          text: vocab.woman,
          audioSrc: `/audio/${courseId}_woman.mp3`,
        },
        {
          id: optionId++,
          challengeId,
          imageSrc: "/robot.svg",
          correct: false,
          text: vocab.robot,
          audioSrc: `/audio/${courseId}_robot.mp3`,
        }
      );
      challengeId++;

      // Challenge 2: Assist type
      challenges.push({
        id: challengeId,
        lessonId: firstLessonId,
        type: "ASSIST" as const,
        order: 2,
        question: '"the man"',
      });

      challengeOptions.push(
        {
          id: optionId++,
          challengeId,
          correct: true,
          text: vocab.man,
          audioSrc: `/audio/${courseId}_man.mp3`,
        },
        {
          id: optionId++,
          challengeId,
          correct: false,
          text: vocab.woman,
          audioSrc: `/audio/${courseId}_woman.mp3`,
        },
        {
          id: optionId++,
          challengeId,
          correct: false,
          text: vocab.robot,
          audioSrc: `/audio/${courseId}_robot.mp3`,
        }
      );
      challengeId++;

      // Challenge 3: Which one is "the robot"?
      challenges.push({
        id: challengeId,
        lessonId: firstLessonId,
        type: "SELECT" as const,
        order: 3,
        question: 'Which one of these is "the robot"?',
      });

      challengeOptions.push(
        {
          id: optionId++,
          challengeId,
          imageSrc: "/man.svg",
          correct: false,
          text: vocab.man,
          audioSrc: `/audio/${courseId}_man.mp3`,
        },
        {
          id: optionId++,
          challengeId,
          imageSrc: "/woman.svg",
          correct: false,
          text: vocab.woman,
          audioSrc: `/audio/${courseId}_woman.mp3`,
        },
        {
          id: optionId++,
          challengeId,
          imageSrc: "/robot.svg",
          correct: true,
          text: vocab.robot,
          audioSrc: `/audio/${courseId}_robot.mp3`,
        }
      );
      challengeId++;
    }

    await db.insert(schema.challenges).values(challenges);
    await db.insert(schema.challengeOptions).values(challengeOptions);

    console.log("Enhanced seeding finished successfully!");
    console.log(`Created ${challenges.length} challenges across 6 languages`);
    console.log(`Created ${challengeOptions.length} challenge options`);
  } catch (error) {
    console.error("Seeding error:", error);
    throw new Error("Failed to seed the database");
  }
};

main();