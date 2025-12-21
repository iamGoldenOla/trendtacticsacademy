// Advanced Frontend Diagnostic Script
// This script will help identify exactly where the frontend is failing to display the course

console.log('🔍 Advanced Frontend Diagnostic Started');

// Function to simulate the exact course service calls
async function diagnoseFrontendIssues() {
    try {
        console.log('\n1. Testing Supabase connection...');
        
        // Check if Supabase is properly configured
        if (typeof supabase === 'undefined') {
            console.error('❌ Supabase client not found');
            return;
        }
        
        console.log('✅ Supabase client available');
        
        // Test the exact query used by getAllCourses
        console.log('\n2. Testing getAllCourses query...');
        try {
            const { data, error } = await supabase
                .from('courses')
                .select(`
                    *,
                    modules!modules_course_id_fkey (
                        id,
                        title,
                        description,
                        ordering,
                        duration,
                        lessons!lessons_module_id_fkey (
                            id,
                            title,
                            ordering,
                            duration
                        )
                    )
                `)
                .eq('is_published', true)
                .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') // Only fetch Vibe Coding course
                .order('created_at', { ascending: false });
            
            if (error) {
                console.error('❌ getAllCourses query failed:', error);
                return;
            }
            
            console.log('✅ getAllCourses query successful');
            console.log('   Courses returned:', data?.length || 0);
            
            if (data && data.length > 0) {
                console.log('   Course title:', data[0].title);
                console.log('   Modules count:', data[0].modules?.length || 0);
                
                // Calculate total lessons
                const totalLessons = data[0].modules?.reduce((sum, module) => {
                    return sum + (module.lessons?.length || 0);
                }, 0) || 0;
                
                console.log('   Total lessons:', totalLessons);
                
                // Check if course passes frontend filters
                const course = data[0];
                console.log('\n3. Checking frontend filtering...');
                
                // Simulate the exact filtering logic from Courses.js
                const isPublished = course.is_published === true;
                console.log('   Is published:', isPublished);
                
                const hasModules = course.modules && Array.isArray(course.modules) && course.modules.length > 0;
                console.log('   Has modules:', hasModules);
                
                const hasLessons = hasModules && course.modules.some(module => 
                    module.lessons && Array.isArray(module.lessons) && module.lessons.length > 0
                );
                console.log('   Has lessons:', hasLessons);
                
                const passesFilters = isPublished && hasModules && hasLessons;
                console.log('   Passes frontend filters:', passesFilters);
                
                if (passesFilters) {
                    console.log('\n✅ COURSE SHOULD DISPLAY IN FRONTEND');
                    console.log('   If it\'s not displaying, the issue is likely in the React component rendering');
                } else {
                    console.log('\n❌ COURSE WOULD BE FILTERED OUT');
                    console.log('   Check why the course doesn\'t pass filters');
                }
                
                // Simulate React component processing
                console.log('\n4. Simulating React component processing...');
                try {
                    // This simulates what happens in the React components
                    const processedCourse = {
                        ...course,
                        modules: course.modules?.map(module => ({
                            ...module,
                            lessons: module.lessons?.sort((a, b) => (a.ordering || 0) - (b.ordering || 0))
                        })).sort((a, b) => (a.ordering || 0) - (b.ordering || 0))
                    };
                    
                    console.log('✅ Course processed successfully for React components');
                    console.log('   Processed modules:', processedCourse.modules?.length);
                    
                    // Check if this would render in React
                    if (processedCourse.modules && processedCourse.modules.length > 0) {
                        console.log('✅ Would render in React components');
                    } else {
                        console.log('❌ Would NOT render in React components (no modules)');
                    }
                    
                } catch (processingError) {
                    console.error('❌ Error processing course for React:', processingError);
                }
            } else {
                console.log('❌ No courses returned from query');
            }
            
        } catch (queryError) {
            console.error('❌ Error in getAllCourses query:', queryError);
        }
        
    } catch (error) {
        console.error('❌ Diagnostic failed:', error);
    }
    
    console.log('\n📋 DIAGNOSTIC COMPLETE');
    console.log('Check the results above to identify where the issue occurs');
}

// Also test the specific course detail query
async function diagnoseCourseDetail() {
    console.log('\n--- COURSE DETAIL DIAGNOSTIC ---');
    
    try {
        const courseId = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';
        console.log('Testing course detail query for ID:', courseId);
        
        const { data, error } = await supabase
            .from('courses')
            .select(`
                *,
                modules!modules_course_id_fkey (
                    id,
                    title,
                    description,
                    ordering,
                    duration,
                    lessons!lessons_module_id_fkey (
                        id,
                        title,
                        ordering,
                        duration
                    )
                )
            `)
            .eq('id', courseId)
            .eq('is_published', true)
            .single();
        
        if (error) {
            console.error('❌ Course detail query failed:', error);
            return;
        }
        
        console.log('✅ Course detail query successful');
        console.log('   Course:', data?.title);
        console.log('   Modules:', data?.modules?.length);
        
        const totalLessons = data?.modules?.reduce((sum, module) => {
            return sum + (module.lessons?.length || 0);
        }, 0) || 0;
        
        console.log('   Total lessons:', totalLessons);
        
    } catch (error) {
        console.error('❌ Course detail diagnostic failed:', error);
    }
}

// Run diagnostics when script loads
console.log('=== FRONTEND DIAGNOSTIC SCRIPT LOADED ===');
console.log('To run diagnostics, paste this in console:');
console.log('diagnoseFrontendIssues()');
console.log('diagnoseCourseDetail()');

// Make functions available globally
window.diagnoseFrontendIssues = diagnoseFrontendIssues;
window.diagnoseCourseDetail = diagnoseCourseDetail;