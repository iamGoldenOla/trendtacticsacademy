import React, { useState } from 'react';

// Mock course data - in reality, this would come from your Supabase database
const mockCourses = {
  "web-development": {
    id: "web-development",
    title: "Web Development Masterclass",
    description: "Complete guide to modern web development",
    modules: [
      { id: 1, title: "HTML & CSS Fundamentals", duration: "2 weeks" },
      { id: 2, title: "JavaScript Essentials", duration: "3 weeks" },
      { id: 3, title: "React Framework", duration: "4 weeks" },
      { id: 4, title: "Full-Stack Development", duration: "3 weeks" }
    ],
    price: 299,
    rating: 4.8
  },
  "app-development": {
    id: "app-development",
    title: "App Development Bootcamp",
    description: "Build iOS and Android apps with React Native",
    modules: [
      { id: 1, title: "Mobile UI/UX Design", duration: "2 weeks" },
      { id: 2, title: "React Native Basics", duration: "3 weeks" },
      { id: 3, title: "Navigation & State", duration: "2 weeks" },
      { id: 4, title: "Publishing to Stores", duration: "1 week" }
    ],
    price: 349,
    rating: 4.9
  },
  "digital-marketing": {
    id: "digital-marketing",
    title: "Digital Marketing Pro",
    description: "Master content creation, social media, and advertising",
    modules: [
      { id: 1, title: "Content Strategy", duration: "2 weeks" },
      { id: 2, title: "Social Media Marketing", duration: "3 weeks" },
      { id: 3, title: "Email Campaigns", duration: "2 weeks" },
      { id: 4, title: "Facebook Ads Mastery", duration: "3 weeks" }
    ],
    price: 249,
    rating: 4.7
  }
};

// Mock user progress data
const mockUserProgress = {
  "user-123": {
    "web-development": {
      completedModules: [1, 2],
      currentModule: 3,
      overallProgress: 50,
      lastActive: "2025-12-10"
    }
  }
};

