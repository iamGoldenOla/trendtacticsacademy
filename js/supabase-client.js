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

  if (window.supabaseClient) {
    console.warn("⚠️ Supabase client already initialized");
    return;
  }

  window.supabaseClient = supabase.createClient(
    window.__ENV__.SUPABASE_URL,
    window.__ENV__.SUPABASE_ANON_KEY
  );

  console.log("✅ Supabase client initialized");
})();
