const { Client } = require('pg');

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

async function main() {
  await client.connect();
  
  const coursesRes = await client.query('SELECT id, title, slug, price FROM courses;');
  console.log("=== Courses ===");
  console.log(coursesRes.rows);

  const modulesRes = await client.query('SELECT course_id, COUNT(*) FROM modules GROUP BY course_id;');
  console.log("=== Modules Count ===");
  console.log(modulesRes.rows);

  const lessonsRes = await client.query('SELECT m.course_id, COUNT(*) FROM lessons l JOIN modules m ON l.module_id = m.id GROUP BY m.course_id;');
  console.log("=== Lessons Count ===");
  console.log(lessonsRes.rows);

  const quizQuestionsRes = await client.query('SELECT m.course_id, COUNT(*) FROM quiz_questions q JOIN lessons l ON q.lesson_id = l.id JOIN modules m ON l.module_id = m.id GROUP BY m.course_id;');
  console.log("=== Quiz Questions Count ===");
  console.log(quizQuestionsRes.rows);

  await client.end();
}

main().catch(console.error);
