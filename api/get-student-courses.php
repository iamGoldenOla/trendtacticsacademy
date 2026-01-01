<?php
// api/get-student-courses.php
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

if (!$user_id) {
    http_response_code(400);
    echo json_encode(['error' => 'User ID is required']);
    exit();
}

try {
    // Validate user ID format (UUID)
    if (!preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i', $user_id)) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid user ID format']);
        exit();
    }

    // Build the Supabase REST API URL to get courses for the user
    $supabaseUrl = constant('SUPABASE_URL');
    $anonKey = constant('SUPABASE_ANON_KEY');
    
    // Query the student_course_access and courses tables directly using Supabase REST API
    // Using the foreign key relationship between tables
    $queryUrl = $supabaseUrl . '/rest/v1/student_course_access?select=course_id,access_status,purchase_date,courses!inner(id,title,description,level,category,image_url)&user_id=eq.' . $user_id . '&access_status=eq.active';
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $queryUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'apikey: ' . $anonKey,
        'Authorization: Bearer ' . $anonKey
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);
    
    if ($curlError) {
        throw new Exception('Curl error: ' . $curlError);
    }
    
    if ($httpCode !== 200) {
        throw new Exception('Supabase request failed with HTTP code: ' . $httpCode . '. Response: ' . $response);
    }
    
    $rawData = json_decode($response, true);
    
    // Process the data to match the expected format
    $courses = [];
    if (is_array($rawData)) {
        foreach ($rawData as $item) {
            $course = $item['courses'];
            $courses[] = [
                'course_id' => $course['id'],
                'course_title' => $course['title'],
                'course_description' => $course['description'],
                'course_level' => $course['level'],
                'course_category' => $course['category'],
                'course_image_url' => $course['image_url'],
                'enrollment_date' => $item['purchase_date'],
                'access_status' => $item['access_status']
            ];
        }
    }

    // Return the courses
    echo json_encode([
        'success' => true,
        'courses' => $courses,
        'count' => count($courses)
    ]);

} catch (Exception $e) {
    error_log('Error fetching student courses: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to fetch courses',
        'message' => $e->getMessage()
    ]);
}
?>