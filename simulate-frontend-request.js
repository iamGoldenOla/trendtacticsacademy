#!/usr/bin/env node

// Script to simulate exactly what the frontend is doing when loading a course
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;

console.log('🌐 Frontend Request Simulation Tool');
console.log('================================\n');

// Validate environment variables
if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Error: Supabase credentials not found in environment variables');
  process.exit(1);
}

console.log('✅ Environment variables loaded successfully');

// Create Supabase client (same as frontend)
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function simulateFrontendRequest() {
  try {
    console.log('1. Simulating frontend course loading process...\n');
    
    // Step 1: Get all courses (what homepage does)
    console.log('Step 1: Fetching all courses...');
    const { data: courses, error: coursesError } = await supabase
      .from('courses')
      .select('*')
      .eq('is_published', true)
      .order('created_at', { ascending: false });
    
    if (coursesError) {
      console.error('❌ Error fetching courses:', coursesError.message);
      return;
    }
    
    console.log(`✅ Found ${courses.length} published courses`);
    
    if (courses.length === 0) {
      console.log('⚠️  No published courses found');
      return;
    }
    
    // Display first few courses
    console.log('\n📋 Available Courses:');
    courses.slice(0, 3).forEach((course, index) => {
      console.log(`  ${index + 1}. ${course.title} (ID: ${course.id})`);
    });
    
    // Step 2: Try to load the first course (what happens when you click "View Course")
    console.log('\nStep 2: Loading first course details...');
    const firstCourse = courses[0];
    console.log(`   Loading course: ${firstCourse.title} (ID: ${firstCourse.id})`);
    
    // This is what the frontend does when loading a specific course
    const { data: courseDetails, error: courseError } = await supabase
      .from('courses')
      .select(`
        *,
        modules (
          *,
          lessons (
            *
          )
        )
      `)
      .eq('id', firstCourse.id)
      .eq('is_published', true)
      .single();
    
    if (courseError) {
      console.error('❌ Error loading course details:', courseError.message);
      
      // Try alternative approach
      console.log('\nStep 2b: Trying alternative approach...');
      
      // First get the course
      const { data: courseOnly, error: courseOnlyError } = await supabase
        .from('courses')
        .select('*')
        .eq('id', firstCourse.id)
        .eq('is_published', true)
        .single();
      
      if (courseOnlyError) {
        console.error('❌ Error loading course:', courseOnlyError.message);
        return;
      }
      
      console.log(`✅ Loaded course: ${courseOnly.title}`);
      
      // Then get modules
      const { data: courseModules, error: modulesError } = await supabase
        .from('modules')
        .select('*')
        .eq('course_id', firstCourse.id)
        .eq('is_published', true)
        .order('order_index', { ascending: true });
      
      if (modulesError) {
        console.error('❌ Error loading modules:', modulesError.message);
        return;
      }
      
      console.log(`✅ Loaded ${courseModules.length} modules`);
      
      // Then get lessons for each module
      console.log('\nStep 2c: Loading lessons for each module...');
      for (const module of courseModules.slice(0, 2)) {
        console.log(`   Loading lessons for: ${module.title}`);
        
        const { data: moduleLessons, error: lessonsError } = await supabase
          .from('lessons')
          .select('*')
          .eq('module_id', module.id)
          .eq('is_published', true)
          .order('order_index', { ascending: true });
        
        if (lessonsError) {
          console.error(`   ❌ Error loading lessons for ${module.title}:`, lessonsError.message);
        } else {
          console.log(`   ✅ Loaded ${moduleLessons.length} lessons for ${module.title}`);
          
          if (moduleLessons.length > 0) {
            console.log(`      First lesson: ${moduleLessons[0].title}`);
          }
        }
      }
    } else {
      console.log(`✅ Successfully loaded course with all details:`);
      console.log(`   Title: ${courseDetails.title}`);
      console.log(`   Modules: ${courseDetails.modules ? courseDetails.modules.length : 0}`);
      
      if (courseDetails.modules && courseDetails.modules.length > 0) {
        const firstModule = courseDetails.modules[0];
        console.log(`   First module: ${firstModule.title}`);
        console.log(`   Lessons in first module: ${firstModule.lessons ? firstModule.lessons.length : 0}`);
        
        if (firstModule.lessons && firstModule.lessons.length > 0) {
          console.log(`   First lesson: ${firstModule.lessons[0].title}`);
        }
      }
    }
    
    console.log('\n3. Testing specific problematic scenarios...\n');
    
    // Test if there are any courses without modules
    console.log('Checking for courses without modules...');
    for (const course of courses.slice(0, 3)) {
      const { data: modules, error: modulesError } = await supabase
        .from('modules')
        .select('id')
        .eq('course_id', course.id)
        .eq('is_published', true);
      
      if (modulesError) {
        console.error(`❌ Error checking modules for ${course.title}:`, modulesError.message);
      } else {
        console.log(`   ${course.title}: ${modules.length} modules`);
        
        if (modules.length === 0) {
          console.log(`   ⚠️  This course has no modules - would cause "Error Loading Course"`);
        } else {
          // Check if modules have lessons
          for (const module of modules.slice(0, 2)) {
            const { data: lessons, error: lessonsError } = await supabase
              .from('lessons')
              .select('id')
              .eq('module_id', module.id)
              .eq('is_published', true);
            
            if (lessonsError) {
              console.error(`   ❌ Error checking lessons:`, lessonsError.message);
            } else {
              console.log(`     Module ${module.id}: ${lessons.length} lessons`);
              
              if (lessons.length === 0) {
                console.log(`     ⚠️  This module has no lessons - could cause issues`);
              }
            }
          }
        }
      }
    }
    
    console.log('\n🌐 Frontend Simulation Complete!');
    console.log('================================');
    console.log('If you\'re still seeing "Error Loading Course", check:');
    console.log('1. Browser console for JavaScript errors');
    console.log('2. Network tab for failed API requests');
    console.log('3. The specific course ID being requested');
    console.log('4. Frontend code for any hardcoded course IDs that might not exist');
    
  } catch (error) {
    console.error('❌ Unexpected error:', error.message);
  }
}

// Run the simulation
simulateFrontendRequest();