// Debug script to check what courses exist in the database
const { courseService } = require('./lms-frontend/src/services');

async function checkCourses() {
  try {
    console.log('Checking courses in database...');
    const courses = await courseService.getAllCourses();
    console.log(`Found ${courses.length} courses:`);
    
    courses.forEach((course, index) => {
      console.log(`${index + 1}. ${course.title}`);
      console.log(`   ID: ${course.id}`);
      console.log(`   Category: ${course.category}`);
      console.log(`   Level: ${course.level}`);
      console.log(`   Price: $${course.price}`);
      console.log(`   Duration: ${course.duration}`);
      console.log(`   Created: ${course.created_at}`);
      console.log('---');
    });
    
    // Check details of first course
    if (courses.length > 0) {
      console.log('\nChecking details of first course...');
      try {
        const firstCourse = await courseService.getCourseById(courses[0].id);
        console.log('Course details:');
        console.log(JSON.stringify(firstCourse, null, 2));
      } catch (detailError) {
        console.error('Error fetching course details:', detailError.message);
      }
    }
  } catch (error) {
    console.error('Error checking courses:', error.message);
  }
}

checkCourses();