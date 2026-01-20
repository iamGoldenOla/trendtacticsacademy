// Course Generation Utility
// This can be imported and used in your dashboard to generate courses on-demand

import { supabase } from '../services/supabaseClient';

export async function generateCourseContent(courseId, courseTitle) {
    console.log('Generating content for course:', courseTitle);

    // Determine course type and generate appropriate content
    const courseType = courseTitle.toLowerCase();

    if (courseType.includes('vibe coding')) {
        await generateVibeCodingCourse(courseId);
    } else if (courseType.includes('facebook ads')) {
        await generateFacebookAdsCourse(courseId);
    } else if (courseType.includes('prompt engineering')) {
        await generatePromptEngineeringCourse(courseId);
    } else {
        throw new Error(`Course generation is only available for: Vibe Coding, Facebook Ads, and Prompt Engineering courses. "${courseTitle}" is not supported.`);
    }
}

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
        // Create module
        const { data: module, error: moduleError } = await supabase
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

        // Create lessons for this module
        const lessonsPerModule = Math.ceil(lessonTitles.length / modules.length);
        const startIndex = lessonIndex;
        const endIndex = Math.min(startIndex + lessonsPerModule, lessonTitles.length);

        for (let i = startIndex; i < endIndex; i++) {
            const { error: lessonError } = await supabase
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

// Export for use in components
export { generateVibeCodingCourse, generateFacebookAdsCourse, generatePromptEngineeringCourse };