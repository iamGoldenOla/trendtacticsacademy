// EMERGENCY FIX: Force course display on homepage and courses page
// This script bypasses all normal processing and directly injects the course

(function() {
    console.log('🔧 Emergency Course Display Fix Activated');
    
    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', injectCourseDisplay);
    } else {
        injectCourseDisplay();
    }
    
    function injectCourseDisplay() {
        console.log('🔍 Injecting course display...');
        
        // Create the course data
        const vibeCodingCourse = {
            id: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
            title: 'Vibe Coding',
            description: 'Learn to create digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax or complex technical rules.',
            category: 'Programming',
            level: 'beginner',
            price: 0,
            duration: '3 weeks',
            is_published: true,
            thumbnail_url: null,
            modules: [
                {
                    id: 'b2c3d4e5-f6a7-8901-bcde-f01234567891',
                    title: 'Understanding Vibe Coding',
                    description: 'Learn the foundational concepts of Vibe Coding and why it exists',
                    ordering: 1,
                    duration: null,
                    lessons: [
                        { id: '1a2b3c4d-5e6f-7890-abcd-ef1234567890', title: 'What Is Vibe Coding?', duration: '30 minutes', ordering: 1 },
                        { id: '2b3c4d5e-6f78-9012-bcde-f01234567891', title: 'Why Vibe Coding Exists', duration: '30 minutes', ordering: 2 },
                        { id: '3c4d5e6f-7890-1234-cdef-012345678912', title: 'How Vibe Coding Is Different from Traditional Coding', duration: '30 minutes', ordering: 3 }
                    ]
                },
                {
                    id: 'c3d4e5f6-a7b8-9012-cdef-012345678912',
                    title: 'Thinking Before Coding',
                    description: 'Develop the skill of expressing ideas clearly before implementation',
                    ordering: 2,
                    duration: null,
                    lessons: [
                        { id: '4d5e6f78-9012-3456-def0-123456789123', title: 'Learning to Think in Ideas, Not Code', duration: '30 minutes', ordering: 1 },
                        { id: '5e6f7890-1234-5678-ef01-234567891234', title: 'Turning Simple Ideas into Digital Instructions', duration: '30 minutes', ordering: 2 },
                        { id: '6f789012-3456-7890-f012-345678912345', title: "Understanding 'Intent' in Vibe Coding", duration: '30 minutes', ordering: 3 }
                    ]
                },
                {
                    id: 'd4e5f6a7-b8c9-0123-def0-123456789123',
                    title: 'Working with AI as a Creative Partner',
                    description: 'Learn how to collaborate effectively with AI tools',
                    ordering: 3,
                    duration: null,
                    lessons: [
                        { id: '78901234-5678-9012-0123-456789123456', title: 'What AI Really Is (In Simple Terms)', duration: '30 minutes', ordering: 1 },
                        { id: '89012345-6789-0123-1234-567891234567', title: 'How AI Helps in Vibe Coding', duration: '30 minutes', ordering: 2 },
                        { id: '90123456-7890-1234-2345-678912345678', title: 'Talking to AI Clearly and Effectively', duration: '30 minutes', ordering: 3 }
                    ]
                },
                {
                    id: 'e5f6a7b8-c9d0-1234-ef01-234567891234',
                    title: 'Vibe Coding in Real Life',
                    description: 'See how Vibe Coding works in practical scenarios',
                    ordering: 4,
                    duration: null,
                    lessons: [
                        { id: '01234567-8901-2345-3456-789123456789', title: 'Real Examples of Vibe Coding', duration: '30 minutes', ordering: 1 },
                        { id: '12345678-9012-3456-4567-891234567890', title: 'Building Simple Things Without Fear', duration: '30 minutes', ordering: 2 },
                        { id: '23456789-0123-4567-5678-912345678901', title: 'Common Beginner Mistakes and How to Avoid Them', duration: '30 minutes', ordering: 3 }
                    ]
                },
                {
                    id: 'f6a7b8c9-d0e1-2345-f012-345678912345',
                    title: 'Exploring and Building with Confidence',
                    description: 'Use safe environments to experiment and build complete projects',
                    ordering: 5,
                    duration: null,
                    lessons: [
                        { id: '34567890-1234-5678-6789-123456789012', title: 'Using a Playground to Experiment Safely', duration: '30 minutes', ordering: 1 },
                        { id: '45678901-2345-6789-7890-234567890123', title: 'Improving Your Ideas Step by Step', duration: '30 minutes', ordering: 2 },
                        { id: '56789012-3456-7890-8901-345678901234', title: 'Your First Complete Vibe-Coded Project', duration: '45 minutes', ordering: 3 }
                    ]
                }
            ]
        };
        
        // Try to inject into homepage featured courses
        tryInjectIntoHomepage(vibeCodingCourse);
        
        // Try to inject into courses page
        tryInjectIntoCoursesPage(vibeCodingCourse);
        
        console.log('✅ Emergency fix applied - check your website!');
    }
    
    function tryInjectIntoHomepage(course) {
        console.log('🏠 Trying homepage injection...');
        
        // Look for common homepage elements
        const selectors = [
            '.featured-courses',
            '[data-testid="featured-courses"]',
            '#featured-courses',
            '.courses-grid',
            '[class*="course"]',
            'section'
        ];
        
        for (let selector of selectors) {
            const element = document.querySelector(selector);
            if (element) {
                console.log(`Found element with selector: ${selector}`);
                // Create a simple course card
                const courseCard = createCourseCard(course);
                element.appendChild(courseCard);
                console.log('✅ Course injected into homepage');
                return;
            }
        }
        
        // If we can't find specific elements, try to inject at the end of body
        console.log('📦 Injecting at end of body...');
        const courseCard = createCourseCard(course);
        document.body.appendChild(courseCard);
        console.log('✅ Course injected at end of page');
    }
    
    function tryInjectIntoCoursesPage(course) {
        console.log('📚 Trying courses page injection...');
        
        // Look for courses container
        const selectors = [
            '.courses-container',
            '[data-testid="courses-list"]',
            '#courses',
            '.courses-grid',
            '[class*="course"]'
        ];
        
        for (let selector of selectors) {
            const element = document.querySelector(selector);
            if (element) {
                console.log(`Found courses element with selector: ${selector}`);
                // Create a simple course card
                const courseCard = createCourseCard(course);
                element.appendChild(courseCard);
                console.log('✅ Course injected into courses page');
                return;
            }
        }
    }
    
    function createCourseCard(course) {
        const card = document.createElement('div');
        card.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            background: #fff;
            border: 2px solid #007bff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            max-width: 300px;
            font-family: Arial, sans-serif;
        `;
        
        card.innerHTML = `
            <h3 style="margin-top: 0; color: #333;">🚨 EMERGENCY FIX</h3>
            <h4 style="color: #007bff; margin-bottom: 10px;">${course.title}</h4>
            <p style="font-size: 14px; color: #666; margin-bottom: 15px;">${course.description.substring(0, 100)}...</p>
            <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                <span style="background: #e9ecef; padding: 4px 8px; border-radius: 4px; font-size: 12px;">${course.level}</span>
                <span style="background: #e9ecef; padding: 4px 8px; border-radius: 4px; font-size: 12px;">${course.duration}</span>
            </div>
            <div style="margin-bottom: 15px;">
                <strong>Modules:</strong> ${course.modules.length}<br>
                <strong>Lessons:</strong> ${course.modules.reduce((sum, m) => sum + (m.lessons ? m.lessons.length : 0), 0)}
            </div>
            <a href="/course/${course.id}" style="display: inline-block; background: #007bff; color: white; text-decoration: none; padding: 8px 16px; border-radius: 4px; font-size: 14px;">
                View Course
            </a>
            <p style="font-size: 12px; color: #999; margin-top: 15px;">
                This emergency fix bypasses normal processing.<br>
                Please contact support to fix the underlying issue.
            </p>
        `;
        
        return card;
    }
})();

console.log('🚀 Emergency Course Display Fix Loaded');
console.log('💡 To activate, refresh your page or paste this in console:');
console.log('injectCourseDisplay()');