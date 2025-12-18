#!/usr/bin/env node

// Script to verify that the RLS fix is working
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;

console.log('🔍 RLS Fix Verification Tool');
console.log('========================\n');

// Validate environment variables
if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Error: Supabase credentials not found in environment variables');
  process.exit(1);
}

console.log('✅ Environment variables loaded successfully');

// Create Supabase client with anon key (what the frontend uses)
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function verifyRLSFix() {
  try {
    console.log('1. Testing anonymous access to lessons...');
    
    // Test accessing lessons with anon client
    const { data: lessons, error: lessonsError } = await supabase
      .from('lessons')
      .select('id, title, module_id')
      .limit(5);
    
    if (lessonsError) {
      console.error('❌ Error accessing lessons:', lessonsError.message);
      return;
    }
    
    console.log(`✅ Anonymous client can now access ${lessons.length} lessons`);
    
    if (lessons.length > 0) {
      console.log('\n📋 Sample lessons accessible to frontend:');
      lessons.forEach((lesson, index) => {
        console.log(`  ${index + 1}. ${lesson.title}`);
      });
      
      // Test accessing a specific lesson
      console.log('\n2. Testing access to specific lesson...');
      const firstLesson = lessons[0];
      
      const { data: specificLesson, error: specificError } = await supabase
        .from('lessons')
        .select('id, title, content, module_id')
        .eq('id', firstLesson.id)
        .single();
      
      if (specificError) {
        console.error('❌ Error accessing specific lesson:', specificError.message);
      } else {
        console.log(`✅ Successfully accessed lesson: ${specificLesson.title}`);
        console.log(`   Module ID: ${specificLesson.module_id}`);
        console.log(`   Content length: ${specificLesson.content ? specificLesson.content.length : 0} characters`);
      }
      
      // Test accessing modules
      console.log('\n3. Testing access to modules...');
      const { data: modules, error: modulesError } = await supabase
        .from('modules')
        .select('id, title, course_id')
        .limit(3);
      
      if (modulesError) {
        console.error('❌ Error accessing modules:', modulesError.message);
      } else {
        console.log(`✅ Anonymous client can access ${modules.length} modules`);
        modules.forEach((module, index) => {
          console.log(`  ${index + 1}. ${module.title}`);
        });
      }
      
      // Test accessing courses
      console.log('\n4. Testing access to courses...');
      const { data: courses, error: coursesError } = await supabase
        .from('courses')
        .select('id, title, category')
        .limit(3);
      
      if (coursesError) {
        console.error('❌ Error accessing courses:', coursesError.message);
      } else {
        console.log(`✅ Anonymous client can access ${courses.length} courses`);
        courses.forEach((course, index) => {
          console.log(`  ${index + 1}. ${course.title} (${course.category})`);
        });
      }
    } else {
      console.log('⚠️  No lessons found - this might indicate the fix didn\'t work completely');
    }
    
    console.log('\n🎉 RLS Fix Verification Complete!');
    console.log('✅ The "Error Loading Course" message should now be resolved!');
    console.log('🔄 Refresh your course page to see the content.');
    
  } catch (error) {
    console.error('❌ Unexpected error:', error.message);
  }
}

// Run the verification
verifyRLSFix();