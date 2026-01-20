
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function checkContent() {
    console.log('Checking Vibe Coding content...');

    // 1. Get Course ID
    const { data: courses, error: courseError } = await supabase
        .from('courses')
        .select('id, title')
        .ilike('title', '%Vibe Coding%')
        .limit(1);

    if (courseError) {
        console.error('Course Error:', courseError);
        return;
    }
    if (!courses || courses.length === 0) {
        console.error('Vibe Coding course not found');
        return;
    }

    const courseId = courses[0].id;
    console.log(`Course Found: ${courses[0].title} (${courseId})`);

    // 2. Get Lessons via Modules
    const { data: modules, error: modError } = await supabase
        .from('modules')
        .select(`
            id, 
            title, 
            ordering,
            lessons:lessons!lessons_module_id_fkey (
                id, 
                title, 
                ordering, 
                playground, 
                quizzes,
                summary,
                case_studies,
                resources
            )
        `)
        .eq('course_id', courseId)
        .order('ordering');

    if (modError) {
        console.error('Module Error:', modError);
        return;
    }

    let emptyPlaygrounds = 0;
    let totalLessons = 0;

    modules.forEach(mod => {
        console.log(`\nModule: ${mod.title}`);
        if (!mod.lessons) return;

        mod.lessons.sort((a, b) => a.ordering - b.ordering).forEach(l => {
            totalLessons++;
            const hasPlayground = !!l.playground;
            const hasQuiz = !!l.quizzes;
            const hasSummary = !!l.summary;

            if (hasQuiz) {
                console.log('Quiz Content:', JSON.stringify(l.quizzes, null, 2));
                process.exit(0);
            }

            console.log(`  - [${l.title}]`);
            console.log(`    Playground: ${hasPlayground ? '✅' : '❌'}`);
            console.log(`    Quiz:       ${hasQuiz ? '✅' : '❌'}`);
            console.log(`    Summary:    ${hasSummary ? '✅' : '❌'}`);
        });
    });

    console.log(`\nTotal Lessons: ${totalLessons}`);
    console.log(`Lessons Missing Playground: ${emptyPlaygrounds}`);
}

checkContent();
