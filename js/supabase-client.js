// /js/supabase-client.js
(function () {
  if (!window.supabase) {
    console.error("❌ Supabase SDK not loaded");
    return;
  }

  if (!window.__ENV__) {
    console.error("❌ window.__ENV__ missing");
    return;
  }

  if (!window.__ENV__.SUPABASE_ANON_KEY || window.__ENV__.SUPABASE_ANON_KEY.length < 100) {
    console.error("❌ Invalid or truncated SUPABASE_ANON_KEY in env.js");
    console.error("Current key length:", window.__ENV__.SUPABASE_ANON_KEY.length);
    return;
  }

  if (window.supabaseClient) {
    console.warn("⚠️ Supabase client already initialized");
    return;
  }

  window.supabaseClient = supabase.createClient(
    window.__ENV__.SUPABASE_URL,
    window.__ENV__.SUPABASE_ANON_KEY
  );

  console.log("✅ Supabase client initialized");
  
  // Test the connection
  window.supabaseClient.auth.getSession()
    .then(({ data, error }) => {
      if (error) {
        console.error('❌ Supabase auth error:', error.message);
        console.log('Please check your Supabase project settings and API key');
      } else {
        console.log('✅ Supabase auth ready');
      }
    });
})();
