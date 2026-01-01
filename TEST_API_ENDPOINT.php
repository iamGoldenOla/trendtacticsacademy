<?php
// TEST API ENDPOINT
// This script tests the get-student-courses.php endpoint
 
// Test data - replace with your actual user ID
$test_user_id = 'YOUR_USER_ID_HERE'; // Replace with actual user UUID

// Prepare the request
$url = './api/get-student-courses.php';
$data = json_encode([
    'user_id' => $test_user_id
]);

// Initialize cURL
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json'
]);

// Execute the request
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

// Output the result
echo "HTTP Code: " . $httpCode . "\n";
echo "Response: " . $response . "\n";

// If testing from browser, format as HTML
if (isset($_SERVER['HTTP_HOST'])) {
    echo "<h3>Test Results:</h3>";
    echo "<p><strong>HTTP Code:</strong> " . $httpCode . "</p>";
    echo "<p><strong>Response:</strong></p><pre>" . htmlspecialchars($response) . "</pre>";
}
?>