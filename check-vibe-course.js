#!/usr/bin/env node

// Script to check if VIBE CODING course exists
const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function checkVibeCourse() {
  try {
    console.log('🔍 Checking for VIBE CODING course...');
    
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .ilike('title', '%VIBE%');
    
    if (error) {
      console.log('❌ Error checking for VIBE course:', error.message);
      return;
    }
    
    if (data.length > 0) {
      console.log(`✅ Found ${data.length} VIBE-related course(s):`);
      data.forEach(course => {
        console.log(`  - ${course.title} (ID: ${course.id})`);
      });
    } else {
      console.log('📭 No VIBE CODING course found');
    }
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

// Run the check
checkVibeCourse();