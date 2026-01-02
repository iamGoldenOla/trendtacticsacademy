<?php
// Debug script to test Supabase connection and enrollment functionality
require_once 'config.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    $supabaseUrl = constant('SUPABASE_URL');
    $anonKey = constant('SUPABASE_ANON_KEY');
    
    // Test basic connection by trying to access the courses table
    $testUrl = $supabaseUrl . '/rest/v1/courses?select=count';
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $testUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'apikey: ' . $anonKey,
        'Authorization: Bearer ' . $anonKey,
        'Content-Type: application/json'
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);
    
    if ($curlError) {
        throw new Exception('Curl error: ' . $curlError);
    }
    
    $result = [
        'connection_test' => [
            'http_code' => $httpCode,
            'response' => $response,
            'success' => $httpCode === 200
        ]
    ];
    
    // Test student_course_access table if courses table exists
    if ($httpCode === 200) {
        $accessTestUrl = $supabaseUrl . '/rest/v1/student_course_access?select=count';
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $accessTestUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'apikey: ' . $anonKey,
            'Authorization: Bearer ' . $anonKey,
            'Content-Type: application/json'
        ]);
        
        $accessResponse = curl_exec($ch);
        $accessHttpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $accessCurlError = curl_error($ch);
        curl_close($ch);
        
        $result['table_test'] = [
            'http_code' => $accessHttpCode,
            'response' => $accessResponse,
            'success' => $accessHttpCode === 200,
            'error' => $accessCurlError
        ];
    }
    
    echo json_encode($result, JSON_PRETTY_PRINT);
    
} catch (Exception $e) {
    error_log('Debug enrollment error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Debug failed',
        'message' => $e->getMessage()
    ]);
}
?>