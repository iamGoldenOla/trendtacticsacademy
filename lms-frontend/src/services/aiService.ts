import { get, post } from './api';
import { ApiResponse } from './types';
import { config, endpoints } from '../config/env';

// AI Service Types
export interface AIMessage {
  id: string;
  role: 'user' | 'assistant' | 'system';
  content: string;
  timestamp: Date;
  courseId?: string;
  lessonId?: string;
}

export interface AITutorSession {
  id: string;
  userId: string;
  courseId?: string;
  lessonId?: string;
  messages: AIMessage[];
  context: {
    currentTopic?: string;
    learningObjectives?: string[];
    userProgress?: number;
    difficulty?: 'beginner' | 'intermediate' | 'advanced';
  };
  createdAt: Date;
  updatedAt: Date;
}

export interface AIRecommendation {
  id: string;
  type: 'course' | 'lesson' | 'resource' | 'practice';
  title: string;
  description: string;
  confidence: number;
  reasoning: string;
  metadata: {
    courseId?: string;
    lessonId?: string;
    difficulty?: string;
    estimatedTime?: number;
  };
}

export interface AIAnalytics {
  totalSessions: number;
  averageSessionDuration: number;
  topTopics: string[];
  learningProgress: {
    completedLessons: number;
    totalLessons: number;
    averageScore: number;
  };
  engagementMetrics: {
    questionsAsked: number;
    recommendationsFollowed: number;
    timeSpent: number;
  };
}

export interface AIContentGeneration {
  type: 'quiz' | 'scenario' | 'exercise' | 'summary';
  content: any;
  metadata: {
    difficulty: string;
    estimatedTime: number;
    learningObjectives: string[];
  };
}

// AI Service Endpoints - using configuration
const AI_ENDPOINTS = {
  CHAT: endpoints.ai.chat,
  START_SESSION: endpoints.ai.startSession,
  GET_SESSION: (sessionId: string) => endpoints.ai.getSession(sessionId),
  GET_RECOMMENDATIONS: endpoints.ai.recommendations,
  GET_ANALYTICS: endpoints.ai.analytics,
  GENERATE_CONTENT: endpoints.ai.generateContent,
  ANALYZE_PROGRESS: endpoints.ai.analyzeProgress,
  PERSONALIZE_PATH: endpoints.ai.personalizePath,
} as const;

/**
 * AI Service for TrendyAI Integration
 * Handles all AI-powered features including tutoring, recommendations, and analytics
 */
class AIService {
  private static instance: AIService;
  private currentSession: AITutorSession | null = null;

  private constructor() {}

  public static getInstance(): AIService {
    if (!AIService.instance) {
      AIService.instance = new AIService();
    }
    return AIService.instance;
  }

  /**
   * Start a new AI tutor session
   */
  async startTutorSession(context: {
    courseId?: string;
    lessonId?: string;
    topic?: string;
    userLevel?: string;
  }): Promise<AITutorSession> {
    try {
      const response = await post<ApiResponse<AITutorSession>>(
        AI_ENDPOINTS.START_SESSION,
        context
      );

      if (response.success && response.data) {
        this.currentSession = response.data;
        return response.data;
      }

      throw new Error(response.message || 'Failed to start AI tutor session');
    } catch (error: any) {
      console.error('Start tutor session error:', error);
      throw new Error(error.response?.data?.message || error.message || 'Failed to start AI session');
    }
  }

  /**
   * Send a message to the AI tutor
   */
  async sendMessage(
    sessionId: string,
    message: string,
    context?: {
      courseId?: string;
      lessonId?: string;
      currentProgress?: number;
    }
  ): Promise<AIMessage> {
    try {
      const response = await post<ApiResponse<AIMessage>>(
        AI_ENDPOINTS.CHAT,
        {
          sessionId,
          message,
          context,
        }
      );

      if (response.success && response.data) {
        return response.data;
      }

      throw new Error(response.message || 'Failed to send message to AI tutor');
    } catch (error: any) {
      console.error('Send AI message error:', error);
      throw new Error(error.response?.data?.message || error.message || 'Failed to communicate with AI');
    }
  }

