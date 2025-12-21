// Debug script to test frontend course filtering
console.log('🔍 Frontend Debug: Checking course filtering logic...');

// Simulate what the frontend might be doing
const mockCourse = {
  id: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
  title: 'Vibe Coding',
  is_published: true,
  modules: [
    { lessons: [{}, {}, {}] },
    { lessons: [{}, {}, {}] },
    { lessons: [{}, {}, {}] },
    { lessons: [{}, {}, {}] },
    { lessons: [{}, {}, {}] }
  ]
};

console.log('Course data from API:', mockCourse);

// Check if course passes frontend filters
const hasLessons = mockCourse.modules && mockCourse.modules.some(module => module.lessons && module.lessons.length > 0);
console.log('Has lessons:', hasLessons);

const isPublished = mockCourse.is_published === true;
console.log('Is published:', isPublished);

const passesFilters = hasLessons && isPublished;
console.log('Passes frontend filters:', passesFilters);

if (passesFilters) {
  console.log('✅ Course should display in frontend');
} else {
  console.log('❌ Course would be filtered out by frontend');
}