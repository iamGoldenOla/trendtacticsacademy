import React from 'react';
import ReactMarkdown from 'react-markdown';

const LessonReadingBoard = ({ lesson, onLessonComplete }) => {
  if (!lesson) {
    return (
      <div className="flex-1 p-8 flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <svg className="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
          </svg>
          <h3 className="mt-2 text-sm font-medium text-gray-900">No lesson selected</h3>
          <p className="mt-1 text-sm text-gray-500">Select a lesson from the navigation panel to begin learning.</p>
        </div>
      </div>
    );
  }

  // Parse lesson content if it's a JSON string
  let parsedContent = lesson.content;
  if (typeof lesson.content === 'string') {
    try {
      parsedContent = JSON.parse(lesson.content);
    } catch (e) {
      // If parsing fails, treat as plain text
      parsedContent = { 
        lesson_title: lesson.title,
        introduction: lesson.content,
        summary: ''
      };
    }
  }

  return (
    <div className="flex-1 overflow-y-auto bg-white p-8">
      <div className="max-w-4xl mx-auto">
        <header className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">{parsedContent.lesson_title || lesson.title}</h1>
          {lesson.duration && (
            <div className="flex items-center text-sm text-gray-500">
              <svg className="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clipRule="evenodd" />
              </svg>
              {lesson.duration}
            </div>
          )}
        </header>

        <div className="prose prose-lg max-w-none">
          {parsedContent.introduction && (
            <section className="mb-8">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Introduction</h2>
              <ReactMarkdown>{parsedContent.introduction}</ReactMarkdown>
            </section>
          )}

          {parsedContent.big_idea && (
            <section className="mb-8 p-6 bg-blue-50 rounded-lg border border-blue-100">
              <h2 className="text-xl font-semibold text-blue-900 mb-3">Big Idea</h2>
              <ReactMarkdown className="text-blue-800">{parsedContent.big_idea}</ReactMarkdown>
            </section>
          )}

          {parsedContent.steps && Array.isArray(parsedContent.steps) && (
            <section className="mb-8">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Key Steps</h2>
              <ol className="list-decimal pl-6 space-y-3">
                {parsedContent.steps.map((step, index) => (
                  <li key={index} className="text-gray-700">
                    <ReactMarkdown>{step}</ReactMarkdown>
                  </li>
                ))}
              </ol>
            </section>
          )}

          {parsedContent.example && (
            <section className="mb-8 p-6 bg-gray-50 rounded-lg border border-gray-200">
              <h2 className="text-xl font-semibold text-gray-900 mb-3">Example</h2>
              <ReactMarkdown>{parsedContent.example}</ReactMarkdown>
            </section>
          )}

          {parsedContent.playground_activity && (
            <section className="mb-8 p-6 bg-green-50 rounded-lg border border-green-100">
              <h2 className="text-xl font-semibold text-green-900 mb-3">Playground Activity</h2>
              <ReactMarkdown className="text-green-800">{parsedContent.playground_activity}</ReactMarkdown>
            </section>
          )}

          {parsedContent.reflection_question && (
            <section className="mb-8 p-6 bg-purple-50 rounded-lg border border-purple-100">
              <h2 className="text-xl font-semibold text-purple-900 mb-3">Reflection Question</h2>
              <ReactMarkdown className="text-purple-800">{parsedContent.reflection_question}</ReactMarkdown>
            </section>
          )}

          {parsedContent.quiz && parsedContent.quiz.questions && (
            <section className="mb-8">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Quick Quiz</h2>
              <div className="space-y-4">
                {parsedContent.quiz.questions.map((question, index) => (
                  <div key={index} className="p-4 bg-gray-50 rounded-lg">
                    <p className="font-medium text-gray-900 mb-2">{question}</p>
                    {parsedContent.quiz.answers && parsedContent.quiz.answers[index] && (
                      <div className="mt-2 p-3 bg-white border border-gray-200 rounded">
                        <span className="font-medium">Answer:</span> {parsedContent.quiz.answers[index]}
                      </div>
                    )}
                  </div>
                ))}
              </div>
            </section>
          )}

          {parsedContent.summary && (
            <section className="mb-8 p-6 bg-yellow-50 rounded-lg border border-yellow-100">
              <h2 className="text-xl font-semibold text-yellow-900 mb-3">Summary</h2>
              <ReactMarkdown className="text-yellow-800">{parsedContent.summary}</ReactMarkdown>
            </section>
          )}
        </div>

        <div className="mt-12 pt-6 border-t border-gray-200">
          <button
            onClick={() => onLessonComplete && onLessonComplete(lesson.id)}
            className="btn-primary"
          >
            Mark as Complete
          </button>
        </div>
      </div>
    </div>
  );
};

export default LessonReadingBoard;