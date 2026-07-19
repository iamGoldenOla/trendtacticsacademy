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
  const res = await client.query(`
    SELECT c.title, COUNT(distinct m.id) as modules_count, COUNT(distinct l.id) as lessons_count
    FROM courses c
    LEFT JOIN modules m ON m.course_id = c.id
    LEFT JOIN lessons l ON l.module_id = m.id
    GROUP BY c.id, c.title;
  `);
  console.log("=== Course Stats in DB ===");
  console.log(res.rows);
  await client.end();
}

main().catch(console.error);

