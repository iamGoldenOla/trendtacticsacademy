<?php
/**
 * api/enroll.php
 * Frontend-friendly enrollment endpoint that bypasses CSP restrictions
 * 
 * Usage: POST /api/enroll.php
 * Request body: {
 *   "course_id": "uuid",
 *   "user_id": "uuid",
 *   "auth_token": "jwt_token"
 * }
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Only allow POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit();
}

// Get input
$input = json_decode(file_get_contents('php://input'), true);
$course_id = $input['course_id'] ?? null;
$user_id = $input['user_id'] ?? null;
$auth_token = $input['auth_token'] ?? null;

// Validate inputs
if (!$course_id || !$user_id || !$auth_token) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'error' => 'Missing required fields: course_id, user_id, auth_token'
    ]);
    exit();
}

try {
    // Validate UUID format
    $uuidPattern = '/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i';
    
    if (!preg_match($uuidPattern, $course_id)) {
        throw new Exception('Invalid course ID format');
    }
    
    if (!preg_match($uuidPattern, $user_id)) {
        throw new Exception('Invalid user ID format');
    }

    // Supabase configuration
    $supabase_url = 'https://uimdbodamoeyukrghchb.supabase.co';
    $service_role_key = getenv('SUPABASE_SERVICE_ROLE_KEY') ?: '';
    
    // If no service role key in environment, try to get from config
    if (empty($service_role_key) && file_exists(__DIR__ . '/config.php')) {
        require_once __DIR__ . '/config.php';
        $service_role_key = constant('SUPABASE_SERVICE_ROLE_KEY');
    }
    
    // If we still don't have a service role key, we'll use the edge function approach
    // This allows the frontend's auth token to be used instead
    
    // ===== APPROACH 1: Use Supabase Edge Function (if available) =====
    // This is the primary approach - calls the edge function with the user's auth token
    
    $edgeFunction_url = $supabase_url . '/functions/v1/add-course-access';
    
    $edgeFunction_payload = json_encode([
        'course_id' => $course_id,
        'user_id' => $user_id
    ]);
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $edgeFunction_url);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
    curl_setopt($ch, CURLOPT_POSTFIELDS, $edgeFunction_payload);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
    
    // Pass the auth token from frontend
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $auth_token
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    
    curl_close($ch);
    
    // Check for curl errors
    if ($curlError) {
        error_log('Enrollment curl error: ' . $curlError);
        throw new Exception('Network error: ' . $curlError);
    }
    
    // Check HTTP response code
    if ($httpCode === 200 || $httpCode === 201) {
        $result = json_decode($response, true);
        
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'message' => 'Successfully enrolled in course',
            'data' => $result
        ]);
        exit();
    } 
    elseif ($httpCode === 401 || $httpCode === 403) {
        // Authentication failed - token invalid or expired
        http_response_code(401);
        echo json_encode([
            'success' => false,
            'error' => 'Authentication failed. Please log in again.',
            'http_code' => $httpCode
        ]);
        exit();
    }
    elseif ($httpCode === 409) {
        // User already enrolled
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'message' => 'You are already enrolled in this course',
            'already_enrolled' => true
        ]);
        exit();
    }
    else {
        // Other error
        error_log('Enrollment failed. HTTP: ' . $httpCode . ', Response: ' . $response);
        throw new Exception('Enrollment failed with HTTP ' . $httpCode . '. ' . $response);
    }
    
} catch (Exception $e) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
    exit();
}
?>
