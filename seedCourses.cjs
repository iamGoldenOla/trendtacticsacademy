const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

const client = new Client({
  host: '108.128.216.176',
  port: 6543,
  user: 'postgres.doyrfbndzpcarfkulbhe',
  password: 'C7gbLy2bXp0mvcfOAsInZm',
  database: 'postgres',
  ssl: {
    rejectUnauthorized: false,
    servername: 'aws-0-eu-west-1.pooler.supabase.com'
  }
});

const scratchPath = 'C:/Users/Akinola Olujobi/.gemini/antigravity/brain/24a26cdb-ac7d-4c1d-bf20-857400faa4e8/scratch';

const courseDetails = {
  'a1b2c3d4-e5f6-7890-abcd-ef1234567890': {
    title: 'Vibe Coding - Build Apps with AI',
    subtitle: 'Learn to build applications by focusing on ideas, intention, creativity, and guidance instead of memorizing code syntax.',
    description: 'Learn to create digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax.',
    slug: 'vibe-coding',
    price: 13.333333333333334,
    category: 'Development',
    level: 'beginner'
  },
  'b2c3d4e5-f6a7-8901-bcde-f01234567891': {
    title: 'Meta Facebook & Instagram Ads Mastery',
    subtitle: 'Master the art and science of Meta advertising. Build, optimize, and scale profitable Facebook and Instagram ad campaigns in 2025.',
    description: 'Learn how to run profitable Facebook ad campaigns from scratch. Target the right audience and scale your business.',
    slug: 'facebook-ads',
    price: 13.333333333333334,
    category: 'Marketing',
    level: 'advanced'
  },
  'c3d4e5f6-a7b8-9012-cdef-012345678912': {
    title: 'Prompt Engineering Masterclass',
    subtitle: 'Master zero-shot, few-shot, and advanced prompting methods to get better results from large language models.',
    description: 'Master zero-shot, few-shot, and advanced prompting methods to get better results from large language models.',
    slug: 'prompt-engineering',
    price: 13.333333333333334,
    category: 'Development',
    level: 'beginner'
  }
};

async function main() {
  await client.connect();
  console.log("Connected to database successfully!");

  const courseIds = Object.keys(courseDetails);
  const courseIdsStr = courseIds.map(id => `'${id}'`).join(',');

  console.log("Clearing old records...");
  
  // 1. Delete from quiz_attempts
  await client.query(`
    DELETE FROM quiz_attempts WHERE lesson_id IN (
      SELECT id FROM lessons WHERE module_id IN (
        SELECT id FROM modules WHERE course_id IN (${courseIdsStr})
      )
    );
  `);
  console.log("Deleted quiz attempts.");

  // 2. Delete from quiz_questions
  await client.query(`
    DELETE FROM quiz_questions WHERE lesson_id IN (
      SELECT id FROM lessons WHERE module_id IN (
        SELECT id FROM modules WHERE course_id IN (${courseIdsStr})
      )
    );
  `);
  console.log("Deleted quiz questions.");

  // 3. Delete from lesson_progress
  await client.query(`
    DELETE FROM lesson_progress WHERE lesson_id IN (
      SELECT id FROM lessons WHERE module_id IN (
        SELECT id FROM modules WHERE course_id IN (${courseIdsStr})
      )
    );
  `);
  console.log("Deleted lesson progress.");

  // 4. Delete from lessons
  await client.query(`
    DELETE FROM lessons WHERE module_id IN (
      SELECT id FROM modules WHERE course_id IN (${courseIdsStr})
    );
  `);
  console.log("Deleted lessons.");

  // 5. Delete from modules
  await client.query(`
    DELETE FROM modules WHERE course_id IN (${courseIdsStr});
  `);
  console.log("Deleted modules.");

  // Now insert/update courses
  for (const [id, details] of Object.entries(courseDetails)) {
    console.log(`Updating course: ${details.title}...`);
    await client.query(`
      UPDATE courses 
      SET title = $1, description = $2, slug = $3, price = $4, category = $5, level = $6, updated_at = NOW()
      WHERE id = $7;
    `, [details.title, details.description, details.slug, details.price, details.category, details.level, id]);
  }

  // Load JSON lessons
  const fbLessons = JSON.parse(fs.readFileSync(path.join(scratchPath, 'facebook_ads_lessons.json'), 'utf-8'));
  const vibeLessons = JSON.parse(fs.readFileSync(path.join(scratchPath, 'vibe_coding_lessons.json'), 'utf-8'));
  const promptLessons = JSON.parse(fs.readFileSync(path.join(scratchPath, 'prompt_engineering_lessons.json'), 'utf-8'));

  // Seed Facebook Ads (b2c3d4e5-f6a7-8901-bcde-f01234567891)
  await seedCourseLessons('b2c3d4e5-f6a7-8901-bcde-f01234567891', fbLessons, 2);

  // Seed Vibe Coding (a1b2c3d4-e5f6-7890-abcd-ef1234567890)
  await seedCourseLessons('a1b2c3d4-e5f6-7890-abcd-ef1234567890', vibeLessons, 1);

  // Seed Prompt Engineering (c3d4e5f6-a7b8-9012-cdef-012345678912)
  await seedCourseLessons('c3d4e5f6-a7b8-9012-cdef-012345678912', promptLessons, 3);

  console.log("Seeding complete!");
  await client.end();
}

