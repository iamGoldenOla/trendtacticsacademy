#!/usr/bin/env node

// Script to check if there's a specific course causing issues
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;

console.log('🎯 Specific Course Issue Checker');
console.log('============================\n');

// Create Supabase client
const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Common course IDs that might be hardcoded in the frontend
const commonCourseIds = [
  'deecdfbd-a12e-4c7d-b099-ebfb31f9f9f0', // First course from our debug
  '23beee05-70ed-44f1-80e1-89aa65938395', // Second course
  '91896d3e-90b5-44fd-9a7a-6822089a8475', // Third course
  'invalid-course-id', // Test invalid ID
  '' // Test empty ID
];

async function checkSpecificCourses() {
  console.log('1. Checking common course IDs that might be hardcoded...\n');
  
  for (const courseId of commonCourseIds) {
    console.log(`Testing course ID: ${courseId || '(empty)'}`);
    
    try {
      const { data: course, error: courseError } = await supabase
        .from('courses')
        .select(`
          *,
          modules (
            *,
            lessons (*)
          )
        `)
        .eq('id', courseId)
        .eq('is_published', true)
        .single();
      
      if (courseError) {
        console.log(`  ❌ Error: ${courseError.message}`);
      } else if (course) {
        console.log(`  ✅ Found course: ${course.title}`);
        console.log(`     Modules: ${course.modules ? course.modules.length : 0}`);
        
        if (course.modules && course.modules.length > 0) {
          const firstModule = course.modules[0];
          console.log(`     First module: ${firstModule.title}`);
          console.log(`     Lessons in first module: ${firstModule.lessons ? firstModule.lessons.length : 0}`);
        }
      } else {
        console.log(`  ⚠️  No course found with this ID`);
      }
    } catch (error) {
      console.log(`  ❌ Exception: ${error.message}`);
    }
    
    console.log('');
  }
  
  console.log('2. Checking all courses for potential issues...\n');
  
  // Get all courses and check each one
  const { data: allCourses, error: allCoursesError } = await supabase
    .from('courses')
    .select('*')
    .eq('is_published', true);
  
  if (allCoursesError) {
    console.error('❌ Error fetching all courses:', allCoursesError.message);
    return;
  }
  
  console.log(`✅ Found ${allCourses.length} published courses\n`);
  
  for (const course of allCourses) {
    console.log(`Checking course: ${course.title} (ID: ${course.id})`);
    
    // Check modules
    const { data: modules, error: modulesError } = await supabase
      .from('modules')
      .select('*')
      .eq('course_id', course.id)
      .eq('is_published', true);
    
    if (modulesError) {
      console.log(`  ❌ Modules error: ${modulesError.message}`);
      continue;
    }
    
    console.log(`  Modules: ${modules.length}`);
    
    if (modules.length === 0) {
      console.log(`  ⚠️  WARNING: This course has no modules - would cause "Error Loading Course"`);
    } else {
      // Check lessons in each module
      let totalLessons = 0;
      for (const module of modules) {
        const { data: lessons, error: lessonsError } = await supabase
          .from('lessons')
          .select('*')
          .eq('module_id', module.id)
          .eq('is_published', true);
        
        if (lessonsError) {
          console.log(`    ❌ Lessons error in module ${module.title}: ${lessonsError.message}`);
        } else {
          console.log(`    Module "${module.title}": ${lessons.length} lessons`);
          totalLessons += lessons.length;
          
          if (lessons.length === 0) {
            console.log(`    ⚠️  WARNING: Module has no lessons`);
          }
        }
      }
      
      console.log(`  Total lessons in course: ${totalLessons}`);
      
      if (totalLessons === 0 && modules.length > 0) {
        console.log(`  ⚠️  WARNING: Course has modules but no lessons - could cause issues`);
      }
    }
    
    console.log('');
  }
  
  console.log('🎯 Course Issue Check Complete!');
  console.log('=============================');
  console.log('If you\'re still seeing "Error Loading Course":');
  console.log('1. Check which specific course ID the frontend is requesting');
  console.log('2. Look in browser network tab for failed requests');
  console.log('3. The issue might be:');
  console.log('   - Hardcoded course ID that doesn\'t exist');
  console.log('   - Course exists but has no modules');
  console.log('   - Course and modules exist but no lessons');
  console.log('   - Frontend JavaScript error preventing proper loading');
}

// Run the check
checkSpecificCourses();