  /**
   * Get AI-powered learning recommendations
   */
  async getRecommendations(context: {
    userId: string;
    courseId?: string;
    currentProgress?: number;
    learningGoals?: string[];
  }): Promise<AIRecommendation[]> {
    try {
      const response = await post<ApiResponse<AIRecommendation[]>>(
        AI_ENDPOINTS.GET_RECOMMENDATIONS,
        context
      );

      if (response.success && response.data) {
        return response.data;
      }

      throw new Error(response.message || 'Failed to get AI recommendations');
    } catch (error: any) {
      console.error('Get AI recommendations error:', error);
      throw new Error(error.response?.data?.message || error.message || 'Failed to get recommendations');
    }
  }

  /**
   * Get AI analytics for user learning patterns
   */
  async getAnalytics(userId: string): Promise<AIAnalytics> {
    try {
      const response = await get<ApiResponse<AIAnalytics>>(
        `${AI_ENDPOINTS.GET_ANALYTICS}?userId=${userId}`
      );

      if (response.success && response.data) {
        return response.data;
      }

      throw new Error(response.message || 'Failed to get AI analytics');
    } catch (error: any) {
      console.error('Get AI analytics error:', error);
      throw new Error(error.response?.data?.message || error.message || 'Failed to get analytics');
    }
  }

  /**
   * Generate AI-powered content (quizzes, scenarios, etc.)
   */
  async generateContent(
    type: 'quiz' | 'scenario' | 'exercise' | 'summary',
    context: {
      courseId: string;
      lessonId?: string;
      topic: string;
      difficulty: 'beginner' | 'intermediate' | 'advanced';
      count?: number;
    }
  ): Promise<AIContentGeneration> {
    try {
      const response = await post<ApiResponse<AIContentGeneration>>(
        AI_ENDPOINTS.GENERATE_CONTENT,
        {
          type,
          ...context,
        }
      );

      if (response.success && response.data) {
        return response.data;
      }

      throw new Error(response.message || 'Failed to generate AI content');
    } catch (error: any) {
      console.error('Generate AI content error:', error);
      throw new Error(error.response?.data?.message || error.message || 'Failed to generate content');
    }
  }

  /**
   * Analyze user progress and provide insights
   */
  async analyzeProgress(context: {
    userId: string;
    courseId: string;
    timeframe?: 'week' | 'month' | 'all';
  }): Promise<{
    insights: string[];
    recommendations: string[];
    predictedOutcome: {
      completionDate: Date;
      successProbability: number;
    };
  }> {
    try {
      const response = await post<ApiResponse<any>>(
        AI_ENDPOINTS.ANALYZE_PROGRESS,
        context
      );

      if (response.success && response.data) {
        return response.data;
      }

      throw new Error(response.message || 'Failed to analyze progress');
    } catch (error: any) {
      console.error('Analyze progress error:', error);
      throw new Error(error.response?.data?.message || error.message || 'Failed to analyze progress');
    }
  }

  /**
   * Get personalized learning path
   */
  async personalizeLearningPath(context: {
    userId: string;
    courseId: string;
    learningStyle?: string;
    goals?: string[];
    timeAvailable?: number; // hours per week
  }): Promise<{
    path: {
      lessonId: string;
      estimatedTime: number;
      priority: number;
      reasoning: string;
    }[];
    totalEstimatedTime: number;
    adaptations: string[];
  }> {
    try {
      const response = await post<ApiResponse<any>>(
        AI_ENDPOINTS.PERSONALIZE_PATH,
        context
      );

      if (response.success && response.data) {
        return response.data;
      }

      throw new Error(response.message || 'Failed to personalize learning path');
    } catch (error: any) {
      console.error('Personalize learning path error:', error);
      throw new Error(error.response?.data?.message || error.message || 'Failed to personalize path');
    }
  }

  /**
   * Get current tutor session
   */
  getCurrentSession(): AITutorSession | null {
    return this.currentSession;
  }

  /**
   * Clear current session
   */
  clearSession(): void {
    this.currentSession = null;
  }
}

// Export singleton instance
export const aiService = AIService.getInstance();
export default aiService;