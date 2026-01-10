const fs = require('fs');
const path = require('path');

console.log('🌱 Generating lessons seed SQL from course JSON files...\n');

// Load course data
const vibeCourse = require('../../src/data/vibe-coding-course.json');
const fbCourse = require('../../src/data/facebook-ads-course.json');
const promptCourse = require('../../src/data/prompt-engineering-course.json');

// Module ID mappings (using proper UUIDs now)
const moduleMap = {
  // Vibe Coding modules
  'Module 1: Vibe Coding Foundations': '10000000-0000-0000-0000-000000000001',
  'Module 2: The Vibe Coding Ecosystem': '10000000-0000-0000-0000-000000000002',
  'Module 3: Full-Stack AI Builders': '10000000-0000-0000-0000-000000000003',
  'Module 4: AI-First IDEs': '10000000-0000-0000-0000-000000000004',
  'Module 5: Agentic Coding Tools': '10000000-0000-0000-0000-000000000005',
  'Module 6: Real-World Workflows': '10000000-0000-0000-0000-000000000006',
  'Module 7: Prompting for Software': '10000000-0000-0000-0000-000000000007',
  'Module 8: The Future of Vibe Coding': '10000000-0000-0000-0000-000000000008',
  'Module 9: Testing and Debugging with AI': '10000000-0000-0000-0000-000000000009',
  'Module 10: Version Control and Collaboration': '10000000-0000-0000-0000-000000000010',
  'Module 11: Building Real Projects': '10000000-0000-0000-0000-000000000011',
  'Module 12: Advanced Vibe Coding Techniques': '10000000-0000-0000-0000-000000000012',
  'Module 13: Course Conclusion': '10000000-0000-0000-0000-000000000013',

  // Facebook Ads modules
  'Module 1: Facebook Ads Foundations': '20000000-0000-0000-0000-000000000001',
  'Module 2: Account & Campaign Structure': '20000000-0000-0000-0000-000000000002',
  'Module 3: Audiences & Targeting (The Right Way in 2025)': '20000000-0000-0000-0000-000000000003',
  'Module 4: Ad Creatives That Convert': '20000000-0000-0000-0000-000000000004',
  'Module 5: Funnels, Pages & Conversion Flow': '20000000-0000-0000-0000-000000000005',
  'Module 6: Budgeting, Testing & Optimization': '20000000-0000-0000-0000-000000000006',
  'Module 7: Scaling & Stability': '20000000-0000-0000-0000-000000000007',
  'Module 8: Real-World Facebook Ads Workflows': '20000000-0000-0000-0000-000000000008',
  'Module 9: AI & Facebook Ads (Modern Workflow)': '20000000-0000-0000-0000-000000000009',
  'Final Module: Long-Term Mastery': '20000000-0000-0000-0000-000000000010',

  // Prompt Engineering modules
  'Module 1: Prompt Engineering Foundations': '30000000-0000-0000-0000-000000000001',
  'Module 2: Prompt Structure & Control': '30000000-0000-0000-0000-000000000002',
  'Intermediate Prompt Techniques': '30000000-0000-0000-0000-000000000003',
  'Advanced Prompt Techniques': '30000000-0000-0000-0000-000000000004',
  'Specialized Applications': '30000000-0000-0000-0000-000000000005',
  'Troubleshooting and Best Practices': '30000000-0000-0000-0000-000000000006',
  'Course Conclusion': '30000000-0000-0000-0000-000000000006'
};

