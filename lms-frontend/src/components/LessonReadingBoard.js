import React, { useState, useEffect } from 'react';

const LessonReadingBoard = ({ lesson, course, onComplete, user, onTabChange }) => {
  const [content, setContent] = useState('');
  const [isCompleted, setIsCompleted] = useState(false);
  const [timeSpent, setTimeSpent] = useState(0);
  const [quizAnswers, setQuizAnswers] = useState({});
  const [showQuiz, setShowQuiz] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Reset state when lesson changes
    setIsCompleted(lesson?.isCompleted || false);
    setTimeSpent(0);
    setShowQuiz(false);
    setQuizAnswers({});
    setLoading(true);
    
    // In a real implementation, this would fetch the lesson content from the backend
    // For now, we'll simulate with sample content based on lesson title
    if (lesson) {
      generateSampleContent(lesson);
      
      // Start tracking time spent on lesson
      const timer = setInterval(() => {
        setTimeSpent(prev => prev + 1);
      }, 1000);
      
      return () => clearInterval(timer);
    }
  }, [lesson]);

  const generateSampleContent = (lesson) => {
    // This is a simplified content generator
    // In a real app, this would come from the database
    let sampleContent = `
      <div class="lesson-content">
        <h1 class="text-3xl font-bold text-gray-900 mb-6">${lesson.title}</h1>
        
        <div class="prose max-w-none">
          <p class="text-gray-700 mb-4 text-lg">
            Welcome to this lesson on <strong>${lesson.title}</strong>. In this section, we'll explore the fundamental concepts and practical applications.
          </p>
          
          <div class="bg-blue-50 border-l-4 border-blue-500 p-4 mb-6 rounded-r">
            <p class="text-blue-700">
              <strong>💡 Key Insight:</strong> Understanding these concepts is crucial for mastering this topic.
            </p>
          </div>
          
          <h2 class="text-2xl font-semibold text-gray-900 mt-8 mb-4">Core Concepts</h2>
          
          <p class="text-gray-700 mb-4">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
          </p>
          
          <div class="my-6">
            <img src="https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?w=800&h=400&fit=crop" alt="Learning illustration" class="rounded-lg shadow-md w-full">
            <p class="text-center text-sm text-gray-500 mt-2">Visual representation of key concepts</p>
          </div>
          
          <h3 class="text-xl font-semibold text-gray-900 mt-6 mb-3">Practical Example</h3>
          
          <div class="bg-gray-800 text-gray-100 p-4 rounded-lg mb-6">
            <div class="flex justify-between items-center mb-2">
              <span class="text-sm font-medium">example.js</span>
              <button class="text-xs bg-gray-700 hover:bg-gray-600 px-2 py-1 rounded">Copy</button>
            </div>
            <pre class="whitespace-pre-wrap text-sm">
// Sample code example
function exampleFunction() {
  console.log("This is a sample code block");
  return true;
}

// Call the function
const result = exampleFunction();
console.log("Result:", result);
            </pre>
          </div>
          
          <p class="text-gray-700 mb-4">
            Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
          </p>
          
          <div class="aspect-w-16 aspect-h-9 my-6">
            <iframe 
              src="https://www.youtube.com/embed/dQw4w9WgXcQ" 
              title="Lesson Video" 
              frameborder="0" 
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
              allowfullscreen
              class="w-full h-64 md:h-96 rounded-lg shadow-md"
            ></iframe>
            <p class="text-center text-sm text-gray-500 mt-2">Demonstration video</p>
          </div>
          
          <h3 class="text-xl font-semibold text-gray-900 mt-6 mb-3">Key Takeaways</h3>
          
          <ul class="list-disc pl-5 space-y-2 text-gray-700 mb-6 bg-gray-50 p-4 rounded-lg">
            <li>Key concept 1 explained in detail with practical application</li>
            <li>Key concept 2 showing real-world usage scenarios</li>
            <li>Key concept 3 with step-by-step implementation guide</li>
          </ul>
          
          <div class="bg-yellow-50 border-l-4 border-yellow-500 p-4 mb-6 rounded-r">
            <p class="text-yellow-700">
              <strong>⚠️ Important:</strong> Make sure to practice these concepts in the playground before moving to the next lesson.
            </p>
          </div>
        </div>
      </div>
    `;
    
    setContent(sampleContent);
    setLoading(false);
  };

  const handleMarkAsComplete = async () => {
    setIsCompleted(true);
    
    // In a real implementation, this would save to the backend
    if (onComplete) {
      onComplete(lesson.id, {
        timeSpent,
        completedAt: new Date().toISOString()
      });
    }
    
    // Show completion message
    alert(`🎉 Congratulations! You've completed "${lesson.title}"
    
⏱️ Time spent: ${Math.floor(timeSpent / 60)} minutes and ${timeSpent % 60} seconds`);
  };

  const handleQuizAnswer = (questionId, answer) => {
    setQuizAnswers({
      ...quizAnswers,
      [questionId]: answer
    });
  };

  const submitQuiz = () => {
    // In a real implementation, this would validate answers and save results
    const score = Object.keys(quizAnswers).length; // Simplified scoring
    alert(`Quiz submitted! Score: ${score}/3
Answers have been recorded.`);
    setShowQuiz(false);
  };

  const handlePracticeClick = () => {
    if (onTabChange) {
      onTabChange('playground');
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full bg-white">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand-cyan mx-auto mb-4"></div>
          <p className="text-gray-600">Loading lesson content...</p>
        </div>
      </div>
    );
  }

  if (!lesson) {
    return (
      <div className="flex items-center justify-center h-full bg-white">
        <div className="text-center">
          <div className="text-4xl mb-4">📚</div>
          <h3 className="text-xl font-medium text-gray-900 mb-2">Select a Lesson</h3>
          <p className="text-gray-600">Choose a lesson from the sidebar to begin learning</p>
        </div>
      </div>
    );
  }

  return (
    <div className="h-full flex flex-col bg-white">
      <div className="flex items-center justify-between p-4 border-b border-gray-200 bg-white sticky top-0 z-10 shadow-sm">
        <div>
          <h1 className="text-xl font-semibold text-gray-900 truncate max-w-md">{lesson.title}</h1>
          <div className="text-sm text-gray-500 flex items-center">
            <span>⏱️ {Math.floor(timeSpent / 60)}:{(timeSpent % 60).toString().padStart(2, '0')}</span>
            {isCompleted && <span className="ml-3 text-green-600 font-medium">✓ Completed</span>}
          </div>
        </div>
        <div className="flex space-x-2">
          <button
            onClick={handlePracticeClick}
            className="px-4 py-2 bg-purple-600 text-white rounded-lg font-medium text-sm hover:bg-purple-700 flex items-center"
          >
            <span className="mr-2">💻</span>
            Practice
          </button>
          <button
            onClick={() => setShowQuiz(!showQuiz)}
            className="px-4 py-2 bg-indigo-600 text-white rounded-lg font-medium text-sm hover:bg-indigo-700 flex items-center"
          >
            <span className="mr-2">❓</span>
            {showQuiz ? 'Hide Quiz' : 'Take Quiz'}
          </button>
          <button
            onClick={handleMarkAsComplete}
            disabled={isCompleted}
            className={`px-4 py-2 rounded-lg font-medium text-sm flex items-center ${
              isCompleted
                ? 'bg-green-100 text-green-800'
                : 'bg-brand-cyan text-white hover:bg-brand-navy'
            } ${isCompleted ? 'cursor-not-allowed' : ''}`}
          >
            <span className="mr-2">✓</span>
            {isCompleted ? 'Completed' : 'Mark Complete'}
          </button>
        </div>
      </div>
      
      <div className="flex-1 overflow-y-auto p-6">
        {showQuiz ? (
          <div className="max-w-3xl mx-auto bg-white rounded-xl shadow-sm border border-gray-200 p-6">
            <h2 className="text-2xl font-bold text-gray-900 mb-6">Knowledge Check</h2>
            <div className="space-y-6">
              <div className="p-4 border border-gray-200 rounded-lg bg-gray-50">
                <h3 className="font-medium text-gray-900 mb-3">What is the primary purpose of this technique?</h3>
                <div className="space-y-2">
                  {['Option A - Basic implementation', 'Option B - Advanced optimization', 'Option C - Core functionality', 'Option D - Secondary feature'].map((option, index) => (
                    <label key={index} className="flex items-center p-2 hover:bg-gray-100 rounded cursor-pointer">
                      <input
                        type="radio"
                        name="question1"
                        className="mr-3 h-4 w-4 text-brand-cyan focus:ring-brand-cyan"
                        onChange={() => handleQuizAnswer('q1', option)}
                      />
                      <span>{option}</span>
                    </label>
                  ))}
                </div>
              </div>
              
              <div className="p-4 border border-gray-200 rounded-lg bg-gray-50">
                <h3 className="font-medium text-gray-900 mb-3">Which scenario best applies this concept?</h3>
                <div className="space-y-2">
                  {['Scenario 1 - Beginner level', 'Scenario 2 - Intermediate complexity', 'Scenario 3 - Advanced application', 'Scenario 4 - Expert implementation'].map((option, index) => (
                    <label key={index} className="flex items-center p-2 hover:bg-gray-100 rounded cursor-pointer">
                      <input
                        type="radio"
                        name="question2"
                        className="mr-3 h-4 w-4 text-brand-cyan focus:ring-brand-cyan"
                        onChange={() => handleQuizAnswer('q2', option)}
                      />
                      <span>{option}</span>
                    </label>
                  ))}
                </div>
              </div>
              
              <div className="p-4 border border-gray-200 rounded-lg bg-gray-50">
                <h3 className="font-medium text-gray-900 mb-3">True or False: This principle always applies.</h3>
                <div className="space-y-2">
                  <label className="flex items-center p-2 hover:bg-gray-100 rounded cursor-pointer">
                    <input
                      type="radio"
                      name="question3"
                      className="mr-3 h-4 w-4 text-brand-cyan focus:ring-brand-cyan"
                      onChange={() => handleQuizAnswer('q3', 'True')}
                    />
                    <span>True</span>
                  </label>
                  <label className="flex items-center p-2 hover:bg-gray-100 rounded cursor-pointer">
                    <input
                      type="radio"
                      name="question3"
                      className="mr-3 h-4 w-4 text-brand-cyan focus:ring-brand-cyan"
                      onChange={() => handleQuizAnswer('q3', 'False')}
                    />
                    <span>False</span>
                  </label>
                </div>
              </div>
              
              <div className="flex justify-end space-x-3 pt-4">
                <button
                  onClick={() => setShowQuiz(false)}
                  className="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg font-medium hover:bg-gray-300"
                >
                  Cancel
                </button>
                <button
                  onClick={submitQuiz}
                  className="px-4 py-2 bg-brand-cyan text-white rounded-lg font-medium hover:bg-brand-navy"
                >
                  Submit Quiz
                </button>
              </div>
            </div>
          </div>
        ) : (
          <div 
            className="max-w-3xl mx-auto"
            dangerouslySetInnerHTML={{ __html: content }}
          />
        )}
      </div>
      
      <div className="p-4 border-t border-gray-200 bg-white sticky bottom-0">
        <div className="flex justify-between items-center max-w-3xl mx-auto">
          <button className="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg font-medium text-sm hover:bg-gray-300 flex items-center">
            ← Previous Lesson
          </button>
          <div className="text-sm text-gray-500">
            Lesson {lesson.order || 1} of {course.lessons ? course.lessons.length : 0}
          </div>
          <button 
            onClick={handlePracticeClick}
            className="px-4 py-2 bg-brand-cyan text-white rounded-lg font-medium text-sm hover:bg-brand-navy flex items-center"
          >
            Practice Now 💻
          </button>
        </div>
      </div>
    </div>
  );
};

export default LessonReadingBoard;