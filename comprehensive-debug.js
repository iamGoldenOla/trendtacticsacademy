#!/usr/bin/env node

// Comprehensive debug script to identify the exact cause of the course loading issue
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

console.log('🔍 Comprehensive Course Loading Debug Tool');
console.log('=====================================\n');

// Validate environment variables
if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Error: Supabase credentials not found in environment variables');
  process.exit(1);
}

console.log('✅ Environment variables loaded successfully');

// Create Supabase clients
const supabaseAnon = createClient(supabaseUrl, supabaseAnonKey);
const supabaseAdmin = supabaseServiceRoleKey ? 
  createClient(supabaseUrl, supabaseServiceRoleKey, {
    auth: {
      persistSession: false,
      autoRefreshToken: false
    }
  }) : null;

async function comprehensiveDebug() {
  try {
    console.log('1. Testing database connectivity...');
    
    // Test basic connectivity with anon client
    const { data: testAnon, error: testAnonError } = await supabaseAnon
      .from('courses')
      .select('id')
      .limit(1);
    
    if (testAnonError) {
      console.error('❌ Anon client connection failed:', testAnonError.message);
      return;
    }
    
    console.log('✅ Anon client connection successful');
    
    // Test with admin client if available
    if (supabaseAdmin) {
      const { data: testAdmin, error: testAdminError } = await supabaseAdmin
        .from('courses')
        .select('id')
        .limit(1);
      
      if (testAdminError) {
        console.error('❌ Admin client connection failed:', testAdminError.message);
      } else {
        console.log('✅ Admin client connection successful');
      }
    }
    
    console.log('\n2. Checking courses...');
    
    // Get all courses with anon client
    const { data: courses, error: coursesError } = await supabaseAnon
      .from('courses')
      .select('*');
    
    if (coursesError) {
      console.error('❌ Error fetching courses with anon client:', coursesError.message);
      return;
    }
    
    console.log(`✅ Found ${courses.length} courses with anon client`);
    
    if (courses.length === 0) {
      console.log('⚠️  No courses found - this explains the error');
      return;
    }
    
    // Display course information
    console.log('\n📋 Course List:');
    courses.slice(0, 3).forEach((course, index) => {
      console.log(`  ${index + 1}. ${course.title} (ID: ${course.id})`);
      console.log(`     Published: ${course.is_published ? 'Yes' : 'No'}`);
      console.log(`     Category: ${course.category || 'None'}`);
    });
    
    if (courses.length > 3) {
      console.log(`     ... and ${courses.length - 3} more courses`);
    }
    
    console.log('\n3. Checking modules for first course...');
    
    const firstCourse = courses[0];
    console.log(`   Testing course: ${firstCourse.title} (ID: ${firstCourse.id})`);
    
    // Get modules for the first course
    const { data: modules, error: modulesError } = await supabaseAnon
      .from('modules')
      .select('*')
      .eq('course_id', firstCourse.id)
      .order('order_index', { ascending: true });
    
    if (modulesError) {
      console.error('❌ Error fetching modules:', modulesError.message);
      return;
    }
    
    console.log(`✅ Found ${modules.length} modules for course "${firstCourse.title}"`);
    
    if (modules.length === 0) {
      console.log('⚠️  No modules found for this course - this could explain the error');
      return;
    }
    
    // Display module information
    console.log('\n📋 Module List:');
    modules.slice(0, 3).forEach((module, index) => {
      console.log(`  ${index + 1}. ${module.title} (ID: ${module.id})`);
      console.log(`     Published: ${module.is_published ? 'Yes' : 'No'}`);
      console.log(`     Order: ${module.order_index || 'Not set'}`);
    });
    
    if (modules.length > 3) {
      console.log(`     ... and ${modules.length - 3} more modules`);
    }
    
    console.log('\n4. Checking lessons for first module...');
    
    const firstModule = modules[0];
    console.log(`   Testing module: ${firstModule.title} (ID: ${firstModule.id})`);
    
    // Get lessons for the first module
    const { data: lessons, error: lessonsError } = await supabaseAnon
      .from('lessons')
      .select('*')
      .eq('module_id', firstModule.id)
      .order('order_index', { ascending: true });
    
    if (lessonsError) {
      console.error('❌ Error fetching lessons:', lessonsError.message);
      return;
    }
    
    console.log(`✅ Found ${lessons.length} lessons for module "${firstModule.title}"`);
    
    if (lessons.length === 0) {
      console.log('⚠️  No lessons found for this module - this explains the error');
      return;
    }
    
    // Display lesson information
    console.log('\n📋 Lesson List:');
    lessons.slice(0, 3).forEach((lesson, index) => {
      console.log(`  ${index + 1}. ${lesson.title} (ID: ${lesson.id})`);
      console.log(`     Published: ${lesson.is_published ? 'Yes' : 'No'}`);
      console.log(`     Order: ${lesson.order_index || 'Not set'}`);
      console.log(`     Duration: ${lesson.duration || 'Not set'}`);
    });
    
    if (lessons.length > 3) {
      console.log(`     ... and ${lessons.length - 3} more lessons`);
    }
    
    console.log('\n5. Testing specific course access...');
    
    // Try to access the specific course that might be failing
    const { data: specificCourse, error: specificError } = await supabaseAnon
      .from('courses')
      .select(`
        *,
        modules (
          *,
          lessons (*)
        )
      `)
      .eq('id', firstCourse.id)
      .single();
    
    if (specificError) {
      console.error('❌ Error accessing specific course with relations:', specificError.message);
    } else {
      console.log('✅ Successfully accessed course with modules and lessons');
      console.log(`   Course: ${specificCourse.title}`);
      console.log(`   Modules: ${specificCourse.modules ? specificCourse.modules.length : 0}`);
      
      if (specificCourse.modules && specificCourse.modules.length > 0) {
        const firstMod = specificCourse.modules[0];
        console.log(`   First module: ${firstMod.title}`);
        console.log(`   Lessons in first module: ${firstMod.lessons ? firstMod.lessons.length : 0}`);
      }
    }
    
    console.log('\n6. Checking publication status...');
    
    // Check how many courses/modules/lessons are published
    const { count: publishedCourses, error: pcError } = await supabaseAnon
      .from('courses')
      .select('*', { count: 'exact', head: true })
      .eq('is_published', true);
    
    const { count: publishedModules, error: pmError } = await supabaseAnon
      .from('modules')
      .select('*', { count: 'exact', head: true })
      .eq('is_published', true);
    
    const { count: publishedLessons, error: plError } = await supabaseAnon
      .from('lessons')
      .select('*', { count: 'exact', head: true })
      .eq('is_published', true);
    
    console.log(`📊 Published items:`);
    console.log(`   Courses: ${publishedCourses} of ${courses.length}`);
    console.log(`   Modules: ${publishedModules} of ${modules.length}`);
    console.log(`   Lessons: ${publishedLessons} of ${lessons.length}`);
    
    console.log('\n🔍 Debug Summary:');
    console.log('================');
    
    if (courses.length > 0 && modules.length > 0 && lessons.length > 0) {
      console.log('✅ All data structures are present');
      console.log('✅ Anonymous users can access courses, modules, and lessons');
      console.log('⚠️  If you\'re still seeing the error, it might be a frontend issue');
      console.log('   - Check browser console for JavaScript errors');
      console.log('   - Verify the course ID being requested');
      console.log('   - Check network tab for failed API requests');
    } else {
      console.log('❌ Missing data structures that are required for course display');
      if (courses.length === 0) console.log('   - No courses found');
      if (modules.length === 0) console.log('   - No modules found');
      if (lessons.length === 0) console.log('   - No lessons found');
    }
    
  } catch (error) {
    console.error('❌ Unexpected error:', error.message);
  }
}

// Run the comprehensive debug
comprehensiveDebug();