const fs = require('fs');
const path = require('path');

const jsonPath = path.join(__dirname, 'lms-frontend', 'public', 'data', 'vibe-coding-3.0.json');
const outputPath = path.join(__dirname, 'RESTORE_VIBE_CODING.sql');

try {
    const data = fs.readFileSync(jsonPath, 'utf8');
    const modules = JSON.parse(data);

    let sql = `
-- Restore Vibe Coding Course Content
-- Generated automatically from vibe-coding-3.0.json

-- 1. Ensure Course Exists
INSERT INTO courses (id, title, description, image_url, slug, price, level, category)
VALUES (
  '550e8400-e29b-41d4-a716-446655440000',
  'Vibe Coding',
  'Master the art of AI-assisted programming. From Zero to One with Cursor, Replit, and V0.',
  '/images/vibe-coding-thumb.jpg',
  'vibe-coding',
  49.99,
  'All Levels',
  'AI Development'
)
ON CONFLICT (slug) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- 2. Variables for IDs
DO $$
DECLARE
  v_course_id UUID;
  v_module_id UUID;
BEGIN
  -- Get Course ID
  SELECT id INTO v_course_id FROM courses WHERE slug = 'vibe-coding';

  -- 3. Delete existing content for this course to prevent duplicates?
  -- ideally we shouldn't if we want to preserve student progress, but if the structure changed, we might have to.
  -- For now, let's assume we are purely adding/updating based on title or clearing old stuff first if NUKE was run.
  -- The user likely ran NUKE, so we are fresh.
  
  -- But just in case, let's just insert modules and lessons.
  
`;

    modules.forEach((mod, mIndex) => {
        // Generate a consistent UUID for the module based on index (or just let DB gen it, but we need it for lessons)
        // We will use a declared variable loop approach or just simple INSERTS with RETURNING?
        // RETURNING is hard in a big script block.
        // Let's use scalar subqueries or temporary tables? 
        // Simplest: Insert Module, then Select it back by title (assuming unique titles per course).

        const moduleTitle = mod.title.replace(/'/g, "''");

        sql += `
  -- Module ${mIndex + 1}: ${moduleTitle}
  INSERT INTO modules (course_id, title, "order")
  VALUES (v_course_id, '${moduleTitle}', ${mIndex + 1})
  ON CONFLICT (course_id, title) DO UPDATE SET "order" = ${mIndex + 1}
  RETURNING id INTO v_module_id;
`;

        if (mod.lessons) {
            mod.lessons.forEach((lesson, lIndex) => {
                const lessonTitle = lesson.title.replace(/'/g, "''");
                const description = lesson.description ? lesson.description.replace(/'/g, "''") : '';
                const videoUrl = lesson.video_url || '';
                const summary = lesson.summary ? lesson.summary.replace(/'/g, "''") : '';

                sql += `
  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, '${lessonTitle}', '${description}', '${videoUrl}', ${lIndex + 1}, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";
`;
            });
        }
    });

    sql += `
END $$;
`;

    fs.writeFileSync(outputPath, sql);
    console.log(`Successfully generated ${outputPath}`);

} catch (err) {
    console.error('Error generating SQL:', err);
}