async function seedCourseLessons(courseId, lessonsList, prefixDigit) {
  console.log(`Seeding lessons for course ID ${courseId}...`);
  
  // 1. Extract unique modules in order
  const moduleTitles = [...new Set(lessonsList.map(l => l.module))];
  const moduleMap = new Map();

  for (let i = 0; i < moduleTitles.length; i++) {
    const title = moduleTitles[i];
    const moduleId = `${prefixDigit}0000000-0000-0000-0000-00000000000${i + 1}`;
    console.log(`  Inserting module: ${title} (${moduleId})`);
    
    await client.query(`
      INSERT INTO modules (id, course_id, title, description, order_index, created_at, updated_at)
      VALUES ($1, $2, $3, $4, $5, NOW(), NOW());
    `, [moduleId, courseId, title, `Module content for ${title}`, i + 1]);
    
    moduleMap.set(title, moduleId);
  }

  // 2. Insert lessons
  for (let i = 0; i < lessonsList.length; i++) {
    const lesson = lessonsList[i];
    const moduleId = moduleMap.get(lesson.module);
    const lessonId = `${prefixDigit}0000000-0000-0000-0000-300000000${(i + 1).toString().padStart(3, '0')}`;
    
    console.log(`    Inserting lesson: ${lesson.title} (${lessonId})`);
    
    await client.query(`
      INSERT INTO lessons (id, module_id, title, description, content, video_url, duration, order_index, is_preview, type, created_at, updated_at)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW(), NOW());
    `, [
      lessonId,
      moduleId,
      lesson.title,
      lesson.content.substring(0, 200) + '...',
      lesson.content,
      lesson.videoUrl || null,
      lesson.duration || '20 minutes',
      i + 1,
      lesson.isPreview || false,
      lesson.type || 'text'
    ]);

    // 3. Insert quiz questions if any
    if (lesson.quizQuestions && lesson.quizQuestions.length > 0) {
      for (let qIdx = 0; qIdx < lesson.quizQuestions.length; qIdx++) {
        const q = lesson.quizQuestions[qIdx];
        const questionId = `${prefixDigit}0000000-0000-0000-0000-4` + (i + 1).toString().padStart(6, '0') + qIdx.toString().padStart(5, '0');
        
        await client.query(`
          INSERT INTO quiz_questions (id, lesson_id, question, options, correct_answer, explanation, order_index, created_at, updated_at)
          VALUES ($1, $2, $3, $4, $5, $6, $7, NOW(), NOW());
        `, [
          questionId,
          lessonId,
          q.question,
          JSON.stringify(q.options),
          q.correctIndex.toString(),
          q.explanation,
          qIdx + 1
        ]);
      }
    }
  }
}

main().catch(console.error);
