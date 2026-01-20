<?php
// api/resolve.php
require_once 'config.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

$courseId = $_GET['id'] ?? null;

if (isset($_GET['test'])) {
    echo json_encode(['status' => 'ok', 'php_version' => PHP_VERSION, 'curl' => function_exists('curl_init')]);
    exit();
}

if (!$courseId) {
    echo json_encode(['error' => 'Missing course ID']);
    exit();
}
error_log('resolve.php: Resolving course ID: ' . $courseId);

$supabaseUrl = defined('SUPABASE_URL') ? SUPABASE_URL : '';
$anonKey = defined('SUPABASE_ANON_KEY') ? SUPABASE_ANON_KEY : '';
$serviceRoleKey = defined('SUPABASE_SERVICE_ROLE_KEY') ? SUPABASE_SERVICE_ROLE_KEY : '';

if (empty($supabaseUrl) || empty($anonKey)) {
    http_response_code(500);
    echo json_encode(['error' => 'Supabase configuration missing']);
    exit();
}

// Helper for Supabase requests
function supabaseRequest($method, $path, $data = null, $useServiceRole = false)
{
    global $supabaseUrl, $anonKey, $serviceRoleKey;

    $key = $useServiceRole && !empty($serviceRoleKey) ? $serviceRoleKey : $anonKey;
    $url = $supabaseUrl . '/rest/v1/' . $path;

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);

    $headers = [
        'apikey: ' . $key,
        'Authorization: Bearer ' . $key,
        'Content-Type: application/json',
        'Prefer: return=representation'
    ];

    if ($method === 'POST' && $data) {
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    }

    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return [
        'code' => $httpCode,
        'data' => json_decode($response, true)
    ];
}

try {
    // 1. Fetch course with modules and lessons
    // Note: Supabase REST doesn't support nested joins easily in one query for deep trees 
    // unless you use select=*,modules(*,lessons(*))
    $res = supabaseRequest('GET', 'courses?id=eq.' . $courseId . '&select=*,modules(*,lessons(*))');

    if ($res['code'] !== 200 || empty($res['data'])) {
        error_log('resolve.php: Course not found in Supabase. Code: ' . $res['code']);
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Course not found in database']);
        exit();
    }

    $course = $res['data'][0];

    // 2. Check if course has content
    $hasLessons = false;
    if (!empty($course['modules'])) {
        foreach ($course['modules'] as $module) {
            if (!empty($module['lessons'])) {
                $hasLessons = true;
                break;
            }
        }
    }

    if ($hasLessons) {
        echo json_encode(['success' => true, 'data' => $course]);
        exit();
    }

    // 3. Generate content if missing
    $title = $course['title'];
    $generatedContent = generateCourseStructure($title);

    // 4. Persist to DB (Atomic-ish)
    foreach ($generatedContent['modules'] as $mIdx => $mData) {
        $moduleInsert = [
            'course_id' => $courseId,
            'title' => $mData['title'],
            'description' => $mData['description'] ?? '',
            'ordering' => $mIdx + 1,
            'duration' => $mData['duration'] ?? '1 week'
        ];

        $mRes = supabaseRequest('POST', 'modules', $moduleInsert, true);

        if ($mRes['code'] >= 200 && $mRes['code'] < 300) {
            $newModule = is_array($mRes['data']) ? $mRes['data'][0] : $mRes['data'];
            $moduleId = $newModule['id'];

            if (!empty($mData['lessons'])) {
                $lessonsToInsert = [];
                foreach ($mData['lessons'] as $lIdx => $lData) {
                    $lessonsToInsert[] = [
                        'module_id' => $moduleId,
                        'course_id' => $courseId,
                        'title' => $lData['title'],
                        'content' => $lData['content'] ?? '',
                        'ordering' => $lIdx + 1,
                        'duration' => $lData['duration'] ?? '20 min',
                        'video_url' => $lData['videoUrl'] ?? '',
                        'quiz_questions' => isset($lData['quiz']) ? json_encode($lData['quiz']) : '[]'
                    ];
                }
                supabaseRequest('POST', 'lessons', $lessonsToInsert, true);
            }
        }
    }

    // 5. Final fetch
    $finalRes = supabaseRequest('GET', 'courses?id=eq.' . $courseId . '&select=*,modules(*,lessons(*))');
    echo json_encode(['success' => true, 'data' => $finalRes['data'][0]]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}

function generateCourseStructure($title)
{
    // Simpler structures for PHP implementation
    $isVibe = stripos($title, 'Vibe') !== false;

    if ($isVibe) {
        return [
            'modules' => [
                [
                    'title' => 'Philosophy of Vibe Coding',
                    'lessons' => [
                        ['title' => 'Welcome to Vibe Coding', 'content' => 'Introduction to the Vibe Coding mindset.'],
                        ['title' => 'The Death of Syntax', 'content' => 'Why intent matters more than semicolons.']
                    ]
                ],
                [
                    'title' => 'Building with AI',
                    'lessons' => [
                        ['title' => 'Your First AI Project', 'content' => 'Rapid prototyping with Bolt and Lovable.']
                    ]
                ]
            ]
        ];
    }

    return [
        'modules' => [
            [
                'title' => 'Introduction to ' . $title,
                'lessons' => [
                    ['title' => 'Understanding ' . $title, 'content' => 'Core concepts and overview.'],
                    ['title' => 'Practical Applications', 'content' => 'How to use this in the real world.']
                ]
            ]
        ]
    ];
}
