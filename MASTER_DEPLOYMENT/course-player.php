<?php
// Course Player - PHP wrapper to serve HTML content
header('Content-Type: text/html; charset=utf-8');
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Learner - Trendtactics Academy</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/@supabase/supabase-js@2"></script>
    <style>
        :root {
            --primary: #00D9FF;
            --primary-dark: #0096AF;
            --bg-deep: #050B18;
            --bg-card: #0A1628;
            --text-main: #FFFFFF;
            --text-dim: #A0AEC0;
            --border: rgba(255, 255, 255, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-deep);
            color: var(--text-main);
            line-height: 1.6;
        }

        .layout {
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        .sidebar {
            width: 350px;
            background: var(--bg-card);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid var(--border);
        }

        .sidebar-content {
            flex: 1;
            overflow-y: auto;
            padding: 10px;
        }

        .back-link {
            color: var(--primary);
            text-decoration: none;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .course-title {
            font-size: 1.2rem;
            font-weight: 700;
        }

        .module-group {
            margin-bottom: 15px;
        }

        .module-title {
            padding: 10px;
            font-size: 0.85rem;
            text-transform: uppercase;
            color: var(--text-dim);
            letter-spacing: 1px;
            font-weight: 600;
        }

        .lesson-item {
            padding: 12px 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            margin-bottom: 4px;
            font-size: 0.95rem;
            color: var(--text-dim);
        }

        .lesson-item:hover {
            background: rgba(0, 217, 255, 0.05);
            color: white;
        }

        .lesson-item.active {
            background: var(--primary);
            color: var(--bg-deep);
            font-weight: 600;
        }

        .main-content {
            flex: 1;
            overflow-y: auto;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .content-container {
            width: 100%;
            max-width: 900px;
        }

        .video-wrapper {
            width: 100%;
            aspect-ratio: 16/9;
            background: black;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            border: 1px solid var(--border);
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        .lesson-header {
            margin-bottom: 25px;
        }

        .lesson-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .lesson-desc {
            color: var(--text-dim);
            white-space: pre-wrap;
        }

        .loading-screen {
            position: fixed;
            inset: 0;
            background: var(--bg-deep);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid rgba(0, 217, 255, 0.2);
            border-top: 4px solid var(--primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        @media (max-width: 1024px) {
            .layout {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                height: 300px;
            }

            .main-content {
                padding: 20px;
            }
        }
    </style>
</head>

<body>

    <div id="loading" class="loading-screen">
        <div style="text-align:center">
            <div class="spinner"></div>
            <p style="margin-top:15px; color:var(--text-dim)">Loading Course Content...</p>
        </div>
    </div>

    <div class="layout" id="appLayout" style="display:none">
        <aside class="sidebar">
            <div class="sidebar-header">
                <a href="/dashboard" class="back-link">← Back to Dashboard</a>
                <h1 class="course-title" id="sidebarCourseTitle">Course Title</h1>
            </div>
            <div class="sidebar-content" id="sidebarContent">
            </div>
        </aside>

        <main class="main-content">
            <div class="content-container">
                <div class="video-wrapper" id="videoArea">
                </div>

                <div class="lesson-header">
                    <h1 class="lesson-title" id="lessonTitle">Lesson Title</h1>
                    <p class="lesson-desc" id="lessonDesc">Lesson description...</p>
                </div>

                <div style="margin-top:40px; display:flex; justify-content:space-between">
                    <button id="prevBtn" class="lesson-item"
                        style="width:auto; padding: 10px 25px; background: rgba(255,255,255,0.1); border: 1px solid var(--border); color: white;">Previous</button>
                    <button id="nextBtn" class="lesson-item"
                        style="width:auto; padding: 10px 25px; background: var(--primary); color:var(--bg-deep); border:none">Next
                        Lesson →</button>
                </div>
            </div>
        </main>
    </div>

    <script>
        const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
        const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';
        const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

        let state = {
            course: null,
            lessons: [],
            currentLessonId: null,
            user: null
        };

        async function generateVibeCodingCourse(courseId) {
            const modules = [
                { title: 'Introduction to Vibe Coding', ordering: 1 },
                { title: 'Setting Up Your Environment', ordering: 2 },
                { title: 'Basic Concepts', ordering: 3 },
                { title: 'Advanced Techniques', ordering: 4 },
                { title: 'Real-World Applications', ordering: 5 },
                { title: 'Best Practices', ordering: 6 }
            ];

            const lessonTitles = [
                'What is Vibe Coding?', 'Why Vibe Coding Matters', 'Getting Started with Vibe Coding',
                'Installing Development Tools', 'Configuring Your Workspace', 'Understanding the Basics',
                'Variables and Data Types', 'Control Structures', 'Functions and Methods', 'Object-Oriented Programming',
                'Error Handling', 'Debugging Techniques', 'Working with APIs', 'Database Integration',
                'Version Control', 'Testing Your Code', 'Deployment Strategies', 'Performance Optimization',
                'Security Best Practices', 'Code Reviews', 'Collaboration Tools', 'Continuous Integration',
                'Advanced Frameworks', 'Mobile Development', 'Web Applications', 'Final Project'
            ];

            await createModulesAndLessons(courseId, modules, lessonTitles);
        }

        async function generateFacebookAdsCourse(courseId) {
            const modules = [
                { title: 'Facebook Ads Fundamentals', ordering: 1 },
                { title: 'Campaign Setup', ordering: 2 },
                { title: 'Audience Targeting', ordering: 3 },
                { title: 'Ad Creative', ordering: 4 },
                { title: 'Budget and Bidding', ordering: 5 },
                { title: 'Analytics and Optimization', ordering: 6 }
            ];

            const lessonTitles = [
                'Introduction to Facebook Advertising', 'Facebook Ads Manager Overview', 'Understanding Ad Objectives',
                'Campaign Structure', 'Setting Up Your First Campaign', 'Ad Set Configuration', 'Creating Effective Ads',
                'Audience Insights', 'Custom Audience Creation', 'Lookalike Audiences', 'Interest-Based Targeting',
                'Demographic Targeting', 'Geographic Targeting', 'Ad Formats and Types', 'Writing Compelling Ad Copy',
                'Designing Eye-Catching Creatives', 'A/B Testing Strategies', 'Budget Allocation', 'Bidding Strategies',
                'Cost Control', 'Performance Metrics', 'Conversion Tracking', 'A/B Testing and Optimization',
                'Retargeting Campaigns', 'Advanced Strategies', 'Scaling Successful Campaigns'
            ];

            await createModulesAndLessons(courseId, modules, lessonTitles);
        }

        async function generatePromptEngineeringCourse(courseId) {
            const modules = [
                { title: 'Prompt Engineering Basics', ordering: 1 },
                { title: 'Advanced Techniques', ordering: 2 },
                { title: 'Specialized Applications', ordering: 3 },
                { title: 'Best Practices', ordering: 4 }
            ];

            const lessonTitles = [
                'What is Prompt Engineering?', 'Understanding AI Language Models', 'Basic Prompt Structure',
                'Context and Instructions', 'Role-Based Prompting', 'Chain of Thought Prompting', 'Few-Shot Learning',
                'Zero-Shot Prompting', 'Prompt Optimization', 'Handling Ambiguity', 'Creative Writing Prompts',
                'Technical Writing Prompts', 'Code Generation Prompts', 'Data Analysis Prompts',
                'Research and Summarization', 'Ethical Considerations'
            ];

            await createModulesAndLessons(courseId, modules, lessonTitles);
        }

        async function createModulesAndLessons(courseId, modules, lessonTitles) {
            let lessonIndex = 0;

            for (const moduleData of modules) {
                const { data: module, error: moduleError } = await supabaseClient
                    .from('modules')
                    .insert([{
                        course_id: courseId,
                        title: moduleData.title,
                        ordering: moduleData.ordering,
                        created_at: new Date().toISOString(),
                        updated_at: new Date().toISOString()
                    }])
                    .select()
                    .single();

                if (moduleError) {
                    console.error('Error creating module:', moduleError);
                    throw new Error(`Failed to create module: ${moduleData.title}`);
                }

                const lessonsPerModule = Math.ceil(lessonTitles.length / modules.length);
                const startIndex = lessonIndex;
                const endIndex = Math.min(startIndex + lessonsPerModule, lessonTitles.length);

                for (let i = startIndex; i < endIndex; i++) {
                    const { error: lessonError } = await supabaseClient
                        .from('lessons')
                        .insert([{
                            module_id: module.id,
                            course_id: courseId,
                            title: lessonTitles[i],
                            content: `Comprehensive lesson content for: ${lessonTitles[i]}`,
                            ordering: i + 1,
                            created_at: new Date().toISOString(),
                            updated_at: new Date().toISOString()
                        }]);

                    if (lessonError) {
                        console.error('Error creating lesson:', lessonError);
                        throw new Error(`Failed to create lesson: ${lessonTitles[i]}`);
                    }
                }

                lessonIndex = endIndex;
            }
        }

        async function init() {
            const urlParams = new URLSearchParams(window.location.search);
            const courseId = urlParams.get('id');
            const lessonId = urlParams.get('lesson');

            if (!courseId) {
                alert('No course ID provided');
                window.location.href = '/dashboard';
                return;
            }

            const { data: { user } } = await supabaseClient.auth.getUser();
            if (!user) {
                window.location.href = '/login?redirect=' + encodeURIComponent(window.location.href);
                return;
            }
            state.user = user;

            try {
                const { data: course, error: courseError } = await supabaseClient
                    .from('courses')
                    .select('*')
                    .eq('id', courseId)
                    .single();

                if (courseError || !course) {
                    throw new Error(`Course not found`);
                }

                const { data: modules, error: modulesError } = await supabaseClient
                    .from('modules')
                    .select('*')
                    .eq('course_id', courseId)
                    .order('ordering', { ascending: true });

                if (modulesError) {
                    throw new Error(`Failed to load modules`);
                }

                const modulesWithLessons = [];
                if (modules && Array.isArray(modules)) {
                    for (const module of modules) {
                        const { data: lessons, error: lessonsError } = await supabaseClient
                            .from('lessons')
                            .select('*')
                            .eq('module_id', module.id)
                            .order('ordering', { ascending: true });

                        modulesWithLessons.push({
                            ...module,
                            lessons: lessons && Array.isArray(lessons) ? lessons : []
                        });
                    }
                }

                state.course = {
                    ...course,
                    modules: modulesWithLessons
                };

                let flatLessons = [];
                if (state.course.modules) {
                    state.course.modules.sort((a, b) => (a.ordering || 0) - (b.ordering || 0)).forEach(mod => {
                        if (mod.lessons && Array.isArray(mod.lessons)) {
                            mod.lessons.sort((a, b) => (a.ordering || 0) - (b.ordering || 0)).forEach(less => {
                                flatLessons.push({ ...less, moduleTitle: mod.title });
                            });
                        }
                    });
                }
                state.lessons = flatLessons;

                if (flatLessons.length === 0) {
                    document.getElementById('loading').innerHTML = `
                        <div style="text-align:center">
                            <div class="spinner"></div>
                            <p style="margin-top:15px; color:var(--text-dim)">Generating course content...</p>
                        </div>
                    `;

                    try {
                        const courseType = course.title.toLowerCase();

                        if (courseType.includes('vibe coding')) {
                            await generateVibeCodingCourse(courseId);
                        } else if (courseType.includes('facebook ads')) {
                            await generateFacebookAdsCourse(courseId);
                        } else if (courseType.includes('prompt engineering')) {
                            await generatePromptEngineeringCourse(courseId);
                        } else {
                            throw new Error(`Course generation is only available for: Vibe Coding, Facebook Ads, and Prompt Engineering courses.`);
                        }

                        window.location.reload();
                        return;
                    } catch (genError) {
                        document.getElementById('loading').innerHTML = `
                            <div style="text-align:center">
                                <div style="font-size:3rem; margin-bottom:20px;">⚠️</div>
                                <p style="color:var(--text-dim); margin-bottom:20px; font-size:1.1rem;">Failed to generate course content.</p>
                                <p style="color:var(--text-dim); margin-bottom:30px; font-size:0.9rem;">${genError.message}</p>
                                <button onclick="window.location.reload()" style="background:var(--primary); color:var(--bg-deep); padding:12px 30px; border:none; border-radius:8px; cursor:pointer; font-weight:600; margin-right:10px;">Retry</button>
                                <a href="/dashboard" style="display:inline-block; margin-top:15px; color:var(--primary); text-decoration:none; padding:12px 30px;">Back to Dashboard</a>
                            </div>
                        `;
                        return;
                    }
                }

                state.currentLessonId = lessonId || flatLessons[0].id;

                renderSidebar();
                renderLesson(state.currentLessonId);

                document.getElementById('loading').style.display = 'none';
                document.getElementById('appLayout').style.display = 'flex';
                document.getElementById('sidebarCourseTitle').textContent = course.title;

            } catch (err) {
                console.error(err);
                alert('Error loading course: ' + err.message);
                window.location.href = '/dashboard';
            }
        }

        function renderSidebar() {
            const container = document.getElementById('sidebarContent');
            container.innerHTML = '';

            let currentModule = null;
            state.lessons.forEach(lesson => {
                if (lesson.moduleTitle !== currentModule) {
                    currentModule = lesson.moduleTitle;
                    const modDiv = document.createElement('div');
                    modDiv.className = 'module-title';
                    modDiv.textContent = currentModule;
                    container.appendChild(modDiv);
                }

                const item = document.createElement('div');
                item.className = `lesson-item ${lesson.id === state.currentLessonId ? 'active' : ''}`;
                item.innerHTML = `<span style="margin-right:10px">▶</span> ${lesson.title}`;
                item.onclick = () => renderLesson(lesson.id);
                container.appendChild(item);
            });
        }

        function renderLesson(id) {
            const lesson = state.lessons.find(l => l.id === id);
            if (!lesson) return;

            state.currentLessonId = id;

            const url = new URL(window.location);
            url.searchParams.set('lesson', id);
            window.history.pushState({}, '', url);

            document.getElementById('lessonTitle').textContent = lesson.title;
            document.getElementById('lessonDesc').innerHTML = lesson.content || 'No description available.';

            const videoArea = document.getElementById('videoArea');
            if (lesson.video_url) {
                let embedUrl = lesson.video_url;
                if (embedUrl.includes('youtube.com/watch?v=')) {
                    embedUrl = embedUrl.replace('watch?v=', 'embed/');
                } else if (embedUrl.includes('youtu.be/')) {
                    embedUrl = embedUrl.replace('youtu.be/', 'youtube.com/embed/');
                }
                videoArea.innerHTML = `<iframe src="${embedUrl}" allowfullscreen></iframe>`;
            } else {
                videoArea.innerHTML = `<div style="display:flex; height:100%; align-items:center; justify-content:center; color:var(--text-dim)">No video available for this lesson</div>`;
            }

            const currentIndex = state.lessons.findIndex(l => l.id === id);
            const prevBtn = document.getElementById('prevBtn');
            const nextBtn = document.getElementById('nextBtn');

            prevBtn.style.visibility = currentIndex > 0 ? 'visible' : 'hidden';
            prevBtn.onclick = () => renderLesson(state.lessons[currentIndex - 1].id);

            if (currentIndex < state.lessons.length - 1) {
                nextBtn.textContent = 'Next Lesson →';
                nextBtn.onclick = () => renderLesson(state.lessons[currentIndex + 1].id);
            } else {
                nextBtn.textContent = 'Finish Course 🎉';
                nextBtn.onclick = () => window.location.href = '/dashboard';
            }

            renderSidebar();
            window.scrollTo(0, 0);
        }

        init();
    </script>
</body>

</html>