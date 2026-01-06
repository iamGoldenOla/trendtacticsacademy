if (!window.__ENV__) {
  throw new Error("ENV not loaded. env.js is missing.");
}

const { SUPABASE_URL, SUPABASE_ANON_KEY } = window.__ENV__;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  throw new Error("Missing Supabase ENV variables.");
}

window.supabaseClient = supabase.createClient(
  SUPABASE_URL,
  SUPABASE_ANON_KEY,
  {
    auth: {
      persistSession: true,
      autoRefreshToken: true
    }
  }
);