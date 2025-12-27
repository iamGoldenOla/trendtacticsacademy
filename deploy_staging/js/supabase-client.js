// Shared Supabase client for all HTML pages
const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_ANON_KEY = window.__ENV__?.SUPABASE_ANON_KEY ?? null;

if (!SUPABASE_ANON_KEY) {
  console.error('Missing SUPABASE_ANON_KEY. Do not hardcode keys in client files. Provide via window.__ENV__ or a secure config.');
  window.sbClient = {
    auth: {
      async getSession() { return { data: { session: null }, error: new Error('Supabase not configured') }; },
      async getUser() { return { data: { user: null }, error: new Error('Supabase not configured') }; },
      async signOut() { return { error: new Error('Supabase not configured') }; },
      async signInWithPassword() { return { data: null, error: new Error('Supabase not configured') }; },
      async signUp() { return { data: null, error: new Error('Supabase not configured') }; },
    },
    from() { return { select: async () => ({ data: null, error: new Error('Supabase not configured') }) }; },
  };
} else {
  const { createClient } = supabase;
  window.sbClient = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
}
