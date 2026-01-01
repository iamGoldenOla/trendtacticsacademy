<?php
// api/remove-course-access.php
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
$action = $input['action'] ?? 'cancel'; // 'cancel', 'expire', or 'delete'

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

    // Determine the new status based on action
    $new_status = 'active';
    switch ($action) {
        case 'cancel':
        case 'cancelled':
            $new_status = 'cancelled';
            break;
        case 'expire':
        case 'expired':
            $new_status = 'expired';
            break;
        case 'delete':
            // For delete, we'll remove the record entirely
            $deleteQuery = "DELETE FROM student_course_access WHERE user_id = :user_id AND course_id = :course_id";
            $deleteStmt = $pdo->prepare($deleteQuery);
            $deleteStmt->bindParam(':user_id', $user_id, PDO::PARAM_STR);
            $deleteStmt->bindParam(':course_id', $course_id, PDO::PARAM_STR);
            
            if ($deleteStmt->execute()) {
                echo json_encode([
                    'success' => true,
                    'message' => 'Course access removed successfully',
                    'action' => 'deleted'
                ]);
                exit();
            } else {
                throw new Exception('Failed to delete course access');
            }
            break;
        default:
            $new_status = 'cancelled'; // default to cancelled
    }

    // Update the access status
    $updateQuery = "UPDATE student_course_access SET access_status = :status, updated_at = NOW() WHERE user_id = :user_id AND course_id = :course_id";
    $updateStmt = $pdo->prepare($updateQuery);
    $updateStmt->bindParam(':status', $new_status, PDO::PARAM_STR);
    $updateStmt->bindParam(':user_id', $user_id, PDO::PARAM_STR);
    $updateStmt->bindParam(':course_id', $course_id, PDO::PARAM_STR);
    
    if ($updateStmt->execute()) {
        echo json_encode([
            'success' => true,
            'message' => 'Course access status updated successfully',
            'action' => $new_status
        ]);
    } else {
        throw new Exception('Failed to update course access status');
    }

} catch (Exception $e) {
    error_log('Error updating course access: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to update course access',
        'message' => $e->getMessage()
    ]);
}
?>