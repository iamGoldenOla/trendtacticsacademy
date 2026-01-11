// Script to check React component rendering issues
console.log('🔍 Checking React Component Rendering...');

// Function to simulate what happens in the React components
function checkReactRendering() {
    console.log('\n1. Simulating Home.tsx rendering...');
    
    // Simulate the data that would be passed to the Home component
    const mockCourses = [{
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
            }
        ]
    }];
    
    console.log('Mock courses data:', JSON.stringify(mockCourses[0], null, 2));
    
    // Check if the Home component would render this data
    console.log('\n2. Checking Home component rendering logic...');
    
    // Simulate the featuredCourses mapping in Home.tsx
    try {
        const featuredCourses = mockCourses;
        
        console.log('Featured courses count:', featuredCourses.length);
        
        if (featuredCourses.length > 0) {
            const course = featuredCourses[0];
            console.log('First course title:', course.title);
            console.log('First course modules:', course.modules?.length || 0);
            
            // Check if all required fields are present
            const requiredFields = ['id', 'title'];
            const missingFields = requiredFields.filter(field => !course[field]);
            
            if (missingFields.length > 0) {
                console.error('❌ Missing required fields in course:', missingFields);
            } else {
                console.log('✅ All required fields present');
            }
            
            // Check modules
            if (course.modules && Array.isArray(course.modules)) {
                console.log('✅ Modules array present');
                console.log('Modules count:', course.modules.length);
                
                // Check each module
                course.modules.forEach((module, index) => {
                    console.log(`  Module ${index + 1}: ${module.title}`);
                    console.log(`    Lessons: ${module.lessons?.length || 0}`);
                });
            } else {
                console.log('❌ Modules array missing or invalid');
            }
            
            console.log('\n✅ Home component should render this course');
        } else {
            console.log('❌ No featured courses to render');
        }
        
    } catch (error) {
        console.error('❌ Error in Home component rendering simulation:', error);
    }
    
    // Simulate Courses.js rendering
    console.log('\n3. Simulating Courses.js rendering...');
    
    try {
        const courses = mockCourses;
        console.log('Courses count:', courses.length);
        
        if (courses.length > 0) {
            const course = courses[0];
            console.log('First course title:', course.title);
            
            // Check filtering logic
            const searchTerm = '';
            const selectedLevel = 'all';
            
            const matchesSearch = course.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
                course.description.toLowerCase().includes(searchTerm.toLowerCase());
            console.log('Matches search term:', matchesSearch);
            
            const matchesLevel = selectedLevel === 'all' || course.level === selectedLevel;
            console.log('Matches level filter:', matchesLevel);
            
            if (matchesSearch && matchesLevel) {
                console.log('✅ Course passes filtering in Courses.js');
            } else {
                console.log('❌ Course would be filtered out in Courses.js');
            }
        }
        
    } catch (error) {
        console.error('❌ Error in Courses.js rendering simulation:', error);
    }
    
    console.log('\n📋 RENDERING CHECK COMPLETE');
    console.log('If all checks passed, the issue is likely in the actual React component implementation');
}

console.log('=== REACT RENDERING CHECK LOADED ===');
console.log('To run the check, paste this in console:');
console.log('checkReactRendering()');

window.checkReactRendering = checkReactRendering;