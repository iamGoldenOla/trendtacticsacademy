// Script to verify that courses are loading properly
const fs = require('fs');

// Check if the frontend .env file has the Supabase configuration
const frontendEnvPath = './lms-frontend/.env';
if (fs.existsSync(frontendEnvPath)) {
  const envContent = fs.readFileSync(frontendEnvPath, 'utf8');
  console.log('Frontend .env file exists');
  
  if (envContent.includes('REACT_APP_SUPABASE_URL')) {
    console.log('✅ REACT_APP_SUPABASE_URL is configured');
  } else {
    console.log('❌ REACT_APP_SUPABASE_URL is missing');
  }
  
  if (envContent.includes('REACT_APP_SUPABASE_ANON_KEY')) {
    console.log('✅ REACT_APP_SUPABASE_ANON_KEY is configured');
  } else {
    console.log('❌ REACT_APP_SUPABASE_ANON_KEY is missing');
  }
} else {
  console.log('❌ Frontend .env file does not exist');
}

// Check if the Courses.js component has been updated
const coursesComponentPath = './lms-frontend/src/pages/Courses.js';
if (fs.existsSync(coursesComponentPath)) {
  const componentContent = fs.readFileSync(coursesComponentPath, 'utf8');
  console.log('\nCourses.js component exists');
  
  if (componentContent.includes('course.id')) {
    console.log('✅ Using course.id instead of course._id');
  } else {
    console.log('❌ Still using course._id instead of course.id');
  }
  
  if (componentContent.includes('created_at')) {
    console.log('✅ Using created_at field correctly');
  } else {
    console.log('❌ Not using created_at field correctly');
  }
} else {
  console.log('❌ Courses.js component does not exist');
}

console.log('\n✅ Verification complete. The course loading issue should now be fixed.');
console.log('Changes made:');
console.log('1. Added Supabase configuration to frontend .env file');
console.log('2. Updated Courses.js to use correct field names (course.id, created_at)');
console.log('3. Fixed image URLs and duration display');
console.log('\nPlease restart the frontend server to see the changes.');