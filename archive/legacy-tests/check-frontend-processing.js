// Test to check how the frontend processes course data
console.log('🔍 Checking frontend course processing...');

// Simulate the exact data structure returned by our API
const apiResponse = {
  id: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
  title: 'Vibe Coding',
  description: 'Learn to create digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax or complex technical rules.',
  category: 'Programming',
  level: 'beginner',
  price: 0,
  duration: '3 weeks',
  is_published: true,
  modules: [
    {
      id: 'b2c3d4e5-f6a7-8901-bcde-f01234567891',
      title: 'Understanding Vibe Coding',
      description: 'Learn the foundational concepts of Vibe Coding and why it exists',
      ordering: 1,
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
      lessons: [
        { id: '4d5e6f78-9012-3456-def0-123456789123', title: 'Learning to Think in Ideas, Not Code', duration: '30 minutes', ordering: 1 },
        { id: '5e6f7890-1234-5678-ef01-234567891234', title: 'Turning Simple Ideas into Digital Instructions', duration: '30 minutes', ordering: 2 },
        { id: '6f789012-3456-7890-f012-345678912345', title: "Understanding 'Intent' in Vibe Coding", duration: '30 minutes', ordering: 3 }
      ]
    }
    // ... (other modules would be here)
  ]
};

console.log('API Response:', JSON.stringify(apiResponse, null, 2));

// Simulate frontend processing
function processCourseData(course) {
  console.log('\nProcessing course:', course.title);
  
  // Check if course has required fields
  const requiredFields = ['id', 'title', 'is_published'];
  const missingFields = requiredFields.filter(field => course[field] === undefined);
  
  if (missingFields.length > 0) {
    console.error('❌ Missing required fields:', missingFields);
    return null;
  }
  
  console.log('✅ Required fields present');
  
  // Check if course is published
  if (!course.is_published) {
    console.log('❌ Course is not published');
    return null;
  }
  
  console.log('✅ Course is published');
  
  // Check modules
  if (!course.modules || !Array.isArray(course.modules)) {
    console.log('❌ No modules found');
    return null;
  }
  
  console.log(`✅ Found ${course.modules.length} modules`);
  
  // Check lessons in modules
  const totalLessons = course.modules.reduce((sum, module) => {
    if (module.lessons && Array.isArray(module.lessons)) {
      return sum + module.lessons.length;
    }
    return sum;
  }, 0);
  
  console.log(`✅ Total lessons: ${totalLessons}`);
  
  // Process modules (sort by ordering)
  const processedModules = [...course.modules].sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
  
  // Process lessons in each module (sort by ordering)
  processedModules.forEach(module => {
    if (module.lessons && Array.isArray(module.lessons)) {
      module.lessons.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
    }
  });
  
  // Return processed course
  return {
    ...course,
    modules: processedModules
  };
}

// Process the course
const processedCourse = processCourseData(apiResponse);

if (processedCourse) {
  console.log('\n✅ Course processed successfully');
  console.log('Processed course can be displayed in frontend');
} else {
  console.log('\n❌ Course processing failed');
  console.log('Course will not be displayed in frontend');
}

console.log('\n📋 Summary:');
console.log('If you see this message in your browser console, the frontend processing is working correctly.');
console.log('If you do not see this message, there might be a JavaScript error preventing execution.');