<?php
// This is a test file to verify that the CSP headers are being applied correctly
header('Content-Type: application/json');
echo json_encode([
    'csp_header' => $_SERVER['HTTP_CONTENT_SECURITY_POLICY'] ?? 'Not set',
    'status' => 'CSP test endpoint working',
    'timestamp' => date('Y-m-d H:i:s')
]);
?>