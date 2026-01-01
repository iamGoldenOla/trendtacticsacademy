<?php
// api/get-student-courses.php
require_once '../vendor/autoload.php'; // Adjust path as needed
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

    // Query to get courses the user has access to
    $query = "
        SELECT 
            c.id as course_id,
            c.title as course_title,
            c.description as course_description,
            c.level as course_level,
            c.category as course_category,
            c.image_url as course_image_url,
            sca.purchase_date as enrollment_date,
            sca.access_status
        FROM courses c
        INNER JOIN student_course_access sca ON c.id = sca.course_id
        WHERE sca.user_id = :user_id
          AND sca.access_status = 'active'
        ORDER BY c.created_at
    ";

    $stmt = $pdo->prepare($query);
    $stmt->bindParam(':user_id', $user_id, PDO::PARAM_STR);
    $stmt->execute();
    
    $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

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