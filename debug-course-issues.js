#!/usr/bin/env node

// Debug script to check course and lesson data
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;

console.log('🔍 Course Data Debug Tool');
console.log('======================\n');

// Validate environment variables
if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Error: Supabase credentials not found in environment variables');
  process.exit(1);
}

console.log('✅ Environment variables loaded successfully');

// Create Supabase client with anon key (for testing what the frontend sees)
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function debugCourseData() {
  try {
    console.log('1. Checking courses...');
    
    // Get all courses
    const { data: courses, error: coursesError } = await supabase
      .from('courses')
      .select('*');
    
    if (coursesError) {
      console.error('❌ Error fetching courses:', coursesError.message);
      return;
    }
    
    console.log(`✅ Found ${courses.length} courses`);
    
    if (courses.length > 0) {
      console.log('\n📋 Course List:');
      courses.forEach((course, index) => {
        console.log(`  ${index + 1}. ${course.title} (ID: ${course.id})`);
        console.log(`     Published: ${course.is_published ? 'Yes' : 'No'}`);
        console.log(`     Category: ${course.category || 'None'}`);
      });
      
      // Check modules for the first course
      console.log('\n2. Checking modules for first course...');
      const firstCourseId = courses[0].id;
      
      const { data: modules, error: modulesError } = await supabase
        .from('modules')
        .select('*')
        .eq('course_id', firstCourseId)
        .order('order_index', { ascending: true });
      
      if (modulesError) {
        console.error('❌ Error fetching modules:', modulesError.message);
        return;
      }
      
      console.log(`✅ Found ${modules.length} modules for course "${courses[0].title}"`);
      
      if (modules.length > 0) {
        console.log('\n📋 Module List:');
        modules.forEach((module, index) => {
          console.log(`  ${index + 1}. ${module.title} (ID: ${module.id})`);
          console.log(`     Order: ${module.order_index}`);
          console.log(`     Published: ${module.is_published ? 'Yes' : 'No'}`);
        });
        
        // Check lessons for the first module
        console.log('\n3. Checking lessons for first module...');
        const firstModuleId = modules[0].id;
        
        const { data: lessons, error: lessonsError } = await supabase
          .from('lessons')
          .select('*')
          .eq('module_id', firstModuleId)
          .order('order_index', { ascending: true });
        
        if (lessonsError) {
          console.error('❌ Error fetching lessons:', lessonsError.message);
          return;
        }
        
        console.log(`✅ Found ${lessons.length} lessons for module "${modules[0].title}"`);
        
        if (lessons.length > 0) {
          console.log('\n📋 Lesson List:');
          lessons.forEach((lesson, index) => {
            console.log(`  ${index + 1}. ${lesson.title} (ID: ${lesson.id})`);
            console.log(`     Order: ${lesson.order_index}`);
            console.log(`     Published: ${lesson.is_published ? 'Yes' : 'No'}`);
            console.log(`     Duration: ${lesson.duration || 'Not set'}`);
          });
        } else {
          console.log('📭 No lessons found for this module');
        }
      } else {
        console.log('📭 No modules found for this course');
      }
    } else {
      console.log('📭 No courses found in database');
    }
    
    // Check total lesson count
    console.log('\n4. Checking total lesson count...');
    const { count: totalLessons, error: countError } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true });
    
    if (countError) {
      console.error('❌ Error counting lessons:', countError.message);
    } else {
      console.log(`📊 Total lessons in database: ${totalLessons}`);
    }
    
    console.log('\n🔍 Debug Summary:');
    console.log('================');
    console.log('If you see courses and modules but no lessons, the frontend will show "Error Loading Course"');
    console.log('The frontend requires published lessons to display course content properly');
    
  } catch (error) {
    console.error('❌ Unexpected error:', error.message);
  }
}

// Run the debug function
debugCourseData();