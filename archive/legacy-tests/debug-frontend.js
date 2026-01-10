// Debug script to test the frontend course loading
const fs = require('fs');
const path = require('path');

// Read the built JavaScript file to check if our fixes are included
const buildDir = path.join(__dirname, 'lms-frontend', 'build', 'static', 'js');
console.log('Build directory:', buildDir);

// Check if build directory exists
if (!fs.existsSync(buildDir)) {
  console.log('❌ Build directory does not exist');
  process.exit(1);
}

// Find the main JS file
const files = fs.readdirSync(buildDir);
const mainJsFile = files.find(file => file.startsWith('main.') && file.endsWith('.js'));

if (!mainJsFile) {
  console.log('❌ Could not find main JS file in build');
  process.exit(1);
}

console.log('✅ Found main JS file:', mainJsFile);

// Read the content
const mainJsPath = path.join(buildDir, mainJsFile);
const content = fs.readFileSync(mainJsPath, 'utf8');

// Check if our fixed queries are present
const hasModulesFKey = content.includes('modules_course_id_fkey');
const hasLessonsFKey = content.includes('lessons_module_id_fkey');

console.log('Has modules_course_id_fkey:', hasModulesFKey);
console.log('Has lessons_module_id_fkey:', hasLessonsFKey);

// Check for Supabase URL
const hasSupabaseUrl = content.includes('uimdbodamoeyukrghchb.supabase.co');
console.log('Has Supabase URL:', hasSupabaseUrl);

// Look for error patterns
const hasSupabaseError = content.includes('PGRST201') || content.includes('relationship');
console.log('Has Supabase relationship error patterns:', hasSupabaseError);

console.log('\n🔍 Summary:');
if (hasModulesFKey && hasLessonsFKey) {
  console.log('✅ Fixed queries appear to be in the build');
} else {
  console.log('❌ Fixed queries may not be in the build');
}

if (hasSupabaseError) {
  console.log('⚠️ Potential Supabase relationship issues detected in build');
} else {
  console.log('✅ No obvious Supabase relationship issues in build');
}