// Function to escape SQL strings
function escapeSql(str) {
  if (!str) return '';
  return str.replace(/'/g, "''").replace(/\\/g, '\\\\');
}

// Function to generate INSERT statement for a lesson (matching actual schema)
function generateLessonInsert(lesson, coursePrefix, lessonNumber) {
  const moduleId = moduleMap[lesson.module_title];
  if (!moduleId) {
    console.warn(`⚠️  Warning: No module mapping for "${lesson.module_title}"`);
    return '';
  }

  // Generate UUID for lesson (using pattern: coursePrefix + lesson number)
  const lessonId = `${coursePrefix}0000000-0000-0000-0000-${String(lessonNumber).padStart(12, '0')}`;

  // Build description from multiple fields
  const description = escapeSql([
    lesson.introduction,
    lesson.big_idea,
    lesson.why_it_matters
  ].filter(Boolean).join('\n\n'));

  // Build content from all lesson data
  const contentParts = [];

  if (lesson.key_concepts && lesson.key_concepts.length > 0) {
    contentParts.push('## Key Concepts\n' + lesson.key_concepts.map(c => `- ${c}`).join('\n'));
  }

  if (lesson.real_world_example) {
    contentParts.push('## Real-World Example\n' + lesson.real_world_example);
  }

  if (lesson.practical_application) {
    contentParts.push('## Practical Application\n' + lesson.practical_application);
  }

  if (lesson.reflection_question) {
    contentParts.push('## Reflection Question\n' + lesson.reflection_question);
  }

  const content = escapeSql(contentParts.join('\n\n'));

  // Resources (combine all resource data)
  const resources = lesson.resources ? escapeSql(JSON.stringify(lesson.resources)) : '{}';

  // Video URL (if available in resources)
  const videoUrl = lesson.resources?.video?.url || '';

  return `('${lessonId}', '${moduleId}', '${escapeSql(lesson.lesson_title)}', '${description}', '${content}', ${lesson.lesson_number}, '30 minutes', '${videoUrl}', '', '${resources}', NOW(), NOW())`;
}

// Generate SQL file
let sql = `-- ============================================================================
-- SEED SCRIPT: Lessons
-- ============================================================================
-- This script seeds the lessons table for all 3 courses
-- Run this AFTER 002_seed_modules.sql
-- Generated automatically from course JSON files
-- Schema: id, module_id, title, description, content, ordering, duration,
--         video_url, video_transcript, resources, created_at, updated_at
-- ============================================================================

`;

// Add Vibe Coding lessons
sql += `-- ============================================================================
-- VIBE CODING LESSONS (26 lessons)
-- ============================================================================

INSERT INTO lessons (
  id, module_id, title, description, content, ordering, duration,
  video_url, video_transcript, resources, created_at, updated_at
) VALUES\n`;

const vibeInserts = vibeCourse.map((lesson, idx) => generateLessonInsert(lesson, '1', idx + 1)).filter(Boolean);
sql += vibeInserts.join(',\n');
sql += '\nON CONFLICT (id) DO UPDATE SET\n';
sql += '  title = EXCLUDED.title,\n';
sql += '  description = EXCLUDED.description,\n';
sql += '  content = EXCLUDED.content,\n';
sql += '  updated_at = NOW();\n\n';

console.log(`✅ Generated ${vibeInserts.length} Vibe Coding lesson inserts`);

// Add Facebook Ads lessons
sql += `-- ============================================================================
-- FACEBOOK ADS LESSONS (26 lessons)
-- ============================================================================

INSERT INTO lessons (
  id, module_id, title, description, content, ordering, duration,
  video_url, video_transcript, resources, created_at, updated_at
) VALUES\n`;

const fbInserts = fbCourse.map((lesson, idx) => generateLessonInsert(lesson, '2', idx + 1)).filter(Boolean);
sql += fbInserts.join(',\n');
sql += '\nON CONFLICT (id) DO UPDATE SET\n';
sql += '  title = EXCLUDED.title,\n';
sql += '  description = EXCLUDED.description,\n';
sql += '  content = EXCLUDED.content,\n';
sql += '  updated_at = NOW();\n\n';

console.log(`✅ Generated ${fbInserts.length} Facebook Ads lesson inserts`);

// Add Prompt Engineering lessons
sql += `-- ============================================================================
-- PROMPT ENGINEERING LESSONS (16 lessons)
-- ============================================================================

INSERT INTO lessons (
  id, module_id, title, description, content, ordering, duration,
  video_url, video_transcript, resources, created_at, updated_at
) VALUES\n`;

const peInserts = promptCourse.map((lesson, idx) => generateLessonInsert(lesson, '3', idx + 1)).filter(Boolean);
sql += peInserts.join(',\n');
sql += '\nON CONFLICT (id) DO UPDATE SET\n';
sql += '  title = EXCLUDED.title,\n';
sql += '  description = EXCLUDED.description,\n';
sql += '  content = EXCLUDED.content,\n';
sql += '  updated_at = NOW();\n\n';

console.log(`✅ Generated ${peInserts.length} Prompt Engineering lesson inserts`);

// Add verification query
sql += `-- Verify lessons were inserted
DO $$
DECLARE
  lesson_count INTEGER;
  vc_lessons INTEGER;
  fb_lessons INTEGER;
  pe_lessons INTEGER;
BEGIN
  SELECT COUNT(*) INTO lesson_count FROM lessons;
  SELECT COUNT(*) INTO vc_lessons FROM lessons WHERE id LIKE '10000000%';
  SELECT COUNT(*) INTO fb_lessons FROM lessons WHERE id LIKE '20000000%';
  SELECT COUNT(*) INTO pe_lessons FROM lessons WHERE id LIKE '30000000%';

  RAISE NOTICE '';
  RAISE NOTICE '========================================';
  RAISE NOTICE '✅ LESSONS SEEDED SUCCESSFULLY';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Total lessons in database: %', lesson_count;
  RAISE NOTICE '';
  RAISE NOTICE 'Breakdown:';
  RAISE NOTICE '- Vibe Coding: % lessons', vc_lessons;
  RAISE NOTICE '- Facebook Ads: % lessons', fb_lessons;
  RAISE NOTICE '- Prompt Engineering: % lessons', pe_lessons;
  RAISE NOTICE '';
  RAISE NOTICE '🎉 All course data seeded successfully!';
  RAISE NOTICE '========================================';
END $$;
`;

// Save to file
const outputPath = path.join(__dirname, '003_seed_lessons.sql');
fs.writeFileSync(outputPath, sql);

const totalLessons = vibeInserts.length + fbInserts.length + peInserts.length;

console.log(`\n✅ Lessons seed SQL generated: ${outputPath}`);
console.log(`📊 Total lessons: ${totalLessons}`);
console.log(`   - Vibe Coding: ${vibeInserts.length}`);
console.log(`   - Facebook Ads: ${fbInserts.length}`);
console.log(`   - Prompt Engineering: ${peInserts.length}`);

