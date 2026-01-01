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
    
    // Try using the RPC function first
    $rpcUrl = $supabaseUrl . '/rest/v1/rpc/get_student_courses';
    $rpcParams = [
        'p_user_id' => $user_id
    ];
    
    $rpcQuery = http_build_query($rpcParams);
    $fullRpcUrl = $rpcUrl . '?' . $rpcQuery;
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $fullRpcUrl);
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
        // If RPC fails, try the direct table approach
        $courses = tryDirectTableApproach($user_id, $supabaseUrl, $anonKey);
    } else {
        if ($httpCode === 200) {
            // RPC worked, return the data
            $courses = json_decode($response, true);
        } else {
            // RPC failed, try the direct table approach
            $courses = tryDirectTableApproach($user_id, $supabaseUrl, $anonKey);
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

// Function to try the direct table approach as fallback
function tryDirectTableApproach($user_id, $supabaseUrl, $anonKey) {
    // First, get the user's course access records
    $accessUrl = $supabaseUrl . '/rest/v1/student_course_access';
    $accessParams = [
        'select' => 'course_id,access_status,purchase_date',
        'user_id' => 'eq.' . $user_id,
        'access_status' => 'eq.active'
    ];
    
    $accessQuery = http_build_query($accessParams);
    $fullAccessUrl = $accessUrl . '?' . $accessQuery;
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $fullAccessUrl);
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
    
    if ($accessCurlError || $accessHttpCode !== 200) {
        return []; // Return empty array if we can't access the student_course_access table
    }
    
    $accessData = json_decode($accessResponse, true);
    
    if (empty($accessData)) {
        return []; // No enrolled courses
    }
    
    // Extract course IDs
    $courseIds = array_map(function($item) {
        return $item['course_id'];
    }, $accessData);
    
    if (empty($courseIds)) {
        return []; // No course IDs to fetch
    }
    
    // Create a query to get course details for these IDs
    $courseIdsList = implode(',', array_map(function($id) {
        return '"' . $id . '"';
    }, $courseIds));
    
    $coursesUrl = $supabaseUrl . '/rest/v1/courses';
    $courseParams = [
        'select' => 'id,title,description,level,category,thumbnail_url',
        'status' => 'eq.published',
        'id' => 'in.(' . $courseIdsList . ')'
    ];
    
    $coursesQuery = http_build_query($courseParams);
    $fullCoursesUrl = $coursesUrl . '?' . $coursesQuery;
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $fullCoursesUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'apikey: ' . $anonKey,
        'Authorization: Bearer ' . $anonKey,
        'Content-Type: application/json'
    ]);
    
    $coursesResponse = curl_exec($ch);
    $coursesHttpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $coursesCurlError = curl_error($ch);
    curl_close($ch);
    
    if ($coursesCurlError || $coursesHttpCode !== 200) {
        return []; // Return empty array if we can't access the courses table
    }
    
    $coursesData = json_decode($coursesResponse, true);
    
    // Combine the data
    $courses = [];
    foreach ($coursesData as $course) {
        // Find the corresponding access data
        foreach ($accessData as $access) {
            if ($access['course_id'] === $course['id']) {
                $courses[] = [
                    'course_id' => $course['id'],
                    'course_title' => $course['title'],
                    'course_description' => $course['description'],
                    'course_level' => $course['level'],
                    'course_category' => $course['category'],
                    'course_image_url' => $course['thumbnail_url'],
                    'enrollment_date' => $access['purchase_date'],
                    'access_status' => $access['access_status']
                ];
                break;
            }
        }
    }
    
    return $courses;
}
?>