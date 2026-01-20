
/**
 * AI Service for TrendyAI Integration
 * Handles all AI-powered features including tutoring, recommendations, and analytics
 * Now uses Supabase Edge Functions for secure, keyless AI interaction
 */
class AIService {
    constructor() {
        this.currentSession = null;
        this.supabaseUrl = "https://uimdbodamoeyukrghchb.supabase.co";
        this.supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc";
    }

    static getInstance() {
        if (!AIService.instance) {
            AIService.instance = new AIService();
        }
        return AIService.instance;
    }

    async ensureInitialized() {
        // No initialization needed for REST calls
        return true;
    }

    /**
     * Start a new AI tutor session
     */
    async startTutorSession(context) {
        this.currentSession = {
            id: `session-${Date.now()}`,
            startTime: new Date(),
            context
        };
        return this.currentSession;
    }

    /**
     * Send a message to the AI tutor via Supabase Edge Function
     */
    async sendMessage(sessionId, message, context) {
        try {
            // Build conversation context
            const history = context?.history || [];

            // Construct the prompt with context
            const systemPrompt = `You are an expert tutor for Trendtactics Academy. 
            Currently helping with course: ${context?.courseId || 'General Marketing'}.
            Topic: ${context?.lessonId || 'General'}.
            User Level: ${context?.userLevel || 'Beginner'}.
            Keep responses helpful, encouraging, and focused on the course material.`;

            // Prepare the payload for the Edge Function
            const payload = {
                prompt: `${systemPrompt}\n\nUser Question: ${message}`,
                model: 'gpt-4o-mini' // Efficient and fast model
            };

            // Call the Edge Function
            const response = await fetch(`${this.supabaseUrl}/functions/v1/supabase-edge-function-ai-playground`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${this.supabaseKey}`
                },
                body: JSON.stringify(payload)
            });

            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.error || 'Failed to get AI response');
            }

            const data = await response.json();

            // The Edge Function returns { code: "..." } or similar structure
            // We want just the text content. The function wraps output in markdown code blocks usually,
            // but let's check. If it's just text, we use it.
            let aiText = data.code || data.message || data.text;

            // Clean up if it's wrapped in generic code blocks from the playground function
            if (aiText && aiText.startsWith('```') && aiText.endsWith('```')) {
                aiText = aiText.replace(/^```\w*\n/, '').replace(/```$/, '');
            }

            return {
                content: aiText || "I'm having trouble connecting to my brain right now. Please try again.",
                timestamp: new Date()
            };
        }
        catch (error) {
            console.error('Send AI message error:', error);
            throw new Error('AI is temporarily unavailable. Please try again.');
        }
    }

    /**
     * Get AI-powered learning recommendations
     */
    async getRecommendations(context) {
        // Mock for now, can be upgraded to real AI later
        return [
            { id: 1, title: 'Mastering Facebook Ads', reason: 'Based on your interest in social media' },
            { id: 2, title: 'SEO for Beginners', reason: 'Highly relevant to your current track' }
        ];
    }

    /**
     * Get AI analytics for user learning patterns
     */
    async getAnalytics(userId) {
        // Return structured mock data
        return {
            totalSessions: 12,
            averageSessionDuration: 15,
            learningProgress: {
                completedLessons: 5,
                totalLessons: 20,
                averageScore: 85
            },
            engagementMetrics: {
                questionsAsked: 42,
                resourcesShared: 8
            },
            topTopics: ['Facebook Ads', 'Email Marketing', 'Copywriting']
        };
    }

    /**
     * Simplified progress analysis
     */
    async analyzeProgress(context) {
        return {
            summary: "You are doing great! Focus more on SEO modules next week.",
            nextSteps: ["Complete Chapter 3", "Take the SEO Quiz"]
        };
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

