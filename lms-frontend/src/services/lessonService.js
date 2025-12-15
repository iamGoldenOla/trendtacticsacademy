import { get, post, put, del } from "./api";

const LESSON_ENDPOINTS = {
    GET_ALL: '/lessons',
    GET_BY_ID: (id) => `/lessons/${id}`,
    GET_BY_COURSE: (courseId) => `/courses/${courseId}/lessons`,
    CREATE: '/lessons',
    UPDATE: (id) => `/lessons/${id}`,
    DELETE: (id) => `/lessons/${id}`,
    MARK_COMPLETE: (id) => `/lessons/${id}/complete`,
    GET_QUIZ: (lessonId) => `/lessons/${lessonId}/quiz`,
};

/**
 * Get all lessons for a course
 */
export const getLessonsByCourse = async (courseId) => {
    try {
        const response = await get(LESSON_ENDPOINTS.GET_BY_COURSE(courseId));
        if (response.success && response.data) {
            return response.data;
        }
        return [];
    }
    catch (error) {
        console.error(`Error fetching lessons for course ${courseId}:`, error);
        return [];
    }
};

/**
 * Get lesson by ID
 */
export const getLessonById = async (id) => {
    try {
        const response = await get(LESSON_ENDPOINTS.GET_BY_ID(id));
        if (response.success && response.data) {
            return response.data;
        }
        return null;
    }
    catch (error) {
        console.error(`Error fetching lesson with ID ${id}:`, error);
        return null;
    }
};

/**
 * Create a new lesson (instructor/admin only)
 */
export const createLesson = async (lessonData) => {
    try {
        const response = await post(LESSON_ENDPOINTS.CREATE, lessonData);
        if (response.success && response.data) {
            return response.data;
        }
        return null;
    }
    catch (error) {
        console.error('Error creating lesson:', error);
        throw new Error(error.response?.data?.message || error.message || 'Failed to create lesson');
    }
};

/**
 * Update an existing lesson (instructor/admin only)
 */
export const updateLesson = async (id, lessonData) => {
    try {
        const response = await put(LESSON_ENDPOINTS.UPDATE(id), lessonData);
        if (response.success && response.data) {
            return response.data;
        }
        return null;
    }
    catch (error) {
        console.error(`Error updating lesson with ID ${id}:`, error);
        throw new Error(error.response?.data?.message || error.message || 'Failed to update lesson');
    }
};

/**
 * Delete a lesson (instructor/admin only)
 */
export const deleteLesson = async (id) => {
    try {
        const response = await del(LESSON_ENDPOINTS.DELETE(id));
        return response.success || false;
    }
    catch (error) {
        console.error(`Error deleting lesson with ID ${id}:`, error);
        return false;
    }
};

/**
 * Mark a lesson as complete
 */
export const markLessonComplete = async (lessonId) => {
    try {
        const response = await post(LESSON_ENDPOINTS.MARK_COMPLETE(lessonId));
        return response.success || false;
    }
    catch (error) {
        console.error(`Error marking lesson ${lessonId} as complete:`, error);
        return false;
    }
};

/**
 * Get quiz questions for a lesson
 */
export const getLessonQuiz = async (lessonId) => {
    try {
        const response = await get(LESSON_ENDPOINTS.GET_QUIZ(lessonId));
        if (response.success && response.data) {
            return response.data;
        }
        return [];
    }
    catch (error) {
        console.error(`Error fetching quiz for lesson ${lessonId}:`, error);
        return [];
    }
};

export default {
    getLessonsByCourse,
    getLessonById,
    createLesson,
    updateLesson,
    deleteLesson,
    markLessonComplete,
    getLessonQuiz,
};