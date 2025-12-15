import { post, get } from "./api";
import { endpoints } from "../config/env";

// AI Service Endpoints - using configuration
const AI_ENDPOINTS = {
    CHAT: endpoints.ai.chat,
    START_SESSION: endpoints.ai.startSession,
    GET_SESSION: (sessionId) => endpoints.ai.getSession(sessionId),
    GET_RECOMMENDATIONS: endpoints.ai.recommendations,
    GET_ANALYTICS: endpoints.ai.analytics,
    GENERATE_CONTENT: endpoints.ai.generateContent,
    ANALYZE_PROGRESS: endpoints.ai.analyzeProgress,
    PERSONALIZE_PATH: endpoints.ai.personalizePath,
};

/**
 * AI Service for TrendyAI Integration
 * Handles all AI-powered features including tutoring, recommendations, and analytics
 */
class AIService {
    constructor() {
        this.currentSession = null;
    }

    static getInstance() {
        if (!AIService.instance) {
            AIService.instance = new AIService();
        }
        return AIService.instance;
    }

    /**
     * Start a new AI tutor session
     */
    async startTutorSession(context) {
        try {
            const response = await post(AI_ENDPOINTS.START_SESSION, context);
            if (response.success && response.data) {
                this.currentSession = response.data;
                return response.data;
            }
            throw new Error(response.message || 'Failed to start AI tutor session');
        }
        catch (error) {
            console.error('Start tutor session error:', error);
            throw new Error(error.response?.data?.message || error.message || 'Failed to start AI session');
        }
    }

    /**
     * Send a message to the AI tutor
     */
    async sendMessage(sessionId, message, context) {
        try {
            const response = await post(AI_ENDPOINTS.CHAT, {
                sessionId,
                message,
                context,
            });
            if (response.success && response.data) {
                return response.data;
            }
            throw new Error(response.message || 'Failed to send message to AI tutor');
        }
        catch (error) {
            console.error('Send AI message error:', error);
            throw new Error(error.response?.data?.message || error.message || 'Failed to communicate with AI');
        }
    }

    /**
     * Get AI-powered learning recommendations
     */
    async getRecommendations(context) {
        try {
            const response = await post(AI_ENDPOINTS.GET_RECOMMENDATIONS, context);
            if (response.success && response.data) {
                return response.data;
            }
            throw new Error(response.message || 'Failed to get AI recommendations');
        }
        catch (error) {
            console.error('Get AI recommendations error:', error);
            throw new Error(error.response?.data?.message || error.message || 'Failed to get recommendations');
        }
    }

    /**
     * Get AI analytics for user learning patterns
     */
    async getAnalytics(userId) {
        try {
            const response = await get(`${AI_ENDPOINTS.GET_ANALYTICS}?userId=${userId}`);
            if (response.success && response.data) {
                return response.data;
            }
            throw new Error(response.message || 'Failed to get AI analytics');
        }
        catch (error) {
            console.error('Get AI analytics error:', error);
            throw new Error(error.response?.data?.message || error.message || 'Failed to get analytics');
        }
    }

    /**
     * Generate AI-powered content (quizzes, scenarios, etc.)
     */
    async generateContent(type, context) {
        try {
            const response = await post(AI_ENDPOINTS.GENERATE_CONTENT, {
                type,
                ...context
            });
            if (response.success && response.data) {
                return response.data;
            }
            throw new Error(response.message || 'Failed to generate AI content');
        }
        catch (error) {
            console.error('Generate AI content error:', error);
            throw new Error(error.response?.data?.message || error.message || 'Failed to generate content');
        }
    }

    /**
     * Analyze user progress and provide insights
     */
    async analyzeProgress(context) {
        try {
            const response = await post(AI_ENDPOINTS.ANALYZE_PROGRESS, context);
            if (response.success && response.data) {
                return response.data;
            }
            throw new Error(response.message || 'Failed to analyze progress');
        }
        catch (error) {
            console.error('Analyze progress error:', error);
            throw new Error(error.response?.data?.message || error.message || 'Failed to analyze progress');
        }
    }

    /**
     * Get personalized learning path
     */
    async personalizeLearningPath(context) {
        try {
            const response = await post(AI_ENDPOINTS.PERSONALIZE_PATH, context);
            if (response.success && response.data) {
                return response.data;
            }
            throw new Error(response.message || 'Failed to personalize learning path');
        }
        catch (error) {
            console.error('Personalize learning path error:', error);
            throw new Error(error.response?.data?.message || error.message || 'Failed to personalize path');
        }
    }

    /**
     * Get current tutor session
     */
    getCurrentSession() {
        return this.currentSession;
    }

    /**
     * Clear current session
     */
    clearSession() {
        this.currentSession = null;
    }
}

// Export singleton instance
export const aiService = AIService.getInstance();
export default aiService;