// Test environment variables
console.log('=== Environment Variables Test ===');
console.log('REACT_APP_SUPABASE_URL:', process.env.REACT_APP_SUPABASE_URL);
console.log('REACT_APP_SUPABASE_ANON_KEY exists:', !!process.env.REACT_APP_SUPABASE_ANON_KEY);
console.log('REACT_APP_SUPABASE_ANON_KEY length:', process.env.REACT_APP_SUPABASE_ANON_KEY?.length || 0);

// Test if we can create a Supabase client
try {
  const { createClient } = require('@supabase/supabase-js');
  
  if (process.env.REACT_APP_SUPABASE_URL && process.env.REACT_APP_SUPABASE_ANON_KEY) {
    const supabase = createClient(
      process.env.REACT_APP_SUPABASE_URL,
      process.env.REACT_APP_SUPABASE_ANON_KEY
    );
    console.log('✅ Supabase client created successfully');
  } else {
    console.log('❌ Missing Supabase environment variables');
  }
} catch (error) {
  console.log('❌ Error creating Supabase client:', error.message);
}