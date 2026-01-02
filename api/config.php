<?php
// api/config.php
// Supabase configuration for course access system

// Supabase configuration
define('SUPABASE_URL', 'https://uimdbodamoeyukrghchb.supabase.co');
define('SUPABASE_ANON_KEY', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc');

// Supabase Service Role Key for administrative operations
// IMPORTANT: This key has full access to your database and should be kept secure
// For production, use environment variables instead of hardcoding the key
// Example of how to use environment variables:
// define('SUPABASE_SERVICE_ROLE_KEY', getenv('SUPABASE_SERVICE_ROLE_KEY') ?: '');

// For local development only - REPLACE with your actual service role key or use environment variables
// NEVER COMMIT YOUR ACTUAL SERVICE ROLE KEY TO VERSION CONTROL
define('SUPABASE_SERVICE_ROLE_KEY', ''); // Replace with your actual service role key

// CORS headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}