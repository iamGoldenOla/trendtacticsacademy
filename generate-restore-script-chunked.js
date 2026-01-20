const fs = require('fs');
const path = require('path');

const jsonPath = path.join(__dirname, 'lms-frontend', 'public', 'data', 'vibe-coding-3.0.json');

try {
    const data = fs.readFileSync(jsonPath, 'utf8');
    const modules = JSON.parse(data);

    // Helper to generate SQL for a slice of modules
    function generateSQL(moduleSlice, partNum, partName) {
        let sql = `-- Vibe Coding Restoration Part ${partNum}: ${partName}\n`;
        sql += `-- Run this AFTER Part ${partNum - 1} (if applicable)\n\n`;

        sql += `DO $$\nDECLARE\n  v_course_id UUID;\n  v_module_id UUID;\nBEGIN\n`;

        // Get Course ID (We assume it exists from Part 1 or previous setup)
        if (partNum === 1) {
            sql += `
  -- Ensure Course Exists (Only in Part 1)
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
`;
        }

        sql += `  SELECT id INTO v_course_id FROM courses WHERE slug = 'vibe-coding';\n\n`;

        moduleSlice.forEach((mod) => {
            const moduleTitle = mod.title.replace(/'/g, "''");
            // We need to keep the original index/order from the full list? 
            // We can just use the order in the current slice, but better to use the original index?
            // Let's rely on the module 'order' in the JSON if it exists, otherwise use loop index.
            // The JSON structure matches the full array, so we need the absolute index.
            const originalIndex = modules.indexOf(mod);

            sql += `  -- Module: ${moduleTitle}\n`;
            sql += `  INSERT INTO modules (course_id, title, "order")\n`;
            sql += `  VALUES (v_course_id, '${moduleTitle}', ${originalIndex + 1})\n`;
            sql += `  ON CONFLICT (course_id, title) DO UPDATE SET "order" = ${originalIndex + 1}\n`;
            sql += `  RETURNING id INTO v_module_id;\n\n`;

            if (mod.lessons) {
                mod.lessons.forEach((lesson, lIndex) => {
                    const lessonTitle = lesson.title.replace(/'/g, "''");
                    const description = lesson.description ? lesson.description.replace(/'/g, "''") : '';
                    const videoUrl = lesson.video_url || '';

                    sql += `  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)\n`;
                    sql += `  VALUES (v_module_id, '${lessonTitle}', '${description}', '${videoUrl}', ${lIndex + 1}, 10)\n`;
                    sql += `  ON CONFLICT (module_id, title) DO UPDATE SET\n`;
                    sql += `    content = EXCLUDED.content,\n    video_url = EXCLUDED.video_url,\n    "order" = EXCLUDED."order";\n\n`;
                });
            }
        });

        sql += `END $$;\n`;
        return sql;
    }

    // Chunking
    const part1Mods = modules.slice(0, 3); // Modules 1-3
    const part2Mods = modules.slice(3, 6); // Modules 4-6
    const part3Mods = modules.slice(6);    // Modules 7-8

    fs.writeFileSync(path.join(__dirname, 'RESTORE_PART_1_FOUNDATIONS.sql'), generateSQL(part1Mods, 1, 'Foundations'));
    fs.writeFileSync(path.join(__dirname, 'RESTORE_PART_2_TOOLKIT.sql'), generateSQL(part2Mods, 2, 'Toolkit'));
    fs.writeFileSync(path.join(__dirname, 'RESTORE_PART_3_CAREER.sql'), generateSQL(part3Mods, 3, 'Career'));

    console.log('Generated 3 SQL chunks.');

} catch (err) {
    console.error('Error:', err);
}
