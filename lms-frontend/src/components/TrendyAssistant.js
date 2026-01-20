import React, { useState, useRef, useEffect } from 'react';
import { aiService } from '../services/aiService';

const TrendyAssistant = () => {
  const [messages, setMessages] = useState([
    {
      id: 1,
      text: "Hi! I'm Trendy, your friendly customer service assistant. How can I help you today?",
      sender: 'bot',
      timestamp: new Date()
    }
  ]);
  const [inputValue, setInputValue] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [isPuterInitialized, setIsPuterInitialized] = useState(false);
  const [isVisible, setIsVisible] = useState(false); // Hidden by default - only show when clicked
  const [conversationHistory, setConversationHistory] = useState([]); // Track conversation context
  const messagesEndRef = useRef(null);

  const courses = [
    "Web Development",
    "App Development",
    "Digital Marketing (Content Creation, Email Marketing, Social Media, and Facebook Ads)"
  ];

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  // Initialize AI Service
  useEffect(() => {
    // aiService is stateless for initialization, but we can set a flag
    setIsPuterInitialized(true);
    addBotMessage("I'm powered by TrendyAI! Ask me anything about the courses.");
  }, []);

  const addBotMessage = (text) => {
    const botMessage = {
      id: Date.now(),
      text: text,
      sender: 'bot',
      timestamp: new Date()
    };
    setMessages(prev => [...prev, botMessage]);
    setConversationHistory(prev => [...prev, { role: 'assistant', content: text }]);
  };

  const addErrorMessage = (text) => {
    const errorMessage = {
      id: Date.now(),
      text: text,
      sender: 'error',
      timestamp: new Date()
    };
    setMessages(prev => [...prev, errorMessage]);
  };

  const handleSend = async () => {
    if (!inputValue.trim()) return;

    // Add user message
    const userMessage = {
      id: Date.now(),
      text: inputValue,
      sender: 'user',
      timestamp: new Date()
    };

    setMessages(prev => [...prev, userMessage]);
    setConversationHistory(prev => [...prev, { role: 'user', content: inputValue }]);
    const userInput = inputValue;
    setInputValue('');
    setIsLoading(true);

    try {
      // Use aiService (Edge Function)
      // Create a temporary session ID or reuse one
      const sessionId = 'trendy-assistant-' + Date.now();

      const response = await aiService.sendMessage(sessionId, userInput, {
        courseId: 'General',
        lessonId: 'General',
        history: conversationHistory
      });

      const botMessage = {
        id: Date.now() + 1,
        text: response.content,
        sender: 'bot',
        timestamp: new Date()
      };

      setMessages(prev => [...prev, botMessage]);
      setConversationHistory(prev => [...prev, { role: 'assistant', content: response.content }]);

    } catch (error) {
      console.error('AI processing error:', error);
      // Fallback to local logic if AI fails
      fallbackResponse(userInput);
    } finally {
      setIsLoading(false);
    }
  };

  const fallbackResponse = (text) => {
    const lowerInput = text.toLowerCase();
    let botResponse = "I'm having trouble connecting to the AI, but I can still help!";

    if (lowerInput.includes('hello') || lowerInput.includes('hi')) {
      botResponse = "Hello! How can I help you today?";
    } else if (lowerInput.includes('course')) {
      const courseList = courses.map((c, i) => `${i + 1}. ${c}`).join('\n');
      botResponse = `We offer:\n${courseList}\nCheck the Courses page for more!`;
    }
    addErrorMessage(botResponse);
  };

  const handleKeyDown = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  };

  // Toggle visibility of the chatbot
  const toggleVisibility = () => {
    setIsVisible(!isVisible);
  };

  // Clear conversation
  const clearConversation = () => {
    setMessages([
      {
        id: Date.now(),
        text: "Hi again! I'm Trendy, your customer service assistant. How can I help you today?",
        sender: 'bot',
        timestamp: new Date()
      }
    ]);
    setConversationHistory([]);
  };

  if (!isVisible) {
    return (
      <div className="fixed bottom-6 right-6 z-50">
        <button
          onClick={toggleVisibility}
          className="bg-brand-cyan text-white rounded-full p-3 shadow-lg hover:bg-brand-navy transition-colors"
          aria-label="Open Trendy Assistant"
        >
          <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z" />
          </svg>
        </button>
      </div>
    );
  }

  return (
    <div className="fixed bottom-6 right-6 z-50">
      {/* Chat Container */}
      <div className="bg-white rounded-xl shadow-2xl border border-gray-200 w-80 h-96 flex flex-col">
        {/* Chat Header */}
        <div className="bg-brand-cyan text-white p-4 rounded-t-xl flex items-center justify-between">
          <div className="flex items-center space-x-2">
            <div className="w-8 h-8 bg-white rounded-full flex items-center justify-center">
              <span className="text-brand-cyan font-bold text-lg">T</span>
            </div>
            <div>
              <h3 className="font-semibold">Trendy Assistant</h3>
              <p className="text-xs text-cyan-100">Customer Service {isPuterInitialized ? '✨ AI-Powered' : ''}</p>
            </div>
          </div>
          <div className="flex space-x-2">
            <button
              onClick={clearConversation}
              className="text-cyan-100 hover:text-white transition-colors"
              aria-label="Clear conversation"
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
              </svg>
            </button>
            <button
              onClick={toggleVisibility}
              className="text-cyan-100 hover:text-white transition-colors"
              aria-label="Minimize chat"
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 12H4" />
              </svg>
            </button>
          </div>
        </div>

        {/* Messages Area */}
        <div className="flex-1 p-4 overflow-y-auto bg-gray-50">
          {messages.map((message) => (
            <div
              key={message.id}
              className={`mb-3 flex ${message.sender === 'user' ? 'justify-end' : 'justify-start'}`}
            >
              <div
                className={`max-w-xs lg:max-w-md px-4 py-2 rounded-lg ${message.sender === 'user'
                  ? 'bg-brand-cyan text-white rounded-br-none'
                  : message.sender === 'error'
                    ? 'bg-red-100 text-red-800 border border-red-200 rounded-bl-none'
                    : 'bg-white text-gray-800 border border-gray-200 rounded-bl-none'
                  }`}
              >
                <p className="text-sm whitespace-pre-wrap">{message.text}</p>
                <p className={`text-xs mt-1 ${message.sender === 'user' ? 'text-cyan-100' : message.sender === 'error' ? 'text-red-600' : 'text-gray-500'}`}>
                  {message.timestamp.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                </p>
              </div>
            </div>
          ))}

          {isLoading && (
            <div className="flex justify-start mb-3">
              <div className="bg-white text-gray-800 border border-gray-200 rounded-lg rounded-bl-none px-4 py-2">
                <div className="flex space-x-1">
                  <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div>
                  <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce delay-75"></div>
                  <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce delay-150"></div>
                </div>
              </div>
            </div>
          )}

          <div ref={messagesEndRef} />
        </div>

        {/* Input Area */}
        <div className="p-4 border-t border-gray-200">
          <div className="flex space-x-2">
            <textarea
              value={inputValue}
              onChange={(e) => setInputValue(e.target.value)}
              onKeyDown={handleKeyDown}
              placeholder="Ask me about our courses or services..."
              className="flex-1 border border-gray-300 rounded-lg px-3 py-2 text-sm resize-none focus:outline-none focus:ring-2 focus:ring-brand-cyan focus:border-transparent"
              rows="2"
            />
            <button
              onClick={handleSend}
              disabled={isLoading || !inputValue.trim()}
              className="bg-brand-cyan text-white rounded-lg px-4 py-2 hover:bg-brand-navy transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path d="M10.894 2.553a1 1 0 00-1.788 0l-7 14a1 1 0 001.169 1.409l5-1.429A1 1 0 009 15.571V11a1 1 0 112 0v4.571a1 1 0 00.725.962l5 1.428a1 1 0 001.17-1.408l-7-14z" />
              </svg>
            </button>
          </div>
          <p className="text-xs text-gray-500 mt-2 text-center">
            Customer Service Assistant
          </p>
        </div>
      </div>
    </div>
  );
};

export default TrendyAssistant;