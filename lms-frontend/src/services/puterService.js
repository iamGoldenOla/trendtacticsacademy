// Puter.js integration for Trendtactics Academy
// This service enables conversational customer service using AI

import courseService from './courseService';

class PuterService {
  constructor() {
    this.isInitialized = false;
    this.aiModels = {}; // Support for multiple models
  }

  // Initialize Puter.js with multiple models
  async initialize() {
    try {
      // Check if puter.js is already loaded
      if (typeof window !== 'undefined' && typeof window.puter === 'undefined') {
        console.warn('Puter.js not found. Please include the script in your HTML.');
        return false;
      }

      // Initialize multiple AI models for different purposes
      // eslint-disable-next-line no-undef
      this.aiModels.fast = await puter.ai.create({
        model: 'gpt-5-nano',
        temperature: 0.7,
        max_tokens: 300
      });

      // eslint-disable-next-line no-undef
      this.aiModels.reasoning = await puter.ai.create({
        model: 'deepseek-reasoner',
        temperature: 0.5,
        max_tokens: 800
      });

      // eslint-disable-next-line no-undef
      this.aiModels.creative = await puter.ai.create({
        model: 'claude-sonnet-4',
        temperature: 0.8,
        max_tokens: 600
      });

      // eslint-disable-next-line no-undef
      this.aiModels.education = await puter.ai.create({
        model: 'gemini-2.0-flash',
        temperature: 0.6,
        max_tokens: 700
      });

      this.isInitialized = true;
      console.log('Puter.js initialized successfully with multiple models');
      return true;
    } catch (error) {
      console.error('Failed to initialize Puter.js:', error);
      return false;
    }
  }

  // Process conversation with context awareness using best model
  async processConversation(conversationHistory, currentMessage) {
    if (!this.isInitialized) {
      throw new Error('Puter.js not initialized. Call initialize() first.');
    }

    try {
      // Build conversation context
      const conversationContext = conversationHistory.map(msg => 
        `${msg.role === 'user' ? 'Customer' : 'Trendy'}: ${msg.content}`
      ).join('\n');

      const prompt = `
        You are Trendy, a friendly and helpful customer service assistant for Trendtactics Academy.
        Your job is to help customers learn about our courses and services.
        
        Previous conversation:
        ${conversationContext}
        
        Customer's latest message: ${currentMessage}
        
        Provide helpful responses about:
        - Our course offerings (Web Development, App Development, Digital Marketing)
        - Course details and content
        - Pricing information
        - How to enroll in courses
        - Technical support
        - Platform navigation
        
        Remember: You are a CUSTOMER SERVICE REPRESENTATIVE, not an instructor or course creator.
        Do NOT offer to create courses for customers.
        Do NOT act as an instructor.
        Direct customers to the appropriate pages on our website.
        
        Keep responses friendly, professional, and focused on helping customers.
        If you don't know something, direct them to our support team.
      `;

      // Use fast model for conversation to maintain responsiveness
      // eslint-disable-next-line no-undef
      const response = await this.aiModels.fast.complete(prompt);
      return response.choices[0].text.trim();
    } catch (error) {
      console.error('Failed to process conversation:', error);
      throw error;
    }
  }

  // Stream response for real-time interaction
  async streamResponse(prompt, modelType = 'fast') {
    if (!this.isInitialized) {
      throw new Error('Puter.js not initialized. Call initialize() first.');
    }

    try {
      const model = this.aiModels[modelType] || this.aiModels.fast;
      // eslint-disable-next-line no-undef
      return await model.complete(prompt, { stream: true });
    } catch (error) {
      console.error('Failed to stream response:', error);
      throw error;
    }
  }
}

// Export singleton instance
const puterService = new PuterService();
export default puterService;