const FunctionCallingDemo = () => {
  const [messages, setMessages] = useState([
    {
      id: 1,
      text: "Welcome to the Function Calling Demo! I can access real course data and user progress.",
      sender: 'bot',
      timestamp: new Date()
    }
  ]);
  const [inputValue, setInputValue] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const addBotMessage = (text) => {
    const botMessage = {
      id: Date.now(),
      text: text,
      sender: 'bot',
      timestamp: new Date()
    };
    setMessages(prev => [...prev, botMessage]);
  };

  const addUserMessage = (text) => {
    const userMessage = {
      id: Date.now(),
      text: text,
      sender: 'user',
      timestamp: new Date()
    };
    setMessages(prev => [...prev, userMessage]);
  };

  // Mock function implementations that would connect to real systems
  const getCourseInfo = (params) => {
    const course = mockCourses[params.course_name.toLowerCase().replace(/\s+/g, '-')];
    if (!course) {
      return "Course not found. Available courses: Web Development, App Development, Digital Marketing";
    }
    
    return `Course: ${course.title}
Description: ${course.description}
Modules: ${course.modules.map(m => `\n- ${m.title} (${m.duration})`).join('')}
Price: $${course.price}
Rating: ${course.rating}/5.0`;
  };

  const getUserProgress = (params) => {
    const progress = mockUserProgress[params.user_id]?.[params.course_id];
    if (!progress) {
      return "No progress data found for this user and course.";
    }
    
    return `Your progress in this course:
Overall Completion: ${progress.overallProgress}%
Completed Modules: ${progress.completedModules.length} of ${mockCourses[params.course_id]?.modules.length || 'unknown'}
Current Module: ${mockCourses[params.course_id]?.modules.find(m => m.id === progress.currentModule)?.title || 'Unknown'}`;
  };

  const recommendNextLesson = (params) => {
    const progress = mockUserProgress[params.user_id]?.[params.course_id];
    if (!progress) {
      return "I don't have your progress data. Please enroll in a course first.";
    }
    
    const course = mockCourses[params.course_id];
    if (!course) {
      return "Course not found.";
    }
    
    const nextModule = course.modules.find(m => m.id === progress.currentModule);
    if (!nextModule) {
      return "You've completed all modules! Congratulations!";
    }
    
    return `Based on your progress, I recommend:
Next Module: ${nextModule.title}
Estimated Duration: ${nextModule.duration}
Focus Areas: This module builds on your previous knowledge of ${course.modules.find(m => m.id === progress.completedModules[progress.completedModules.length - 1])?.title || 'previous modules'}.`;
  };

  // Define the tools available to the AI (this would be passed to puter.js)
  const tools = [{
    type: "function",
    function: {
      name: "get_course_info",
      description: "Get detailed information about a specific course",
      parameters: {
        type: "object",
        properties: {
          course_name: {
            type: "string",
            description: "Name of the course e.g. Web Development, App Development, Digital Marketing"
          }
        },
        required: ["course_name"]
      }
    }
  }, {
    type: "function",
    function: {
      name: "get_user_progress",
      description: "Get user's progress in a specific course",
      parameters: {
        type: "object",
        properties: {
          user_id: { type: "string", description: "User identifier" },
          course_id: { type: "string", description: "Course identifier" }
        },
        required: ["user_id", "course_id"]
      }
    }
  }, {
    type: "function",
    function: {
      name: "recommend_next_lesson",
      description: "Recommend the next lesson based on user progress",
      parameters: {
        type: "object",
        properties: {
          user_id: { type: "string", description: "User identifier" },
          course_id: { type: "string", description: "Course identifier" }
        },
        required: ["user_id", "course_id"]
      }
    }
  }];

  // Simulate AI processing with function calling
  const processWithFunctions = async (userInput) => {
    setIsLoading(true);
    addUserMessage(userInput);
    setInputValue('');
    
    try {
      // In a real implementation, this would use puter.js function calling
      // For demo purposes, we'll simulate the logic
      
      let response = "";
      
      // Simple keyword-based function detection (real implementation would use AI)
      if (userInput.toLowerCase().includes('course') && (userInput.toLowerCase().includes('web') || userInput.toLowerCase().includes('app') || userInput.toLowerCase().includes('digital'))) {
        const courseMatch = userInput.toLowerCase().match(/(web development|app development|digital marketing)/);
        if (courseMatch) {
          response = getCourseInfo({ course_name: courseMatch[1] });
        } else {
          response = "Which course would you like to know about? We offer Web Development, App Development, and Digital Marketing.";
        }
      } else if (userInput.toLowerCase().includes('progress') || userInput.toLowerCase().includes('how am i doing')) {
        response = getUserProgress({ user_id: "user-123", course_id: "web-development" });
      } else if (userInput.toLowerCase().includes('next') || userInput.toLowerCase().includes('recommend')) {
        response = recommendNextLesson({ user_id: "user-123", course_id: "web-development" });
      } else {
        // General response
        const generalResponses = [
          "I can help you with course information, your progress updates, and learning recommendations. What would you like to know?",
          "Ask me about specific courses, your learning progress, or what to study next!",
          "I have access to real course data and your progress. Try asking about Web Development, your current progress, or recommendations!"
        ];
        response = generalResponses[Math.floor(Math.random() * generalResponses.length)];
      }
      
      setTimeout(() => {
        addBotMessage(response);
        setIsLoading(false);
      }, 800);
    } catch (error) {
      setTimeout(() => {
        addBotMessage("Sorry, I encountered an error: " + error.message);
        setIsLoading(false);
      }, 800);
    }
  };

  const handleSend = () => {
    if (!inputValue.trim()) return;
    processWithFunctions(inputValue);
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  };

  // Demo scenarios
  const demoScenarios = [
    { 
      title: "Course Information", 
      prompt: "Tell me about the Web Development course",
      description: "Access detailed course catalogs"
    },
    { 
      title: "Progress Tracking", 
      prompt: "How am I doing in my course?",
      description: "Retrieve personalized progress data"
    },
    { 
      title: "Learning Recommendations", 
      prompt: "What should I learn next?",
      description: "Get adaptive learning suggestions"
    }
  ];

  const runDemoScenario = (scenario) => {
    processWithFunctions(scenario.prompt);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-6xl mx-auto">
        <div className="text-center mb-12">
          <h1 className="text-4xl font-bold text-gray-900 mb-4">Function Calling Demo</h1>
          <p className="text-xl text-gray-600">
            Connecting AI to Real Systems with puter.js
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Main Chat Interface */}
          <div className="lg:col-span-2 bg-white rounded-2xl shadow-xl p-6">
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-2xl font-bold text-gray-900">AI Assistant with System Access</h2>
              <div className="px-3 py-1 bg-green-100 text-green-800 rounded-full text-sm font-medium">
                Live Connection
              </div>
            </div>

            {/* Messages Area */}
            <div className="h-96 overflow-y-auto mb-6 p-4 bg-gray-50 rounded-xl">
              {messages.map((message) => (
                <div
                  key={message.id}
                  className={`mb-4 p-4 rounded-lg ${
                    message.sender === 'user'
                      ? 'bg-blue-100 border border-blue-200 ml-8'
                      : 'bg-gray-100 border border-gray-200 mr-8'
                  }`}
                >
                  <div className="flex justify-between items-start">
                    <div>
                      <span className={`font-medium ${
                        message.sender === 'user' ? 'text-blue-700' : 'text-gray-700'
                      }`}>
                        {message.sender === 'user' ? 'You' : 'Trendy AI'}
                      </span>
                      <p className="mt-2 text-gray-800 whitespace-pre-wrap">{message.text}</p>
                    </div>
                    <span className="text-xs text-gray-500 ml-2">
                      {message.timestamp.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                    </span>
                  </div>
                </div>
              ))}
              
              {isLoading && (
                <div className="mb-4 p-4 rounded-lg bg-gray-100 border border-gray-200">
                  <div className="flex space-x-2">
                    <div className="w-3 h-3 bg-gray-400 rounded-full animate-bounce"></div>
                    <div className="w-3 h-3 bg-gray-400 rounded-full animate-bounce delay-75"></div>
                    <div className="w-3 h-3 bg-gray-400 rounded-full animate-bounce delay-150"></div>
                  </div>
                </div>
              )}
            </div>

            {/* Input Area */}
            <div className="flex space-x-2">
              <textarea
                value={inputValue}
                onChange={(e) => setInputValue(e.target.value)}
                onKeyPress={handleKeyPress}
                placeholder="Ask about courses, your progress, or recommendations..."
                className="flex-1 border border-gray-300 rounded-lg px-4 py-3 text-sm resize-none focus:outline-none focus:ring-2 focus:ring-brand-cyan focus:border-transparent"
                rows="2"
                disabled={isLoading}
              />
              <button
                onClick={handleSend}
                disabled={isLoading || !inputValue.trim()}
                className="bg-brand-cyan text-white rounded-lg px-6 py-3 hover:bg-brand-navy transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Send
              </button>
            </div>
          </div>

          {/* Function Capabilities Panel */}
          <div className="space-y-6">
            {/* Available Functions */}
            <div className="bg-white rounded-2xl shadow-xl p-6">
              <h3 className="text-xl font-bold text-gray-900 mb-4">System Integration</h3>
              <div className="space-y-4">
                <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
                  <div className="font-semibold text-blue-800">📚 Course Database</div>
                  <div className="text-sm text-blue-600 mt-1">Access real course information and curricula</div>
                </div>
                
                <div className="p-4 bg-green-50 rounded-lg border border-green-200">
                  <div className="font-semibold text-green-800">👤 User Profiles</div>
                  <div className="text-sm text-green-600 mt-1">Retrieve personalized user data</div>
                </div>
                
                <div className="p-4 bg-purple-50 rounded-lg border border-purple-200">
                  <div className="font-semibold text-purple-800">📈 Learning Analytics</div>
                  <div className="text-sm text-purple-600 mt-1">Access progress tracking and insights</div>
                </div>
                
                <div className="p-4 bg-orange-50 rounded-lg border border-orange-200">
                  <div className="font-semibold text-orange-800">🎯 Recommendation Engine</div>
                  <div className="text-sm text-orange-600 mt-1">Get personalized learning suggestions</div>
                </div>
              </div>
            </div>

            {/* Demo Scenarios */}
            <div className="bg-white rounded-2xl shadow-xl p-6">
              <h3 className="text-xl font-bold text-gray-900 mb-4">Try These Examples</h3>
              <div className="space-y-3">
                {demoScenarios.map((scenario, index) => (
                  <button
                    key={index}
                    onClick={() => runDemoScenario(scenario)}
                    disabled={isLoading}
                    className="w-full text-left p-3 bg-gray-50 rounded-lg border border-gray-200 hover:bg-gray-100 transition-colors disabled:opacity-50"
                  >
                    <div className="font-medium text-gray-900">{scenario.title}</div>
                    <div className="text-sm text-gray-600">{scenario.description}</div>
                    <div className="text-xs text-gray-500 mt-1 italic">"{scenario.prompt}"</div>
                  </button>
                ))}
              </div>
            </div>

            {/* Implementation Code */}
            <div className="bg-gray-800 rounded-2xl shadow-xl p-6 text-gray-100">
              <h3 className="text-xl font-bold text-white mb-4">Implementation</h3>
              <pre className="text-xs bg-gray-900 p-4 rounded-lg overflow-x-auto">
                {`// Define tools for AI
const tools = [{
  type: "function",
  function: {
    name: "get_course_info",
    description: "Get course details",
    parameters: {
      type: "object",
      properties: {
        course_name: { type: "string" }
      },
      required: ["course_name"]
    }
  }
}];

// AI processes with function calling
const completion = await puter.ai.chat(
  userInput, { tools }
);

// Execute system functions
if (completion.tool_calls) {
  // Call your system functions
  // Return results to AI for final response
}`}
              </pre>
            </div>
          </div>
        </div>

        {/* How It Works Explanation */}
        <div className="mt-12 bg-white rounded-2xl shadow-xl p-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">How Function Calling Works</h2>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="text-center">
              <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl font-bold text-blue-600">1</span>
              </div>
              <h3 className="text-lg font-semibold text-gray-900 mb-2">Define Tools</h3>
              <p className="text-gray-600">Specify system functions the AI can call, with parameters and descriptions.</p>
            </div>
            
            <div className="text-center">
              <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl font-bold text-green-600">2</span>
              </div>
              <h3 className="text-lg font-semibold text-gray-900 mb-2">AI Requests Data</h3>
              <p className="text-gray-600">When needed, AI requests specific data by calling defined functions.</p>
            </div>
            
            <div className="text-center">
              <div className="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl font-bold text-purple-600">3</span>
              </div>
              <h3 className="text-lg font-semibold text-gray-900 mb-2">Return Results</h3>
              <p className="text-gray-600">System executes functions and returns data for AI to create final response.</p>
            </div>
          </div>
          
          <div className="mt-8 p-6 bg-yellow-50 rounded-xl border border-yellow-200">
            <h3 className="text-lg font-semibold text-yellow-800 mb-2">Benefits for Trendtactics Academy</h3>
            <ul className="list-disc pl-5 space-y-2 text-yellow-700">
              <li>Real-time access to course information and user data</li>
              <li>Personalized learning recommendations based on actual progress</li>
              <li>Dynamic content delivery tailored to individual needs</li>
              <li>Automated administrative tasks through AI</li>
              <li>Seamless integration between AI assistant and learning platform</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};

export default FunctionCallingDemo;