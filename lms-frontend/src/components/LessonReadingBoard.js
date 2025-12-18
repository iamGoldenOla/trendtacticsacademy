import React, { useState, useEffect } from 'react';

const LessonReadingBoard = ({ lesson, course, onComplete, user }) => {
  const [content, setContent] = useState('');
  const [isCompleted, setIsCompleted] = useState(false);
  const [timeSpent, setTimeSpent] = useState(0);
  const [quizAnswers, setQuizAnswers] = useState({});
  const [showQuiz, setShowQuiz] = useState(false);

  useEffect(() => {
    // In a real implementation, this would fetch the lesson content from the backend
    // For now, we'll simulate with sample content based on lesson title
    if (lesson) {
      setIsCompleted(lesson.isCompleted || false);
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
      <h1 class="text-3xl font-bold text-gray-900 mb-6">${lesson.title}</h1>
      
      <p class="text-gray-700 mb-4">
        Welcome to this lesson on ${lesson.title}. In this section, we'll explore the fundamental concepts and practical applications.
      </p>
      
      <h2 class="text-2xl font-semibold text-gray-900 mt-8 mb-4">Key Concepts</h2>
      
      <div class="bg-blue-50 border-l-4 border-blue-500 p-4 mb-6">
        <p class="text-blue-700">
          <strong>Important:</strong> Understanding these concepts is crucial for mastering this topic.
        </p>
      </div>
      
      <p class="text-gray-700 mb-4">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
      </p>
      
      <h3 class="text-xl font-semibold text-gray-900 mt-6 mb-3">Practical Example</h3>
      
      <div class="bg-gray-800 text-gray-100 p-4 rounded-lg mb-6">
        <pre class="whitespace-pre-wrap">
// Sample code example
function exampleFunction() {
  console.log("This is a sample code block");
  return true;
}
        </pre>
      </div>
      
      <p class="text-gray-700 mb-4">
        Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      </p>
      
      <div class="aspect-w-16 aspect-h-9 mb-6">
        <iframe 
          src="https://www.youtube.com/embed/dQw4w9WgXcQ" 
          title="Lesson Video" 
          frameborder="0" 
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
          allowfullscreen
          class="w-full h-64 rounded-lg"
        ></iframe>
      </div>
      
      <h3 class="text-xl font-semibold text-gray-900 mt-6 mb-3">Summary</h3>
      
      <ul class="list-disc pl-5 space-y-2 text-gray-700 mb-6">
        <li>Key concept 1 explained in detail</li>
        <li>Key concept 2 with practical application</li>
        <li>Key concept 3 showing real-world usage</li>
      </ul>
    `;
    
    setContent(sampleContent);
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
    alert(`Congratulations! You've completed "${lesson.title}"\nTime spent: ${Math.floor(timeSpent / 60)} minutes and ${timeSpent % 60} seconds`);
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
    alert(`Quiz submitted! Score: ${score}/3\nAnswers have been recorded.`);
    setShowQuiz(false);
  };

  if (!lesson) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-center">
          <div className="text-2xl mb-2">📚</div>
          <p>Select a lesson to begin</p>
        </div>
      </div>
    );
  }

  return (
    <div className="h-full flex flex-col">
      <div className="flex items-center justify-between p-4 border-b border-gray-200 bg-white">
        <div>
          <h1 className="text-xl font-semibold text-gray-900">{lesson.title}</h1>
          <div className="text-sm text-gray-500">
            Time spent: {Math.floor(timeSpent / 60)}:{(timeSpent % 60).toString().padStart(2, '0')}
          </div>
        </div>
        <div className="flex space-x-2">
          <button
            onClick={() => setShowQuiz(!showQuiz)}
            className="px-4 py-2 bg-purple-600 text-white rounded-lg font-medium text-sm hover:bg-purple-700"
          >
            {showQuiz ? 'Hide Quiz' : 'Take Quiz'}
          </button>
          <button
            onClick={handleMarkAsComplete}
            disabled={isCompleted}
            className={`px-4 py-2 rounded-lg font-medium text-sm ${
              isCompleted
                ? 'bg-green-100 text-green-800'
                : 'bg-brand-cyan text-white hover:bg-brand-navy'
            } ${isCompleted ? 'cursor-not-allowed' : ''}`}
          >
            {isCompleted ? '✓ Completed' : 'Mark as Complete'}
          </button>
        </div>
      </div>
      
      <div className="flex-1 overflow-y-auto p-6 bg-white">
        {showQuiz ? (
          <div className="max-w-2xl mx-auto">
            <h2 className="text-2xl font-bold text-gray-900 mb-6">Knowledge Check</h2>
            <div className="space-y-6">
              <div className="p-4 border border-gray-200 rounded-lg">
                <h3 className="font-medium text-gray-900 mb-3">What is the primary purpose of this technique?</h3>
                <div className="space-y-2">
                  {['Option A', 'Option B', 'Option C', 'Option D'].map((option, index) => (
                    <label key={index} className="flex items-center p-2 hover:bg-gray-50 rounded">
                      <input
                        type="radio"
                        name="question1"
                        className="mr-3"
                        onChange={() => handleQuizAnswer('q1', option)}
                      />
                      <span>{option}</span>
                    </label>
                  ))}
                </div>
              </div>
              
              <div className="p-4 border border-gray-200 rounded-lg">
                <h3 className="font-medium text-gray-900 mb-3">Which scenario best applies this concept?</h3>
                <div className="space-y-2">
                  {['Scenario 1', 'Scenario 2', 'Scenario 3', 'Scenario 4'].map((option, index) => (
                    <label key={index} className="flex items-center p-2 hover:bg-gray-50 rounded">
                      <input
                        type="radio"
                        name="question2"
                        className="mr-3"
                        onChange={() => handleQuizAnswer('q2', option)}
                      />
                      <span>{option}</span>
                    </label>
                  ))}
                </div>
              </div>
              
              <div className="p-4 border border-gray-200 rounded-lg">
                <h3 className="font-medium text-gray-900 mb-3">True or False: This principle always applies.</h3>
                <div className="space-y-2">
                  <label className="flex items-center p-2 hover:bg-gray-50 rounded">
                    <input
                      type="radio"
                      name="question3"
                      className="mr-3"
                      onChange={() => handleQuizAnswer('q3', 'True')}
                    />
                    <span>True</span>
                  </label>
                  <label className="flex items-center p-2 hover:bg-gray-50 rounded">
                    <input
                      type="radio"
                      name="question3"
                      className="mr-3"
                      onChange={() => handleQuizAnswer('q3', 'False')}
                    />
                    <span>False</span>
                  </label>
                </div>
              </div>
              
              <div className="flex justify-end">
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
            className="prose max-w-none"
            dangerouslySetInnerHTML={{ __html: content }}
          />
        )}
      </div>
      
      <div className="p-4 border-t border-gray-200 bg-white">
        <div className="flex justify-between items-center">
          <button className="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg font-medium text-sm hover:bg-gray-300">
            ← Previous Lesson
          </button>
          <div className="text-sm text-gray-500">
            {lesson.order} of {course.lessons ? course.lessons.length : 0} lessons
          </div>
          <button className="px-4 py-2 bg-brand-cyan text-white rounded-lg font-medium text-sm hover:bg-brand-navy">
            Next Lesson →
          </button>
        </div>
      </div>
    </div>
  );
};

export default LessonReadingBoard;