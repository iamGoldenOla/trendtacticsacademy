<?php
// api/add-course-access.php
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

    // Check if user already has access to this course
    $checkQuery = "SELECT id FROM student_course_access WHERE user_id = :user_id AND course_id = :course_id";
    $checkStmt = $pdo->prepare($checkQuery);
    $checkStmt->bindParam(':user_id', $user_id, PDO::PARAM_STR);
    $checkStmt->bindParam(':course_id', $course_id, PDO::PARAM_STR);
    $checkStmt->execute();
    
    if ($checkStmt->rowCount() > 0) {
        // User already has access, update the status if needed
        $updateQuery = "UPDATE student_course_access SET access_status = 'active', updated_at = NOW() WHERE user_id = :user_id AND course_id = :course_id";
        $updateStmt = $pdo->prepare($updateQuery);
        $updateStmt->bindParam(':user_id', $user_id, PDO::PARAM_STR);
        $updateStmt->bindParam(':course_id', $course_id, PDO::PARAM_STR);
        $updateStmt->execute();
        
        echo json_encode([
            'success' => true,
            'message' => 'Course access updated successfully',
            'action' => 'updated'
        ]);
    } else {
        // Insert new course access record
        $insertQuery = "
            INSERT INTO student_course_access (user_id, course_id, access_status)
            VALUES (:user_id, :course_id, 'active')
        ";
        
        $insertStmt = $pdo->prepare($insertQuery);
        $insertStmt->bindParam(':user_id', $user_id, PDO::PARAM_STR);
        $insertStmt->bindParam(':course_id', $course_id, PDO::PARAM_STR);
        
        if ($insertStmt->execute()) {
            echo json_encode([
                'success' => true,
                'message' => 'Course access granted successfully',
                'action' => 'created'
            ]);
        } else {
            throw new Exception('Failed to insert course access');
        }
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