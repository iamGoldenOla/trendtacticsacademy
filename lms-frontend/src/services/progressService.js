import { get, post } from "./api";

const PROGRESS_ENDPOINTS = {
    GET_USER_PROGRESS: '/progress/user',
    GET_COURSE_PROGRESS: (courseId) => `/progress/course/${courseId}`,
    UPDATE_PROGRESS: '/progress',
};

/**
 * Get all progress for the current user
 */
export const getUserProgress = async () => {
    try {
        const response = await get(PROGRESS_ENDPOINTS.GET_USER_PROGRESS);
        if (response.success && response.data) {
            return response.data;
        }
        return [];
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
        const response = await get(PROGRESS_ENDPOINTS.GET_COURSE_PROGRESS(courseId));
        if (response.success && response.data) {
            return response.data;
        }
        return [];
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
        const progressData = {
            lesson: lessonId,
            course: courseId,
            completed,
        };
        const response = await post(PROGRESS_ENDPOINTS.UPDATE_PROGRESS, progressData);
        if (response.success && response.data) {
            return response.data;
        }
        return null;
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