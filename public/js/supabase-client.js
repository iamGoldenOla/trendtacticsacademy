// First ensure Supabase library is loaded
if (typeof supabase === 'undefined') {
  console.error('Supabase library not loaded. Please include the Supabase CDN script first.');
}

// Check if environment config exists
if (!window.__ENV__) {
  throw new Error("Missing environment config");
}

const { SUPABASE_URL, SUPABASE_ANON_KEY } = window.__ENV__;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  throw new Error("Missing Supabase credentials");
}

// Create Supabase client instance
window.supabase = supabase.createClient(
  SUPABASE_URL,
  SUPABASE_ANON_KEY
);