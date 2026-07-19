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
    SELECT id, title, type, order_index FROM lessons 
    WHERE module_id = '20000000-0000-0000-0000-000000000001'
    ORDER BY order_index;
  `);
  console.log("=== Lessons in FB Module 1 ===");
  console.log(res.rows);
  await client.end();
}

main().catch(console.error);
