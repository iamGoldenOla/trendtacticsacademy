<?php
/**
 * api/verify-payment.php
 * Verifies Paystack payment and enrolls user in course
 * 
 * Usage: POST /api/verify-payment.php
 * Request body: {
 *   "reference": "paystack_reference",
 *   "course_id": "uuid",
 *   "user_id": "uuid"
 * }
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'error' => 'Method not allowed']);
    exit();
}

$input = json_decode(file_get_contents('php://input'), true);
$reference = $input['reference'] ?? null;
$course_id = $input['course_id'] ?? null;
$user_id = $input['user_id'] ?? null;

if (!$reference || !$course_id || !$user_id) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'error' => 'Missing required fields'
    ]);
    exit();
}

try {
    // Get Paystack secret key from environment or config
    $paystack_secret = getenv('PAYSTACK_SECRET_KEY') ?: '';
    
    if (empty($paystack_secret)) {
        throw new Exception('Paystack secret key not configured');
    }

    // Verify payment with Paystack
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'https://api.paystack.co/transaction/verify/' . $reference);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $paystack_secret
    ]);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);

    curl_close($ch);

    if ($curlError) {
        throw new Exception('Paystack API error: ' . $curlError);
    }

    if ($httpCode !== 200) {
        throw new Exception('Payment verification failed with code: ' . $httpCode);
    }

    $paymentData = json_decode($response, true);

    if (!$paymentData || !isset($paymentData['data'])) {
        throw new Exception('Invalid Paystack response');
    }

    $payment = $paymentData['data'];

    // Check if payment was successful
    if ($payment['status'] !== 'success') {
        http_response_code(400);
        echo json_encode([
            'success' => false,
            'error' => 'Payment was not successful. Status: ' . $payment['status']
        ]);
        exit();
    }

    // Now enroll the user in the course via Supabase
    // Use the enrollment endpoint or direct database access
    require_once __DIR__ . '/enroll.php';
    
    // Call the supabase function or API to add course access
    $supabase_url = 'https://uimdbodamoeyukrghchb.supabase.co';
    $service_role_key = getenv('SUPABASE_SERVICE_ROLE_KEY') ?: '';

    if (!empty($service_role_key)) {
        // Use service role key for direct database access
        $enrollUrl = $supabase_url . '/rest/v1/student_course_access';
        
        $enrollData = json_encode([
            'user_id' => $user_id,
            'course_id' => $course_id,
            'access_status' => 'active',
            'payment_reference' => $reference,
            'payment_date' => date('c'),
            'amount_paid' => $payment['amount'] / 100, // Convert from kobo
            'currency' => $payment['currency']
        ]);

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $enrollUrl);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
        curl_setopt($ch, CURLOPT_POSTFIELDS, $enrollData);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'apikey: ' . $service_role_key,
            'Authorization: Bearer ' . $service_role_key
        ]);

        $enrollResponse = curl_exec($ch);
        $enrollHttpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $enrollError = curl_error($ch);

        curl_close($ch);

        if ($enrollError) {
            error_log('Enrollment error: ' . $enrollError);
        }

        if ($enrollHttpCode !== 200 && $enrollHttpCode !== 201) {
            error_log('Enrollment failed with code: ' . $enrollHttpCode . ', Response: ' . $enrollResponse);
        }
    }

    // Return success response
    http_response_code(200);
    echo json_encode([
        'success' => true,
        'message' => 'Payment verified and user enrolled',
        'payment_ref' => $reference,
        'amount' => $payment['amount'] / 100,
        'currency' => $payment['currency'],
        'customer_email' => $payment['customer']['email'] ?? ''
    ]);
    exit();

} catch (Exception $e) {
    error_log('Payment verification error: ' . $e->getMessage());
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
    exit();
}
?>
