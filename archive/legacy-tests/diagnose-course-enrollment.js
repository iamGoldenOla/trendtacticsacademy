#!/usr/bin/env node
/**
 * Course Enrollment Diagnostic
 * Checks course data and enrollment issues
 */

const https = require('https');

const colors = {
  reset: '\x1b[0m',
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  magenta: '\x1b[35m',
};

const log = {
  header: (text) => console.log(`\n${colors.cyan}${text}${colors.reset}`),
  success: (text) => console.log(`${colors.green}✓ ${text}${colors.reset}`),
  error: (text) => console.log(`${colors.red}✗ ${text}${colors.reset}`),
  warning: (text) => console.log(`${colors.yellow}⚠ ${text}${colors.reset}`),
  info: (text) => console.log(`${colors.cyan}ℹ ${text}${colors.reset}`),
  step: (num, text) => console.log(`\n${colors.magenta}Step ${num}: ${text}${colors.reset}`),
};

async function fetchData(url) {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => resolve(JSON.parse(data)));
    }).on('error', reject);
  });
}

async function diagnose() {
  log.header('═══════════════════════════════════════════════════════');
  log.header('  COURSE ENROLLMENT DIAGNOSTIC');
  log.header('═══════════════════════════════════════════════════════');

  log.step(1, 'Check Supabase Connection');
  log.info('Go to Supabase Console and run this SQL query:');
  console.log(`
  ${colors.yellow}SELECT id, title, slug, price, level FROM courses LIMIT 10;${colors.reset}
  `);

  log.step(2, 'Verify Course Table Structure');
  log.info('Expected columns in courses table:');
  console.log(`
  • id (UUID) - Unique identifier
  • title (TEXT) - Course name
  • slug (TEXT) - URL-friendly name (vibe-coding, prompt-engineering, facebook-ads)
  • price (NUMERIC) - Course price
  • level (TEXT) - Course level
  • description (TEXT) - Course description
  `);

  log.step(3, 'Create student_enrollments Table');
  log.info('If this table doesn\'t exist, create it:');
  console.log(`
  ${colors.yellow}CREATE TABLE student_enrollments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID REFERENCES auth.users NOT NULL,
    course_id UUID REFERENCES courses(id) NOT NULL,
    enrolled_at TIMESTAMP DEFAULT now(),
    UNIQUE(student_id, course_id)
  );
  
  ALTER TABLE student_enrollments ENABLE ROW LEVEL SECURITY;
  
  CREATE POLICY "Students can enroll"
  ON student_enrollments FOR INSERT
  WITH CHECK (auth.uid() = student_id);${colors.reset}
  `);

  log.step(4, 'Test Enrollment API');
  log.info('Open browser DevTools and run:');
  console.log(`
  ${colors.yellow}// Replace YOUR_COURSE_ID with actual course UUID
  fetch('/api/courses/YOUR_COURSE_ID/enroll', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' }
  })
  .then(r => r.json())
  .then(d => console.log(d));${colors.reset}
  `);

  log.step(5, 'What Should Happen');
  console.log(`
  ✓ Vibe Coding link → /course/{course-uuid}
  ✓ Prompt Engineering link → /course/{course-uuid}
  ✓ Facebook Ads link → /course/{course-uuid}
  ✓ All courses have matching database records
  ✓ Click "Buy" → Payment modal opens
  ✓ Complete payment → Enrolled successfully
  ✓ Redirect to course page
  `);

  log.step(6, 'Common Issues & Solutions');
  console.log(`
  ${colors.red}Issue${colors.reset}: "Failed to fetch" on enrollment
  ${colors.green}Cause${colors.reset}: API endpoint not found or course ID invalid
  ${colors.yellow}Fix${colors.reset}: Verify course UUID and backend endpoint exists

  ${colors.red}Issue${colors.reset}: Vibe Coding goes to /course-detail
  ${colors.green}Cause${colors.reset}: Course ID not being passed correctly
  ${colors.yellow}Fix${colors.reset}: Use course.id instead of hardcoded URL

  ${colors.red}Issue${colors.reset}: "Permission denied" on enrollment
  ${colors.green}Cause${colors.reset}: RLS policies blocking access
  ${colors.yellow}Fix${colors.reset}: Create RLS policies for student_enrollments

  ${colors.red}Issue${colors.reset}: Course not found error
  ${colors.green}Cause${colors.reset}: Course doesn't exist in database
  ${colors.yellow}Fix${colors.reset}: Add missing courses to Supabase
  `);

  log.step(7, 'Next Steps');
  console.log(`
  1. Open Supabase Console → SQL Editor
  2. Run the course query to get all course IDs
  3. Verify all 3 courses exist with correct data
  4. Create student_enrollments table if missing
  5. Test enrollment API from browser console
  6. Share course IDs and error messages for final fix
  `);

  log.header('═══════════════════════════════════════════════════════');
  log.info('For more details, see: COURSE_ENROLLMENT_FIX_GUIDE.md');
}

diagnose().catch(err => {
  log.error(`Diagnostic failed: ${err.message}`);
  process.exit(1);
});
