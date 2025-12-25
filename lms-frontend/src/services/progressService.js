import { supabase } from './supabaseClient';

/**
 * Get all progress for the current user
 */
export const getUserProgress = async () => {
    try {
        // Get current user
        const { data: { user }, error: authError } = await supabase.auth.getUser();
        
        if (authError || !user) {
            throw new Error('User not authenticated');
        }
        
        const { data: progress, error: progressError } = await supabase
            .from('lesson_progress')
            .select('*')
            .eq('user_id', user.id);
        
        if (progressError) {
            console.error('Error fetching user progress:', progressError.message);
            return [];
        }
        
        return progress || [];
    }
    catch (error) {
        console.error('Error fetching user progress:', error);
        return [];
    }
};

/**
 * Get user progress for a specific course
 */
export const getCourseProgress = async (courseId) => {
    try {
        // Get current user
        const { data: { user }, error: authError } = await supabase.auth.getUser();
        
        if (authError || !user) {
            throw new Error('User not authenticated');
        }
        
        const { data: progress, error: progressError } = await supabase
            .from('lesson_progress')
            .select('*')
            .eq('user_id', user.id)
            .eq('course_id', courseId);
        
        if (progressError) {
            console.error('Error fetching course progress:', progressError.message);
            return [];
        }
        
        return progress || [];
    }
    catch (error) {
        console.error(`Error fetching progress for course ${courseId}:`, error);
        return [];
    }
};

/**
 * Calculate completion percentage for a course
 */
export const calculateCourseCompletion = (progress, totalLessons) => {
    if (!progress.length || totalLessons === 0)
        return 0;
    const completedLessons = progress.filter(p => p.completed).length;
    return Math.round((completedLessons / totalLessons) * 100);
};

/**
 * Update progress for a lesson
 */
export const updateProgress = async (lessonId, courseId, completed) => {
    try {
        // Get current user
        const { data: { user }, error: authError } = await supabase.auth.getUser();
        
        if (authError || !user) {
            throw new Error('User not authenticated');
        }
        
        // Create or update lesson completion record
        const { data: progress, error: progressError } = await supabase
            .from('lesson_progress')
            .upsert([
                { 
                    user_id: user.id, 
                    course_id: courseId, 
                    lesson_id: lessonId, 
                    completed, 
                    completed_at: completed ? new Date().toISOString() : null
                }
            ])
            .select()
            .single();
        
        if (progressError) {
            console.error('Error updating progress:', progressError.message);
            throw new Error(progressError.message);
        }
        
        return progress;
    }
    catch (error) {
        console.error(`Error updating progress for lesson ${lessonId}:`, error);
        return null;
    }
};

export default {
    getUserProgress,
    getCourseProgress,
    calculateCourseCompletion,
    updateProgress,
};