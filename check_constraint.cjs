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
    SELECT conname, pg_get_constraintdef(oid) 
    FROM pg_constraint 
    WHERE conrelid = 'courses'::regclass AND contype = 'c';
  `);
  console.log("=== Check Constraints on courses ===");
  console.log(res.rows);
  await client.end();
}

main().catch(console.error);
