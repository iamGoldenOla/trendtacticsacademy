<?php
// api/add-course-access.php
require_once 'config.php'; // Supabase configuration

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit();
}

// Get input data
$input = json_decode(file_get_contents('php://input'), true);
$user_id = $input['user_id'] ?? null;
$course_id = $input['course_id'] ?? null;

if (!$user_id || !$course_id) {
    http_response_code(400);
    echo json_encode(['error' => 'User ID and Course ID are required']);
    exit();
}

try {
    // Validate user ID format (UUID)
    if (!preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i', $user_id)) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid user ID format']);
        exit();
    }
    
    // Validate course ID format (UUID)
    if (!preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i', $course_id)) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid course ID format']);
        exit();
    }

    // Build the Supabase REST API URL to insert course access
    $supabaseUrl = constant('SUPABASE_URL');
    $anonKey = constant('SUPABASE_ANON_KEY');
    
    // First, check if the user already has access to this course
    $checkUrl = $supabaseUrl . '/rest/v1/student_course_access?select=id&user_id=eq.' . $user_id . '&course_id=eq.' . $course_id . '&apikey=' . $anonKey;
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $checkUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'apikey: ' . $anonKey,
        'Authorization: Bearer ' . $anonKey
    ]);
    
    $checkResponse = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);
    
    if ($curlError) {
        throw new Exception('Curl error during check: ' . $curlError);
    }
    
    if ($httpCode !== 200) {
        throw new Exception('Supabase check request failed with HTTP code: ' . $httpCode);
    }
    
    $existingRecords = json_decode($checkResponse, true);
    
    if (!empty($existingRecords)) {
        // User already has access, update the status to active
        $updateUrl = $supabaseUrl . '/rest/v1/student_course_access?user_id=eq.' . $user_id . '&course_id=eq.' . $course_id . '&apikey=' . $anonKey;
        
        $updateData = json_encode([
            'access_status' => 'active',
            'updated_at' => date('c') // ISO 8601 format
        ]);
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $updateUrl);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PATCH');
        curl_setopt($ch, CURLOPT_POSTFIELDS, $updateData);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'apikey: ' . $anonKey,
            'Authorization: Bearer ' . $anonKey
        ]);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $curlError = curl_error($ch);
        curl_close($ch);
        
        if ($curlError) {
            throw new Exception('Curl error during update: ' . $curlError);
        }
        
        if ($httpCode !== 200 && $httpCode !== 204) {
            throw new Exception('Supabase update request failed with HTTP code: ' . $httpCode);
        }
        
        echo json_encode([
            'success' => true,
            'message' => 'Course access updated successfully',
            'action' => 'updated'
        ]);
    } else {
        // Insert new course access record
        $insertUrl = $supabaseUrl . '/rest/v1/student_course_access?apikey=' . $anonKey;
        
        $insertData = json_encode([
            'user_id' => $user_id,
            'course_id' => $course_id,
            'access_status' => 'active'
        ]);
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $insertUrl);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $insertData);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'apikey: ' . $anonKey,
            'Authorization: Bearer ' . $anonKey
        ]);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $curlError = curl_error($ch);
        curl_close($ch);
        
        if ($curlError) {
            throw new Exception('Curl error during insert: ' . $curlError);
        }
        
        if ($httpCode !== 201) {
            throw new Exception('Supabase insert request failed with HTTP code: ' . $httpCode);
        }
        
        echo json_encode([
            'success' => true,
            'message' => 'Course access granted successfully',
            'action' => 'created'
        ]);
    }

} catch (Exception $e) {
    error_log('Error adding course access: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to add course access',
        'message' => $e->getMessage()
    ]);
}
?>