import React, { useState } from 'react';
import ReactMarkdown from 'react-markdown';

const VibeCodingLesson = ({ lesson, onNext, onPrevious, currentLessonIndex, totalLessons }) => {
  const [activeTab, setActiveTab] = useState('lesson');
  const [quizAnswers, setQuizAnswers] = useState({});
  const [showQuizResults, setShowQuizResults] = useState(false);
  
  // Parse lesson content from JSON string
  const lessonData = typeof lesson.content === 'string' ? JSON.parse(lesson.content) : lesson.content;
  
  const handleQuizAnswerChange = (questionIndex, answer) => {
    setQuizAnswers(prev => ({
      ...prev,
      [questionIndex]: answer
    }));
  };
  
  const handleSubmitQuiz = () => {
    setShowQuizResults(true);
  };
  
  const resetQuiz = () => {
    setQuizAnswers({});
    setShowQuizResults(false);
  };

  if (!lessonData) {
    return (
      <div className="p-6 text-center">
        <p>Loading lesson content...</p>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto p-4">
      {/* Lesson Header */}
      <div className="mb-6">
        <h1 className="text-3xl font-bold text-gray-800 mb-2">{lessonData.lesson_title}</h1>
        <div className="flex items-center text-sm text-gray-600">
          <span className="bg-blue-100 text-blue-800 px-2 py-1 rounded mr-2">
            Lesson {lessonData.lesson_number}
          </span>
          <span>{lesson.module?.title}</span>
        </div>
      </div>

      {/* Tab Navigation */}
      <div className="border-b border-gray-200 mb-6">
        <nav className="flex space-x-8">
          <button
            onClick={() => setActiveTab('lesson')}
            className={`py-4 px-1 border-b-2 font-medium text-sm ${
              activeTab === 'lesson'
                ? 'border-blue-500 text-blue-600'
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
            }`}
          >
            Lesson Content
          </button>
          <button
            onClick={() => setActiveTab('playground')}
            className={`py-4 px-1 border-b-2 font-medium text-sm ${
              activeTab === 'playground'
                ? 'border-blue-500 text-blue-600'
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
            }`}
          >
            Playground
          </button>
          <button
            onClick={() => setActiveTab('quiz')}
            className={`py-4 px-1 border-b-2 font-medium text-sm ${
              activeTab === 'quiz'
                ? 'border-blue-500 text-blue-600'
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
            }`}
          >
            Quiz
          </button>
        </nav>
      </div>

      {/* Lesson Content Tab */}
      {activeTab === 'lesson' && (
        <div className="space-y-8">
          <section>
            <h2 className="text-xl font-semibold text-gray-800 mb-3">Introduction</h2>
            <p className="text-gray-700 leading-relaxed">{lessonData.introduction}</p>
          </section>

          <section className="bg-blue-50 p-6 rounded-lg">
            <h2 className="text-xl font-semibold text-gray-800 mb-3">Big Idea</h2>
            <p className="text-gray-700 leading-relaxed">{lessonData.big_idea}</p>
          </section>

          <section>
            <h2 className="text-xl font-semibold text-gray-800 mb-3">Visual Explanation</h2>
            <p className="text-gray-700 leading-relaxed">{lessonData.visuals}</p>
          </section>

          <section>
            <h2 className="text-xl font-semibold text-gray-800 mb-3">Step-by-Step Breakdown</h2>
            <ol className="list-decimal list-inside space-y-2 text-gray-700">
              {lessonData.steps?.map((step, index) => (
                <li key={index} className="leading-relaxed">{step}</li>
              ))}
            </ol>
          </section>

          <section>
            <h2 className="text-xl font-semibold text-gray-800 mb-3">Practical Example</h2>
            <p className="text-gray-700 leading-relaxed">{lessonData.example}</p>
          </section>

          <section>
            <h2 className="text-xl font-semibold text-gray-800 mb-3">Reflection Question</h2>
            <p className="text-gray-700 leading-relaxed italic">{lessonData.reflection_question}</p>
          </section>

          <section>
            <h2 className="text-xl font-semibold text-gray-800 mb-3">Summary</h2>
            <p className="text-gray-700 leading-relaxed">{lessonData.summary}</p>
          </section>

          {lessonData.resources && (
            <section>
              <h2 className="text-xl font-semibold text-gray-800 mb-3">Resources</h2>
              {lessonData.resources.video && (
                <div className="mb-4">
                  <h3 className="font-medium text-gray-800 mb-1">Recommended Video</h3>
                  <p className="text-gray-700">
                    <strong>{lessonData.resources.video.title}</strong> by {lessonData.resources.video.creator}
                  </p>
                  <p className="text-sm text-gray-600 mt-1">{lessonData.resources.video.reason}</p>
                </div>
              )}
              {lessonData.resources.extra_reading && lessonData.resources.extra_reading.length > 0 && (
                <div>
                  <h3 className="font-medium text-gray-800 mb-1">Extra Reading</h3>
                  <ul className="list-disc list-inside space-y-1 text-gray-700">
                    {lessonData.resources.extra_reading.map((resource, index) => (
                      <li key={index}>{resource}</li>
                    ))}
                  </ul>
                </div>
              )}
            </section>
          )}
        </div>
      )}

      {/* Playground Tab */}
      {activeTab === 'playground' && (
        <div className="space-y-6">
          <section>
            <h2 className="text-xl font-semibold text-gray-800 mb-3">Try It Yourself</h2>
            <div className="bg-yellow-50 p-6 rounded-lg border border-yellow-200">
              <p className="text-gray-700 leading-relaxed mb-4">{lessonData.playground_activity}</p>
              
              <div className="mt-4">
                <label htmlFor="playground-input" className="block text-sm font-medium text-gray-700 mb-2">
                  Your Response
                </label>
                <textarea
                  id="playground-input"
                  rows={6}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                  placeholder="Type your response here..."
                ></textarea>
                <div className="mt-2 flex justify-end">
                  <button
                    type="button"
                    className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                  >
                    Save Response
                  </button>
                </div>
              </div>
            </div>
          </section>

          <section>
            <h2 className="text-xl font-semibold text-gray-800 mb-3">AI Assistant</h2>
            <div className="bg-gray-50 p-6 rounded-lg border border-gray-200">
              <p className="text-gray-700 mb-4">
                Need help with your response or have questions about this lesson? Our AI assistant can help!
              </p>
              <button
                type="button"
                className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500"
              >
                Ask AI Assistant
              </button>
            </div>
          </section>
        </div>
      )}

      {/* Quiz Tab */}
      {activeTab === 'quiz' && (
        <div className="space-y-6">
          <section>
            <h2 className="text-xl font-semibold text-gray-800 mb-3">Quick Quiz</h2>
            
            {!showQuizResults ? (
              <div className="bg-white p-6 rounded-lg border border-gray-200">
                {lessonData.quiz?.questions?.map((question, index) => (
                  <div key={index} className="mb-6">
                    <h3 className="font-medium text-gray-800 mb-2">
                      {index + 1}. {question}
                    </h3>
                    <div className="ml-4">
                      <textarea
                        value={quizAnswers[index] || ''}
                        onChange={(e) => handleQuizAnswerChange(index, e.target.value)}
                        rows={3}
                        className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                        placeholder="Type your answer..."
                      />
                    </div>
                  </div>
                ))}
                
                <div className="flex justify-end">
                  <button
                    onClick={handleSubmitQuiz}
                    className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                  >
                    Submit Quiz
                  </button>
                </div>
              </div>
            ) : (
              <div className="bg-white p-6 rounded-lg border border-gray-200">
                <h3 className="font-medium text-gray-800 mb-4">Quiz Results</h3>
                
                <div className="space-y-4">
                  {lessonData.quiz?.questions?.map((question, index) => (
                    <div key={index} className="border-b border-gray-200 pb-4">
                      <h4 className="font-medium text-gray-800 mb-2">
                        {index + 1}. {question}
                      </h4>
                      <div className="ml-4">
                        <p className="text-gray-700 mb-2">
                          <span className="font-medium">Your Answer:</span> {quizAnswers[index] || 'No answer provided'}
                        </p>
                        <p className="text-gray-700">
                          <span className="font-medium">Suggested Answer:</span> {lessonData.quiz.answers[index]}
                        </p>
                      </div>
                    </div>
                  ))}
                </div>
                
                <div className="mt-6 flex justify-between">
                  <button
                    onClick={resetQuiz}
                    className="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md shadow-sm text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                  >
                    Retake Quiz
                  </button>
                </div>
              </div>
            )}
          </section>
        </div>
      )}

      {/* Navigation Buttons */}
      <div className="mt-8 flex justify-between">
        <button
          onClick={onPrevious}
          disabled={currentLessonIndex === 0}
          className={`inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md shadow-sm ${
            currentLessonIndex === 0
              ? 'text-gray-400 bg-gray-100 cursor-not-allowed'
              : 'text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500'
          }`}
        >
          Previous Lesson
        </button>
        
        <div className="text-sm text-gray-500 self-center">
          Lesson {currentLessonIndex + 1} of {totalLessons}
        </div>
        
        <button
          onClick={onNext}
          disabled={currentLessonIndex === totalLessons - 1}
          className={`inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white ${
            currentLessonIndex === totalLessons - 1
              ? 'bg-gray-400 cursor-not-allowed'
              : 'bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500'
          }`}
        >
          Next Lesson
        </button>
      </div>
    </div>
  );
};

export default VibeCodingLesson;