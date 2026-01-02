<?php
// api/config.php
// Supabase configuration for course access system

// Supabase configuration
define('SUPABASE_URL', 'https://uimdbodamoeyukrghchb.supabase.co');
define('SUPABASE_ANON_KEY', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc');

// Supabase Service Role Key for administrative operations
// IMPORTANT: This key has full access to your database and should be kept secure
// Use environment variable if available, otherwise use hardcoded value (not recommended for production)
// To set environment variable on your server:
// - For Apache: use SetEnv SUPABASE_SERVICE_ROLE_KEY your_key_value in .htaccess
// - For environment files: export SUPABASE_SERVICE_ROLE_KEY=your_key_value
// - For cPanel: set in Environment Variables section
$serviceRoleKey = getenv('SUPABASE_SERVICE_ROLE_KEY') ?: '';

// For security, if no environment variable is set, provide a way to define it directly
// But remember: NEVER COMMIT YOUR ACTUAL SERVICE ROLE KEY TO VERSION CONTROL
if (empty($serviceRoleKey)) {
    // You should set your actual service role key here after downloading the code to your server
    // But DO NOT commit this change to the repository
    $serviceRoleKey = ''; // Replace with your actual service role key after downloading to your server
}

define('SUPABASE_SERVICE_ROLE_KEY', $serviceRoleKey);

// CORS headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}