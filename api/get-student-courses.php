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

    // First, get the user's course access records using the proxy
    $accessUrl = './auth-proxy.php?path=/rest/v1/student_course_access';
    $accessParams = [
        'select' => 'course_id,access_status,purchase_date',
        'user_id' => 'eq.' . $user_id,
        'access_status' => 'eq.active'
    ];
    
    $accessUrl .= '&' . http_build_query($accessParams);
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $accessUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, false); // GET request
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
    ]);
    
    $accessResponse = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);
    
    if ($curlError) {
        throw new Exception('Curl error when fetching course access: ' . $curlError);
    }
    
    if ($httpCode !== 200) {
        // If the table doesn't exist or there's an error, return empty array
        if ($httpCode === 404 || $httpCode === 400) {
            echo json_encode([
                'success' => true,
                'courses' => [],
                'count' => 0
            ]);
            exit();
        }
        throw new Exception('Supabase request failed for course access with HTTP code: ' . $httpCode . '. Response: ' . $accessResponse);
    }
    
    $accessData = json_decode($accessResponse, true);
    
    if (empty($accessData)) {
        // No enrolled courses, return empty array
        echo json_encode([
            'success' => true,
            'courses' => [],
            'count' => 0
        ]);
        exit();
    }
    
    // Extract course IDs
    $courseIds = array_map(function($item) {
        return $item['course_id'];
    }, $accessData);
    
    if (empty($courseIds)) {
        // No course IDs to fetch, return empty array
        echo json_encode([
            'success' => true,
            'courses' => [],
            'count' => 0
        ]);
        exit();
    }
    
    // Create a query to get course details for these IDs
    $courseIdsList = implode(',', array_map(function($id) {
        return '"' . $id . '"';
    }, $courseIds));
    
    $coursesUrl = './auth-proxy.php?path=/rest/v1/courses';
    $courseParams = [
        'select' => 'id,title,description,level,category,thumbnail_url',
        'status' => 'eq.published',
        'id' => 'in.(' . $courseIdsList . ')'
    ];
    
    $coursesUrl .= '&' . http_build_query($courseParams);
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $coursesUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, false); // GET request
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
    ]);
    
    $coursesResponse = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);
    
    if ($curlError) {
        throw new Exception('Curl error when fetching courses: ' . $curlError);
    }
    
    if ($httpCode !== 200) {
        // If the courses table doesn't exist or there's an error, return empty array
        if ($httpCode === 404 || $httpCode === 400) {
            echo json_encode([
                'success' => true,
                'courses' => [],
                'count' => 0
            ]);
            exit();
        }
        throw new Exception('Supabase request failed for courses with HTTP code: ' . $httpCode . '. Response: ' . $coursesResponse);
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