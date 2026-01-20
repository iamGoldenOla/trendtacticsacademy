import React, { useState, useEffect, useRef } from "react";
import { aiService } from "../services/aiService";
import { useAuth } from "../hooks/useAuth";

const AITutorChat = ({
    courseId,
    lessonId,
    topic,
    isOpen,
    onClose,
}) => {
    const { user } = useAuth();
    const [session, setSession] = useState(null);
    const [messages, setMessages] = useState([]);
    const [inputMessage, setInputMessage] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [isTyping, setIsTyping] = useState(false);
    const [error, setError] = useState(null);
    const messagesEndRef = useRef(null);
    const inputRef = useRef(null);

    // Auto-scroll to bottom when new messages arrive
    const scrollToBottom = () => {
        messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
    };

    useEffect(() => {
        scrollToBottom();
    }, [messages]);

    // Focus input when chat opens
    useEffect(() => {
        if (isOpen && inputRef.current) {
            inputRef.current.focus();
        }
    }, [isOpen]);

    // Start AI session when component mounts or props change
    useEffect(() => {
        if (isOpen && !session) {
            startAISession();
        }
    }, [isOpen, courseId, lessonId, topic]);

    const startAISession = async () => {
        if (!user) return;
        setIsLoading(true);
        setError(null);
        try {
            const newSession = await aiService.startTutorSession({
                courseId,
                lessonId,
                topic,
                userLevel: 'beginner',
            });
            setSession(newSession);
            // Add welcome message
            const welcomeMessage = {
                id: 'welcome',
                role: 'assistant',
                content: 'Hello! I\'m TrendyAI, your personal tutor. How can I help you today?',
                timestamp: new Date(),
            };
            setMessages([welcomeMessage]);
        }
        catch (err) {
            setError(err.message || 'Failed to start AI session');
        }
        finally {
            setIsLoading(false);
        }
    };

    const sendMessage = async () => {
        if (!inputMessage.trim() || !session || isLoading) return;
        const userMessage = {
            id: `user-${Date.now()}`,
            role: 'user',
            content: inputMessage.trim(),
            timestamp: new Date(),
        };
        setMessages(prev => [...prev, userMessage]);
        setInputMessage('');
        setIsTyping(true);
        setError(null);
        try {
            const response = await aiService.sendMessage(session.id, userMessage.content, {
                courseId,
                lessonId,
                currentProgress: 0, // You can get this from course progress
            });
            const aiMessage = {
                id: `ai-${Date.now()}`,
                role: 'assistant',
                content: response.content,
                timestamp: new Date(),
            };
            setMessages(prev => [...prev, aiMessage]);
        }
        catch (err) {
            setError(err.message || 'Failed to send message');
            // Add error message to chat
            const errorMessage = {
                id: `error-${Date.now()}`,
                role: 'assistant',
                content: 'I\'m sorry, I\'m having trouble responding right now. Please try again.',
                timestamp: new Date(),
            };
            setMessages(prev => [...prev, errorMessage]);
        }
        finally {
            setIsTyping(false);
        }
    };

    const handleKeyDown = (e) => {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    };

    const clearChat = () => {
        setMessages([]);
        setSession(null);
        setError(null);
        aiService.clearSession();
        startAISession();
    };

    const formatTime = (date) => {
        return new Intl.DateTimeFormat('en-US', {
            hour: '2-digit',
            minute: '2-digit',
        }).format(date);
    };

    if (!isOpen) return null;

    return (
        <div className="flex flex-col h-[600px] w-full bg-white rounded-lg shadow-sm border border-gray-200">
            {/* Header */}
            <div className="flex items-center justify-between p-4 border-b border-gray-100 bg-gray-50 rounded-t-lg">
                <div className="flex items-center space-x-3">
                    <div className="w-10 h-10 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center shadow-sm">
                        <svg className="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
                        </svg>
                    </div>
                    <div>
                        <h3 className="text-lg font-semibold text-gray-900">TrendyAI Tutor</h3>
                        <p className="text-xs text-gray-500 font-medium">
                            {topic ? `Helping with ${topic}` : 'Your personal learning assistant'}
                        </p>
                    </div>
                </div>
                <div className="flex items-center space-x-1">
                    <button
                        onClick={() => {
                            console.log('Clearing chat...');
                            clearChat();
                        }}
                        className="p-2 text-gray-400 hover:text-blue-600 hover:bg-blue-50 rounded-full transition-all"
                        title="Clear chat"
                    >
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                        </svg>
                    </button>
                    <button
                        onClick={(e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            console.log('Close button clicked', onClose);
                            if (onClose && typeof onClose === 'function') {
                                onClose();
                            } else {
                                // Fallback: if no onClose handler, navigate back
                                if (window.history.length > 1) {
                                    window.history.back();
                                } else {
                                    window.location.href = '/dashboard';
                                }
                            }
                        }}
                        className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-full transition-all"
                        title="Close chat"
                        type="button"
                    >
                        <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
            </div>

            {/* Messages */}
            <div className="flex-1 overflow-y-auto p-4 space-y-4 bg-white custom-scrollbar">
                {isLoading && messages.length === 0 ? (
                    <div className="flex items-center justify-center h-full">
                        <div className="text-center">
                            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500 mx-auto mb-3"></div>
                            <p className="text-gray-500 text-sm font-medium">Starting AI session...</p>
                        </div>
                    </div>
                ) : (
                    <>
                        {messages.map((message) => (
                            <div key={message.id} className={`flex ${message.role === 'user' ? 'justify-end' : 'justify-start'}`}>
                                <div className={`max-w-xs lg:max-w-md px-4 py-3 rounded-2xl shadow-sm ${message.role === 'user'
                                    ? 'bg-blue-600 text-white rounded-tr-none'
                                    : 'bg-gray-100 text-gray-800 rounded-tl-none'}`}>
                                    <p className="text-sm leading-relaxed">{message.content}</p>
                                    <p className={`text-[10px] mt-2 font-medium opacity-70 ${message.role === 'user' ? 'text-right' : 'text-left'}`}>
                                        {formatTime(message.timestamp)}
                                    </p>
                                </div>
                            </div>
                        ))}
                        {isTyping && (
                            <div className="flex justify-start">
                                <div className="bg-gray-100 text-gray-800 px-4 py-3 rounded-2xl rounded-tl-none shadow-sm">
                                    <div className="flex space-x-1">
                                        <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div>
                                        <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '0.1s' }}></div>
                                        <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '0.2s' }}></div>
                                    </div>
                                </div>
                            </div>
                        )}
                    </>
                )}

                {error && (
                    <div className="bg-red-50 border border-red-100 rounded-xl p-4 animate-fade-in">
                        <div className="flex items-center space-x-2">
                            <svg className="w-4 h-4 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
                            </svg>
                            <p className="text-red-700 text-xs font-semibold">{error}</p>
                        </div>
                    </div>
                )}

                <div ref={messagesEndRef} />
            </div>

            {/* Input */}
            <div className="border-t border-gray-100 p-4 bg-white rounded-b-lg">
                <div className="flex space-x-2">
                    <input
                        ref={inputRef}
                        type="text"
                        value={inputMessage}
                        onChange={(e) => setInputMessage(e.target.value)}
                        onKeyDown={handleKeyDown}
                        placeholder="Ask TrendyAI about this lesson..."
                        className="flex-1 bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-white transition-all shadow-inner"
                        disabled={isLoading || isTyping}
                    />
                    <button
                        type="button"
                        onClick={(e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            console.log('Send button clicked');
                            sendMessage();
                        }}
                        disabled={!inputMessage.trim() || isLoading || isTyping}
                        className="bg-blue-600 text-white p-3 rounded-xl hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-40 disabled:cursor-not-allowed transition-all shadow-md active:scale-95"
                        aria-label="Send message"
                    >
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                        </svg>
                    </button>
                </div>
                <p className="text-[10px] text-gray-400 mt-2 text-center font-medium">
                    Auto-save enabled • AI response time: ~1.2s
                </p>
            </div>
        </div>
    );
};

export default AITutorChat;