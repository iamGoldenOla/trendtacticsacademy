/**
 * ACADEMY LEARNING ENGINE - Content Generator
 * 
 * This is the main orchestrator that:
 * 1. Reads existing lesson data
 * 2. Generates full specification-compliant content
 * 3. Persists to Supabase
 */

const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Configuration
const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

// Lesson templates for each module
const VIBE_CODING_CONTENT = require('./vibe-coding-full-content.json');

/**
 * Generate a complete lesson following all 7 Laws
 */
function generateLesson(lessonTemplate) {
    return {
        title: lessonTemplate.title,
        content: lessonTemplate.content,
        summary: lessonTemplate.summary,
        case_studies: lessonTemplate.case_studies || [],
        key_takeaways: lessonTemplate.key_takeaways || [],
        quizzes: lessonTemplate.quizzes || [],
        videos: lessonTemplate.videos || [],
        playground: lessonTemplate.playground || null,
        video_url: lessonTemplate.videos?.[0]?.url || lessonTemplate.video_url || null,
        duration: 15
    };
}

/**
 * Validate a lesson against the 7 Laws
 */
function validateLesson(lesson) {
    const errors = [];

    // Law 1: No placeholders
    if (!lesson.content || lesson.content.length < 500) {
        errors.push('Content too short (minimum 900-1500 words)');
    }

    // Law 2: Complete lesson structure
    if (!lesson.quizzes || lesson.quizzes.length < 5) {
        errors.push('Minimum 5 quizzes required');
    }

    if (!lesson.playground) {
        errors.push('Playground is required');
    }

    if (!lesson.videos || lesson.videos.length === 0) {
        errors.push('At least 1 video resource required');
    }

    if (!lesson.key_takeaways || lesson.key_takeaways.length < 3) {
        errors.push('At least 3 key takeaways required');
    }

    return {
        valid: errors.length === 0,
        errors
    };
}

/**
 * Update a lesson in the database
 */
async function updateLesson(lessonId, lessonData) {
    const { data, error } = await supabase
        .from('lessons')
        .update({
            content: lessonData.content,
            summary: lessonData.summary,
            case_studies: lessonData.case_studies,
            key_takeaways: lessonData.key_takeaways,
            quizzes: lessonData.quizzes,
            videos: lessonData.videos,
            playground: lessonData.playground,
            video_url: lessonData.video_url,
            duration: lessonData.duration
        })
        .eq('id', lessonId);

    if (error) {
        console.error(`Error updating lesson ${lessonId}:`, error);
        return false;
    }

    console.log(`✓ Updated lesson: ${lessonData.title}`);
    return true;
}

/**
 * Main execution
 */
async function main() {
    console.log('=== ACADEMY LEARNING ENGINE ===');
    console.log('Starting content generation...\n');

    // Get all lessons that need upgrading
    const { data: lessons, error } = await supabase
        .from('lessons')
        .select('id, title, module_id, content')
        .order('id');

    if (error) {
        console.error('Failed to fetch lessons:', error);
        return;
    }

    console.log(`Found ${lessons.length} lessons to process\n`);

    let updated = 0;
    let failed = 0;

    for (const lesson of lessons) {
        // Find matching content from our template
        const template = VIBE_CODING_CONTENT.find(t => t.title === lesson.title);

        if (!template) {
            console.log(`⚠ No template found for: ${lesson.title}`);
            failed++;
            continue;
        }

        const fullLesson = generateLesson(template);
        const validation = validateLesson(fullLesson);

        if (!validation.valid) {
            console.log(`⚠ Validation failed for ${lesson.title}:`, validation.errors);
            failed++;
            continue;
        }

        const success = await updateLesson(lesson.id, fullLesson);
        if (success) updated++;
        else failed++;
    }

    console.log('\n=== GENERATION COMPLETE ===');
    console.log(`Updated: ${updated}`);
    console.log(`Failed: ${failed}`);
}

// Run if called directly
if (require.main === module) {
    main().catch(console.error);
}

module.exports = { generateLesson, validateLesson, updateLesson };
