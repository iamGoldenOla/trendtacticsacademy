#!/usr/bin/env node

// Script to verify and publish lessons
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

console.log('🔍 Lesson Verification and Publishing Tool');
console.log('=====================================\n');

// Validate environment variables
if (!supabaseUrl || !supabaseServiceRoleKey) {
  console.error('❌ Error: Supabase credentials not found in environment variables');
  process.exit(1);
}

console.log('✅ Environment variables loaded successfully');

// Create Supabase client with service role key
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    persistSession: false,
    autoRefreshToken: false
  }
});

async function verifyAndPublish() {
  try {
    console.log('1. Checking lesson publication status...');
    
    // Get all lessons
    const { data: allLessons, error: lessonsError } = await supabase
      .from('lessons')
      .select('id, title, is_published');
    
    if (lessonsError) {
      console.error('❌ Error fetching lessons:', lessonsError.message);
      return;
    }
    
    console.log(`✅ Found ${allLessons.length} lessons`);
    
    // Count unpublished lessons
    const unpublishedLessons = allLessons.filter(lesson => !lesson.is_published);
    console.log(`📊 Unpublished lessons: ${unpublishedLessons.length}`);
    
    if (unpublishedLessons.length > 0) {
      console.log('\n2. Publishing unpublished lessons...');
      
      // Update all lessons to be published
      const { error: updateError } = await supabase
        .from('lessons')
        .update({ is_published: true })
        .in('id', unpublishedLessons.map(lesson => lesson.id));
      
      if (updateError) {
        console.error('❌ Error publishing lessons:', updateError.message);
      } else {
        console.log(`✅ Successfully published ${unpublishedLessons.length} lessons`);
      }
    } else {
      console.log('✅ All lessons are already published');
    }
    
    console.log('\n3. Verifying modules are published...');
    
    // Get all modules
    const { data: allModules, error: modulesError } = await supabase
      .from('modules')
      .select('id, title, is_published');
    
    if (modulesError) {
      console.error('❌ Error fetching modules:', modulesError.message);
      return;
    }
    
    console.log(`✅ Found ${allModules.length} modules`);
    
    // Count unpublished modules
    const unpublishedModules = allModules.filter(module => !module.is_published);
    console.log(`📊 Unpublished modules: ${unpublishedModules.length}`);
    
    if (unpublishedModules.length > 0) {
      console.log('\n4. Publishing unpublished modules...');
      
      // Update all modules to be published
      const { error: updateModulesError } = await supabase
        .from('modules')
        .update({ is_published: true })
        .in('id', unpublishedModules.map(module => module.id));
      
      if (updateModulesError) {
        console.error('❌ Error publishing modules:', updateModulesError.message);
      } else {
        console.log(`✅ Successfully published ${unpublishedModules.length} modules`);
      }
    } else {
      console.log('✅ All modules are already published');
    }
    
    console.log('\n5. Final verification...');
    
    // Check with anon client
    const supabaseAnon = createClient(supabaseUrl, process.env.SUPABASE_ANON_KEY);
    
    const { data: anonLessons, error: anonError } = await supabaseAnon
      .from('lessons')
      .select('id, title')
      .limit(3);
    
    if (anonError) {
      console.log('⚠️  Anon client still has issues:', anonError.message);
    } else {
      console.log(`✅ Anon client can now access ${anonLessons.length} lessons`);
      if (anonLessons.length > 0) {
        anonLessons.forEach((lesson, index) => {
          console.log(`  ${index + 1}. ${lesson.title}`);
        });
      }
    }
    
    console.log('\n🎉 Verification and Publishing Complete!');
    console.log('🔄 Refresh your course page - the "Error Loading Course" message should now be gone.');
    
  } catch (error) {
    console.error('❌ Unexpected error:', error.message);
  }
}

// Run the function
verifyAndPublish();