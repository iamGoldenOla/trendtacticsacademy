import React from 'react';
import ReactMarkdown from 'react-markdown';

const LessonReadingBoard = ({ lesson }) => {
  if (!lesson) {
    return (
      <div className="flex-1 flex items-center justify-center">
        <div className="text-center">
          <div className="text-gray-500 mb-2">Select a lesson to begin</div>
          <div className="text-sm text-gray-400">Choose a lesson from the navigation panel</div>
        </div>
      </div>
    );
  }

  return (
    <div className="flex-1 overflow-y-auto p-6">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-2xl font-bold text-gray-900 mb-2">{lesson.title}</h1>
        <div className="text-gray-600 mb-6">{lesson.description}</div>
        
        <div className="prose max-w-none">
          <ReactMarkdown
            components={{
              h1: ({node, ...props}) => <h1 className="text-2xl font-bold mt-6 mb-4" {...props} />,
              h2: ({node, ...props}) => <h2 className="text-xl font-semibold mt-5 mb-3" {...props} />,
              h3: ({node, ...props}) => <h3 className="text-lg font-medium mt-4 mb-2" {...props} />,
              p: ({node, ...props}) => <p className="mb-4 text-gray-700" {...props} />,
              ul: ({node, ...props}) => <ul className="list-disc pl-5 mb-4" {...props} />,
              ol: ({node, ...props}) => <ol className="list-decimal pl-5 mb-4" {...props} />,
              li: ({node, ...props}) => <li className="mb-1" {...props} />,
              code: ({node, ...props}) => <code className="bg-gray-100 rounded px-1 py-0.5 font-mono text-sm" {...props} />,
              pre: ({node, ...props}) => <pre className="bg-gray-800 text-white p-4 rounded-lg overflow-x-auto mb-4" {...props} />,
              img: ({node, ...props}) => <img className="rounded-lg my-4" {...props} />,
              a: ({node, ...props}) => <a className="text-blue-600 hover:underline" {...props} />
            }}
          >
            {lesson.content || 'No content available for this lesson.'}
          </ReactMarkdown>
        </div>
      </div>
    </div>
  );
};

export default LessonReadingBoard;