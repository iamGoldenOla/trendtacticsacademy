// /js/supabase-client.js
// Must load AFTER the Supabase CDN

(function () {
  if (typeof supabase === "undefined") {
    console.error("❌ Supabase SDK not loaded");
    return;
  }

  if (!window.__ENV__) {
    console.error("❌ window.__ENV__ is missing");
    return;
  }

  const { SUPABASE_URL, SUPABASE_ANON_KEY } = window.__ENV__;

  if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
    console.error("❌ Supabase credentials missing");
    return;
  }

  // ✅ DO NOT overwrite `supabase`
  // ✅ Single global client
  window.supabaseClient = supabase.createClient(
    SUPABASE_URL,
    SUPABASE_ANON_KEY
  );

  console.log("✅ Supabase client ready");
})();
