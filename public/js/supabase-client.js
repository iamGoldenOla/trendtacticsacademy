// Wait for DOM to be ready and ensure Supabase library is loaded
function initializeSupabase() {
  if (typeof supabase === 'undefined') {
    console.error('Supabase library not loaded. Please include the Supabase CDN script first.');
    return;
  }

  // Check if environment config exists
  if (!window.__ENV__) {
    console.error("Missing environment config");
    return;
  }

  const { SUPABASE_URL, SUPABASE_ANON_KEY } = window.__ENV__;

  if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
    console.error("Missing Supabase credentials");
    return;
  }

  // Create Supabase client instance
  window.supabase = supabase.createClient(
    SUPABASE_URL,
    SUPABASE_ANON_KEY
  );
}

// Initialize when DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initializeSupabase);
} else {
  initializeSupabase();
}