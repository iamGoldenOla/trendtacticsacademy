#!/usr/bin/env node

// Final diagnostic script to identify the exact frontend issue
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;

console.log('🔬 Final Frontend Diagnostic Tool');
console.log('=============================\n');

// Create Supabase client (same as frontend)
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function finalDiagnostic() {
  try {
    console.log('🔍 Performing final diagnostic...\n');
    
    // Step 1: Simulate what happens when frontend loads homepage
    console.log('Step 1: Homepage course listing...');
    const { data: homepageCourses, error: homepageError } = await supabase
      .from('courses')
      .select('id, title, category, thumbnail_url, is_published')
      .eq('is_published', true)
      .order('created_at', { ascending: false });
    
    if (homepageError) {
      console.error('❌ Homepage courses error:', homepageError.message);
      return;
    }
    
    console.log(`✅ Homepage loads ${homepageCourses.length} courses`);
    
    // Step 2: Simulate what happens when user clicks "View Course" on first course
    console.log('\nStep 2: Course detail loading (simulating frontend click)...');
    const firstCourse = homepageCourses[0];
    console.log(`   Selected course: ${firstCourse.title} (ID: ${firstCourse.id})`);
    
    // This is the approach that avoids the relationship error
    console.log('   Loading course details...');
    const { data: courseDetails, error: courseDetailsError } = await supabase
      .from('courses')
      .select('*')
      .eq('id', firstCourse.id)
      .eq('is_published', true)
      .single();
    
    if (courseDetailsError) {
      console.error('❌ Course details error:', courseDetailsError.message);
      return;
    }
    
    console.log(`   ✅ Course loaded: ${courseDetails.title}`);
    
    // Load modules separately
    console.log('   Loading modules...');
    const { data: modules, error: modulesError } = await supabase
      .from('modules')
      .select('*')
      .eq('course_id', firstCourse.id)
      .eq('is_published', true)
      .order('order_index', { ascending: true });
    
    if (modulesError) {
      console.error('❌ Modules error:', modulesError.message);
      return;
    }
    
    console.log(`   ✅ Loaded ${modules.length} modules`);
    
    // Load lessons for each module
    console.log('   Loading lessons...');
    let totalLessons = 0;
    let lessonsLoaded = true;
    
    for (const module of modules) {
      const { data: lessons, error: lessonsError } = await supabase
        .from('lessons')
        .select('*')
        .eq('module_id', module.id)
        .eq('is_published', true)
        .order('order_index', { ascending: true });
      
      if (lessonsError) {
        console.error(`   ❌ Lessons error for module ${module.title}:`, lessonsError.message);
        lessonsLoaded = false;
        break;
      }
      
      console.log(`   ✅ Module "${module.title}" has ${lessons.length} lessons`);
      totalLessons += lessons.length;
      
      // Show first lesson details if available
      if (lessons.length > 0) {
        const firstLesson = lessons[0];
        console.log(`      First lesson: ${firstLesson.title}`);
        console.log(`      Content preview: ${firstLesson.content ? firstLesson.content.substring(0, 50) + '...' : 'No content'}`);
      }
    }
    
    if (!lessonsLoaded) {
      return;
    }
    
    console.log(`   ✅ Total lessons loaded: ${totalLessons}`);
    
    // Step 3: Verify the course can be displayed
    console.log('\nStep 3: Verifying course display readiness...');
    
    if (courseDetails && modules.length > 0 && totalLessons > 0) {
      console.log('✅ Course is READY for display!');
      console.log('   - Course details loaded');
      console.log('   - Modules loaded');
      console.log('   - Lessons loaded');
      console.log('   - All data is published');
      console.log('\n🎉 This course should display correctly in the frontend!');
    } else {
      console.log('⚠️  Course may have display issues:');
      if (!courseDetails) console.log('   - Course details not loaded');
      if (modules.length === 0) console.log('   - No modules found');
      if (totalLessons === 0) console.log('   - No lessons found');
    }
    
    // Step 4: Check for common frontend issues
    console.log('\nStep 4: Checking for common frontend issues...');
    
    // Check if there are any courses without proper structure
    console.log('   Scanning all courses for structural issues...');
    
    let issuesFound = false;
    for (const course of homepageCourses.slice(0, 3)) {
      const { data: courseModules } = await supabase
        .from('modules')
        .select('id')
        .eq('course_id', course.id)
        .eq('is_published', true);
      
      if (courseModules && courseModules.length === 0) {
        console.log(`   ⚠️  Course "${course.title}" has no modules`);
        issuesFound = true;
      } else if (courseModules) {
        let courseLessons = 0;
        for (const module of courseModules) {
          const { data: moduleLessons } = await supabase
            .from('lessons')
            .select('id')
            .eq('module_id', module.id)
            .eq('is_published', true);
          
          if (moduleLessons) {
            courseLessons += moduleLessons.length;
          }
        }
        
        if (courseLessons === 0) {
          console.log(`   ⚠️  Course "${course.title}" has modules but no lessons`);
          issuesFound = true;
        }
      }
    }
    
    if (!issuesFound) {
      console.log('   ✅ No structural issues found in sampled courses');
    }
    
    console.log('\n🔬 Final Diagnostic Complete!');
    console.log('==========================');
    console.log('If you\'re still seeing "Error Loading Course":');
    console.log('1. The issue is likely in the FRONTEND code, not the database');
    console.log('2. Check browser console for JavaScript errors');
    console.log('3. Check network tab for failed API requests');
    console.log('4. Verify the course ID being passed to the frontend');
    console.log('5. The database is working correctly with all data accessible');
    
  } catch (error) {
    console.error('❌ Unexpected error:', error.message);
  }
}

// Run the final diagnostic
finalDiagnostic();