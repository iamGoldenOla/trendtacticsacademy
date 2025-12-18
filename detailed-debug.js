#!/usr/bin/env node

// Detailed debug script to check lesson data
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration with both keys
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

console.log('🔍 Detailed Course Debug Tool');
console.log('========================\n');

// Validate environment variables
if (!supabaseUrl || !supabaseAnonKey || !supabaseServiceRoleKey) {
  console.error('❌ Error: Supabase credentials not found in environment variables');
  process.exit(1);
}

console.log('✅ Environment variables loaded successfully');

// Create Supabase clients
const supabaseAnon = createClient(supabaseUrl, supabaseAnonKey);
const supabaseAdmin = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    persistSession: false,
    autoRefreshToken: false
  }
});

async function detailedDebug() {
  try {
    console.log('1. Checking with admin client (service role key)...');
    
    // Get lessons with admin client
    const { data: adminLessons, error: adminError } = await supabaseAdmin
      .from('lessons')
      .select('*')
      .limit(5);
    
    if (adminError) {
      console.error('❌ Admin client error:', adminError.message);
    } else {
      console.log(`✅ Admin client found ${adminLessons.length} lessons (showing first 5):`);
      adminLessons.forEach((lesson, index) => {
        console.log(`  ${index + 1}. ${lesson.title} (Module ID: ${lesson.module_id})`);
      });
    }
    
    console.log('\n2. Checking with anon client (anonymous key)...');
    
    // Get lessons with anon client
    const { data: anonLessons, error: anonError } = await supabaseAnon
      .from('lessons')
      .select('*')
      .limit(5);
    
    if (anonError) {
      console.error('❌ Anon client error:', anonError.message);
    } else {
      console.log(`✅ Anon client found ${anonLessons.length} lessons (showing first 5):`);
      anonLessons.forEach((lesson, index) => {
        console.log(`  ${index + 1}. ${lesson.title} (Module ID: ${lesson.module_id})`);
      });
    }
    
    console.log('\n3. Counting with admin client...');
    const { count: adminCount, error: adminCountError } = await supabaseAdmin
      .from('lessons')
      .select('*', { count: 'exact', head: true });
    
    if (adminCountError) {
      console.error('❌ Admin count error:', adminCountError.message);
    } else {
      console.log(`📊 Admin client count: ${adminCount}`);
    }
    
    console.log('\n4. Counting with anon client...');
    const { count: anonCount, error: anonCountError } = await supabaseAnon
      .from('lessons')
      .select('*', { count: 'exact', head: true });
    
    if (anonCountError) {
      console.error('❌ Anon count error:', anonCountError.message);
    } else {
      console.log(`📊 Anon client count: ${anonCount}`);
    }
    
    console.log('\n5. Checking a specific lesson by ID...');
    if (adminLessons && adminLessons.length > 0) {
      const firstLessonId = adminLessons[0].id;
      console.log(`   Checking lesson ID: ${firstLessonId}`);
      
      const { data: specificLesson, error: specificError } = await supabaseAnon
        .from('lessons')
        .select('*')
        .eq('id', firstLessonId)
        .single();
      
      if (specificError) {
        console.error('❌ Specific lesson error:', specificError.message);
      } else {
        console.log(`✅ Found specific lesson: ${specificLesson.title}`);
      }
    }
    
    console.log('\n🔍 Debug Summary:');
    console.log('================');
    console.log('If admin client shows lessons but anon client shows none,');
    console.log('there may be Row Level Security (RLS) policies preventing');
    console.log('anonymous users from accessing the lessons.');
    
  } catch (error) {
    console.error('❌ Unexpected error:', error.message);
  }
}

// Run the debug function
detailedDebug();