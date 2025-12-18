#!/usr/bin/env node

// Diagnostic script to check courses in the database
const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function diagnoseCourses() {
  console.log('🔍 Diagnosing Courses Database');
  console.log('============================\n');
  
  try {
    // Check if we can connect to Supabase
    console.log('1. Testing Supabase connection...');
    const { data, error } = await supabase
      .from('courses')
      .select('id, title')
      .limit(1);
    
    if (error) {
      console.log('❌ Connection failed:', error.message);
      return;
    }
    
    console.log('✅ Connection successful!');
    
    // Get all courses
    console.log('\n2. Fetching all courses...');
    const { data: courses, error: coursesError } = await supabase
      .from('courses')
      .select('*');
    
    if (coursesError) {
      console.log('❌ Failed to fetch courses:', coursesError.message);
      return;
    }
    
    console.log(`✅ Found ${courses.length} courses`);
    
    if (courses.length > 0) {
      console.log('\n📋 Course List:');
      courses.forEach((course, index) => {
        console.log(`  ${index + 1}. ${course.title} (ID: ${course.id})`);
        console.log(`     Published: ${course.is_published ? 'Yes' : 'No'}`);
        console.log(`     Category: ${course.category || 'None'}`);
        console.log(`     Level: ${course.level || 'None'}`);
        console.log('');
      });
    } else {
      console.log('📭 No courses found in database');
    }
    
    // Check modules
    console.log('3. Checking modules...');
    const { data: modules, error: modulesError } = await supabase
      .from('modules')
      .select('*');
    
    if (modulesError) {
      console.log('❌ Failed to fetch modules:', modulesError.message);
    } else {
      console.log(`✅ Found ${modules.length} modules`);
      
      if (modules.length > 0) {
        console.log('\n📋 Module List:');
        modules.slice(0, 5).forEach((module, index) => {
          console.log(`  ${index + 1}. ${module.title} (Course ID: ${module.course_id})`);
        });
        
        if (modules.length > 5) {
          console.log(`  ... and ${modules.length - 5} more modules`);
        }
      }
    }
    
    // Check lessons
    console.log('\n4. Checking lessons...');
    const { data: lessons, error: lessonsError } = await supabase
      .from('lessons')
      .select('*');
    
    if (lessonsError) {
      console.log('❌ Failed to fetch lessons:', lessonsError.message);
    } else {
      console.log(`✅ Found ${lessons.length} lessons`);
      
      if (lessons.length > 0) {
        console.log('\n📋 Lesson List:');
        lessons.slice(0, 5).forEach((lesson, index) => {
          console.log(`  ${index + 1}. ${lesson.title} (Module ID: ${lesson.module_id})`);
        });
        
        if (lessons.length > 5) {
          console.log(`  ... and ${lessons.length - 5} more lessons`);
        }
      }
    }
    
    console.log('\n🎉 Diagnosis complete!');
    
  } catch (error) {
    console.error('❌ Diagnosis failed:', error.message);
  }
}

// Run diagnosis
diagnoseCourses();