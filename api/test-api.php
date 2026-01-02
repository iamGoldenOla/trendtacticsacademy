<?php
// Simple test to check if API endpoints are working
header('Content-Type: application/json');

echo json_encode([
    'status' => 'success',
    'message' => 'API is working',
    'timestamp' => date('c')
]);
?>