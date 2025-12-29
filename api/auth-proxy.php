<?php
// CORS headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Get the request method and path
$method = $_SERVER['REQUEST_METHOD'];
$path = $_GET['path'] ?? '';

// Validate the path - allow auth endpoints AND REST API endpoints
$isAuthPath = preg_match('/^\/auth\/v1\/(signup|signin|signout|user|recover|verify|token|authorize|magiclink|otp)$/', $path);
$isRestPath = preg_match('/^\/rest\/v1\//', $path);

if (!$isAuthPath && !$isRestPath) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid path', 'error_description' => 'The requested path is not allowed']);
    exit();
}

// Supabase configuration
$supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
$supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

// Build the target URL
$targetUrl = $supabaseUrl . $path;

// Get the request body
$input = file_get_contents('php://input');

// Parse query string to get additional parameters
$queryParams = $_GET;
// Remove the 'path' parameter as it's already used
unset($queryParams['path']);

// If there are additional query parameters, append them to the URL
if (!empty($queryParams)) {
    $targetUrl .= '?' . http_build_query($queryParams);
}

// Set up the cURL request to Supabase
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $targetUrl);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);
curl_setopt($ch, CURLOPT_POSTFIELDS, $input);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 30);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);

// Set headers - only use apikey, not Bearer token for auth endpoints
$headers = [
    'Content-Type: application/json',
    'apikey: ' . $supabaseAnonKey,
    'User-Agent: Trendtactics-Academy-Auth-Proxy/1.0'
];

curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

// Execute the request
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$curlError = curl_error($ch);

curl_close($ch);

// Handle cURL errors
if ($curlError) {
    http_response_code(500);
    echo json_encode(['error' => 'Connection error', 'error_description' => $curlError]);
    exit();
}

// Set the response headers
header('Content-Type: application/json');
http_response_code($httpCode);

// Output the response
echo $response;
?>