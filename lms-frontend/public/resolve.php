<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

try {
    // Get course ID
    $courseId = $_GET['id'] ?? null;
    if (!$courseId) {
        throw new Exception('Course ID is required');
    }

    // Supabase configuration
    $supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
    $supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

    // Check if course has modules
    $modulesUrl = $supabaseUrl . '/rest/v1/modules?course_id=eq.' . urlencode($courseId) . '&select=*';
    $context = stream_context_create([
        'http' => [
            'method' => 'GET',
            'header' => 'apikey: ' . $supabaseKey . "\r\n" .
                       'Authorization: Bearer ' . $supabaseKey . "\r\n",
            'timeout' => 30
        ]
    ]);

    $modulesResponse = @file_get_contents($modulesUrl, false, $context);
    if ($modulesResponse === false) {
        $error = error_get_last();
        error_log('Supabase modules request failed: ' . ($error ? $error['message'] : 'Unknown error'));
        throw new Exception('Failed to connect to database. Network error: ' . ($error ? $error['message'] : 'Connection timeout'));
    }

    $modules = json_decode($modulesResponse, true);
    if (json_last_error() !== JSON_ERROR_NONE) {
        throw new Exception('Invalid JSON response from Supabase');
    }

    // If modules exist, content is already generated
    if (!empty($modules)) {
        echo json_encode(['success' => true, 'message' => 'Content already exists']);
        exit;
    }

    // Get course details to determine what to generate
    $courseUrl = $supabaseUrl . '/rest/v1/courses?id=eq.' . urlencode($courseId) . '&select=*';
    $courseResponse = @file_get_contents($courseUrl, false, $context);
    if ($courseResponse === false) {
        $error = error_get_last();
        error_log('Supabase course request failed: ' . ($error ? $error['message'] : 'Unknown error'));
        throw new Exception('Failed to fetch course details. Network error: ' . ($error ? $error['message'] : 'Connection timeout'));
    }

    $courses = json_decode($courseResponse, true);
    if (empty($courses)) {
        throw new Exception('Course not found');
    }

    $course = $courses[0];
    $courseTitle = strtolower($course['title']);

    // Generate content based on course type
    if (strpos($courseTitle, 'vibe coding') !== false) {
        generateVibeCodingCourse($courseId, $supabaseUrl, $supabaseKey);
    } elseif (strpos($courseTitle, 'facebook ads') !== false) {
        generateFacebookAdsCourse($courseId, $supabaseUrl, $supabaseKey);
    } elseif (strpos($courseTitle, 'prompt engineering') !== false) {
        generatePromptEngineeringCourse($courseId, $supabaseUrl, $supabaseKey);
    } else {
        // Generic course generation
        generateGenericCourse($courseId, $course['title'], $supabaseUrl, $supabaseKey);
    }

    echo json_encode(['success' => true, 'message' => 'Course content generated successfully']);

} catch (Exception $e) {
    error_log('Resolve error: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}

function generateVibeCodingCourse($courseId, $supabaseUrl, $supabaseKey) {
    $modules = [
        ['title' => 'Introduction to Vibe Coding', 'ordering' => 1],
        ['title' => 'Setting Up Your Environment', 'ordering' => 2],
        ['title' => 'Basic Concepts', 'ordering' => 3],
        ['title' => 'Advanced Techniques', 'ordering' => 4],
        ['title' => 'Real-World Applications', 'ordering' => 5],
        ['title' => 'Best Practices', 'ordering' => 6]
    ];

    $lessonTitles = [
        'What is Vibe Coding?',
        'Why Vibe Coding Matters',
        'Getting Started with Vibe Coding',
        'Installing Development Tools',
        'Configuring Your Workspace',
        'Understanding the Basics',
        'Variables and Data Types',
        'Control Structures',
        'Functions and Methods',
        'Object-Oriented Programming',
        'Error Handling',
        'Debugging Techniques',
        'Working with APIs',
        'Database Integration',
        'Version Control',
        'Testing Your Code',
        'Deployment Strategies',
        'Performance Optimization',
        'Security Best Practices',
        'Code Reviews',
        'Collaboration Tools',
        'Continuous Integration',
        'Advanced Frameworks',
        'Mobile Development',
        'Web Applications',
        'Final Project'
    ];

    createModulesAndLessons($courseId, $modules, $lessonTitles, $supabaseUrl, $supabaseKey);
}

function generateFacebookAdsCourse($courseId, $supabaseUrl, $supabaseKey) {
    $modules = [
        ['title' => 'Facebook Ads Fundamentals', 'ordering' => 1],
        ['title' => 'Campaign Setup', 'ordering' => 2],
        ['title' => 'Audience Targeting', 'ordering' => 3],
        ['title' => 'Ad Creative', 'ordering' => 4],
        ['title' => 'Budget and Bidding', 'ordering' => 5],
        ['title' => 'Analytics and Optimization', 'ordering' => 6]
    ];

    $lessonTitles = [
        'Introduction to Facebook Advertising',
        'Facebook Ads Manager Overview',
        'Understanding Ad Objectives',
        'Campaign Structure',
        'Setting Up Your First Campaign',
        'Ad Set Configuration',
        'Creating Effective Ads',
        'Audience Insights',
        'Custom Audience Creation',
        'Lookalike Audiences',
        'Interest-Based Targeting',
        'Demographic Targeting',
        'Geographic Targeting',
        'Ad Formats and Types',
        'Writing Compelling Ad Copy',
        'Designing Eye-Catching Creatives',
        'A/B Testing Strategies',
        'Budget Allocation',
        'Bidding Strategies',
        'Cost Control',
        'Performance Metrics',
        'Conversion Tracking',
        'A/B Testing and Optimization',
        'Retargeting Campaigns',
        'Advanced Strategies',
        'Scaling Successful Campaigns'
    ];

    createModulesAndLessons($courseId, $modules, $lessonTitles, $supabaseUrl, $supabaseKey);
}

function generatePromptEngineeringCourse($courseId, $supabaseUrl, $supabaseKey) {
    $modules = [
        ['title' => 'Prompt Engineering Basics', 'ordering' => 1],
        ['title' => 'Advanced Techniques', 'ordering' => 2],
        ['title' => 'Specialized Applications', 'ordering' => 3],
        ['title' => 'Best Practices', 'ordering' => 4]
    ];

    $lessonTitles = [
        'What is Prompt Engineering?',
        'Understanding AI Language Models',
        'Basic Prompt Structure',
        'Context and Instructions',
        'Role-Based Prompting',
        'Chain of Thought Prompting',
        'Few-Shot Learning',
        'Zero-Shot Prompting',
        'Prompt Optimization',
        'Handling Ambiguity',
        'Creative Writing Prompts',
        'Technical Writing Prompts',
        'Code Generation Prompts',
        'Data Analysis Prompts',
        'Research and Summarization',
        'Ethical Considerations'
    ];

    createModulesAndLessons($courseId, $modules, $lessonTitles, $supabaseUrl, $supabaseKey);
}

function generateGenericCourse($courseId, $courseTitle, $supabaseUrl, $supabaseKey) {
    $modules = [
        ['title' => 'Introduction', 'ordering' => 1],
        ['title' => 'Core Concepts', 'ordering' => 2],
        ['title' => 'Practical Applications', 'ordering' => 3],
        ['title' => 'Advanced Topics', 'ordering' => 4]
    ];

    $lessonTitles = [
        'Welcome to ' . $courseTitle,
        'Course Overview',
        'Getting Started',
        'Basic Principles',
        'Core Concepts',
        'Practical Examples',
        'Hands-on Exercises',
        'Common Challenges',
        'Best Practices',
        'Advanced Techniques',
        'Real-World Applications',
        'Case Studies',
        'Tools and Resources',
        'Final Assessment',
        'Next Steps',
        'Course Conclusion'
    ];

    createModulesAndLessons($courseId, $modules, $lessonTitles, $supabaseUrl, $supabaseKey);
}

function createModulesAndLessons($courseId, $modules, $lessonTitles, $supabaseUrl, $supabaseKey) {
    $context = stream_context_create([
        'http' => [
            'method' => 'POST',
            'header' => 'Content-Type: application/json' . "\r\n" .
                       'apikey: ' . $supabaseKey . "\r\n" .
                       'Authorization: Bearer ' . $supabaseKey . "\r\n" .
                       'Prefer: return=representation' . "\r\n",
            'content' => ''
        ]
    ]);

    $lessonIndex = 0;

    foreach ($modules as $moduleData) {
        // Create module
        $modulePayload = json_encode([
            'course_id' => $courseId,
            'title' => $moduleData['title'],
            'ordering' => $moduleData['ordering'],
            'created_at' => date('c'),
            'updated_at' => date('c')
        ]);

        $contextWithContent = stream_context_create([
            'http' => [
                'method' => 'POST',
                'header' => 'Content-Type: application/json' . "\r\n" .
                           'apikey: ' . $supabaseKey . "\r\n" .
                           'Authorization: Bearer ' . $supabaseKey . "\r\n" .
                           'Prefer: return=representation' . "\r\n",
                'content' => $modulePayload
            ]
        ]);

        $moduleResponse = file_get_contents($supabaseUrl . '/rest/v1/modules', false, $contextWithContent);
        if ($moduleResponse === false) {
            throw new Exception('Failed to create module: ' . $moduleData['title']);
        }

        $createdModules = json_decode($moduleResponse, true);
        if (empty($createdModules)) {
            throw new Exception('Module creation failed for: ' . $moduleData['title']);
        }

        $moduleId = $createdModules[0]['id'];

        // Create lessons for this module (distribute evenly)
        $lessonsPerModule = ceil(count($lessonTitles) / count($modules));
        $startIndex = $lessonIndex;
        $endIndex = min($startIndex + $lessonsPerModule, count($lessonTitles));

        for ($i = $startIndex; $i < $endIndex; $i++) {
            $lessonPayload = json_encode([
                'module_id' => $moduleId,
                'course_id' => $courseId,
                'title' => $lessonTitles[$i],
                'content' => 'Comprehensive lesson content for: ' . $lessonTitles[$i],
                'ordering' => $i + 1,
                'created_at' => date('c'),
                'updated_at' => date('c')
            ]);

            $lessonContext = stream_context_create([
                'http' => [
                    'method' => 'POST',
                    'header' => 'Content-Type: application/json' . "\r\n" .
                               'apikey: ' . $supabaseKey . "\r\n" .
                               'Authorization: Bearer ' . $supabaseKey . "\r\n" .
                               'Prefer: return=representation' . "\r\n",
                    'content' => $lessonPayload
                ]
            ]);

            $lessonResponse = file_get_contents($supabaseUrl . '/rest/v1/lessons', false, $lessonContext);
            if ($lessonResponse === false) {
                throw new Exception('Failed to create lesson: ' . $lessonTitles[$i]);
            }
        }

        $lessonIndex = $endIndex;
    }
}
?>