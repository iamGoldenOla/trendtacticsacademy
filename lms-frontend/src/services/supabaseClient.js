import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || 'https://doyrfbndzpcarfkulbhe.supabase.co';
const supabaseAnonKey = process.env.REACT_APP_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRveXJmYm5kenBjYXJma3VsYmhlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQwMTQwNDcsImV4cCI6MjA5OTU5MDA0N30.CCxRVIb0YpYlgnI1Qc_VQSZhcdAxiNWf9cNFBOe-9lc';

// Create and export the Supabase client
export const supabase = createClient(supabaseUrl, supabaseAnonKey);