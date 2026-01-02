<?php
// api/courses.php
require_once 'config.php'; // Supabase configuration

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Get input data
$input = json_decode(file_get_contents('php://input'), true);
$title = $input['title'] ?? null;

// Also check for GET parameter
if (!$title && isset($_GET['title'])) {
    $title = $_GET['title'];
}

if (!$title) {
    http_response_code(400);
    echo json_encode(['error' => 'Course title is required']);
    exit();
}

try {
    // Build the Supabase REST API URL to get courses by title
    $supabaseUrl = constant('SUPABASE_URL');
    $anonKey = constant('SUPABASE_ANON_KEY');
    
    // First, try to get course by title from the courses table
    $coursesUrl = $supabaseUrl . '/rest/v1/courses';
    $params = [
        'select' => 'id,title,description,level,category,thumbnail_url',
        'title' => 'eq.' . $title,
        'status' => 'eq.published'
    ];
    
    $query = http_build_query($params);
    $fullUrl = $coursesUrl . '?' . $query;
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $fullUrl);
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
    
    if ($httpCode !== 200) {
        throw new Exception('Supabase request failed with HTTP code: ' . $httpCode);
    }
    
    $courses = json_decode($response, true);
    
    if (empty($courses)) {
        // If no course found by exact title match, try a more flexible search
        $params = [
            'select' => 'id,title,description,level,category,thumbnail_url',
            'title' => 'ilike.%' . $title . '%',
            'status' => 'eq.published'
        ];
        
        $query = http_build_query($params);
        $fullUrl = $coursesUrl . '?' . $query;
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $fullUrl);
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
        
        if ($httpCode !== 200) {
            throw new Exception('Supabase request failed with HTTP code: ' . $httpCode);
        }
        
        $courses = json_decode($response, true);
    }
    
    // Return the first matching course
    $course = !empty($courses) ? $courses[0] : null;
    
    if ($course) {
        echo json_encode($course);
    } else {
        // Return a default course ID based on title if no match found in database
        $defaultCourses = [
            'Vibe Coding' => [
                'id' => 'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
                'title' => 'Vibe Coding: Building Real Software with AI',
                'description' => 'The modern way of building software where humans focus on intent, systems, and outcomes while AI handles execution.',
                'level' => 'Beginner',
                'category' => 'Programming'
            ],
            'Prompt Engineering' => [
                'id' => 'a1b2c3d4-e5f6-7890-1234-567890abcdef',
                'title' => 'Prompt Engineering Mastery',
                'description' => 'Master the art of communicating with AI. Learn to write effective prompts that get consistent, high-quality results.',
                'level' => 'Beginner',
                'category' => 'AI'
            ],
            'Facebook Ads' => [
                'id' => 'b2c3d4e5-f6a7-8901-2345-67890abcdef1',
                'title' => 'Facebook Ads Mastery',
                'description' => 'Run profitable ad campaigns with AI optimization and advanced targeting strategies.',
                'level' => 'Beginner',
                'category' => 'Marketing'
            ]
        ];
        
        foreach ($defaultCourses as $key => $defaultCourse) {
            if (strpos(strtolower($title), strtolower($key)) !== false) {
                echo json_encode($defaultCourse);
                exit();
            }
        }
        
        // If no course found, return null
        echo json_encode(null);
    }

} catch (Exception $e) {
    error_log('Error fetching course by title: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to fetch course',
        'message' => $e->getMessage()
    ]);
}
?>