import React, { useState } from 'react';

const InteractivePlayground = ({ lesson }) => {
  const [activeTab, setActiveTab] = useState('editor');
  const [code, setCode] = useState('// Write your code here\nconsole.log("Hello, Vibe Coding!");');
  const [output, setOutput] = useState('');
  const [isRunning, setIsRunning] = useState(false);

  const runCode = () => {
    setIsRunning(true);
    // Simulate code execution
    setTimeout(() => {
      setOutput('Hello, Vibe Coding!\n> Program finished');
      setIsRunning(false);
    }, 1000);
  };

  const clearOutput = () => {
    setOutput('');
  };

  return (
    <div className="border-t border-gray-200 h-80 flex flex-col">
      <div className="flex border-b border-gray-200">
        <button
          className={`px-4 py-2 text-sm font-medium ${
            activeTab === 'editor' 
              ? 'text-brand-cyan border-b-2 border-brand-cyan' 
              : 'text-gray-500 hover:text-gray-700'
          }`}
          onClick={() => setActiveTab('editor')}
        >
          Code Editor
        </button>
        <button
          className={`px-4 py-2 text-sm font-medium ${
            activeTab === 'prompt' 
              ? 'text-brand-cyan border-b-2 border-brand-cyan' 
              : 'text-gray-500 hover:text-gray-700'
          }`}
          onClick={() => setActiveTab('prompt')}
        >
          AI Prompt Playground
        </button>
        <button
          className={`px-4 py-2 text-sm font-medium ${
            activeTab === 'output' 
              ? 'text-brand-cyan border-b-2 border-brand-cyan' 
              : 'text-gray-500 hover:text-gray-700'
          }`}
          onClick={() => setActiveTab('output')}
        >
          Output
        </button>
      </div>

      <div className="flex-1 overflow-hidden">
        {activeTab === 'editor' && (
          <div className="h-full flex flex-col">
            <div className="flex-1 relative">
              <textarea
                className="w-full h-full font-mono text-sm p-4 resize-none focus:outline-none"
                value={code}
                onChange={(e) => setCode(e.target.value)}
                placeholder="Write your code here..."
              />
            </div>
            <div className="border-t border-gray-200 p-2 flex justify-end">
              <button
                className="px-4 py-1 bg-red-500 text-white rounded text-sm mr-2"
                onClick={clearOutput}
              >
                Clear
              </button>
              <button
                className={`px-4 py-1 text-white rounded text-sm ${
                  isRunning ? 'bg-gray-400' : 'bg-green-500 hover:bg-green-600'
                }`}
                onClick={runCode}
                disabled={isRunning}
              >
                {isRunning ? 'Running...' : 'Run Code'}
              </button>
            </div>
          </div>
        )}

        {activeTab === 'prompt' && (
          <div className="h-full p-4">
            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-1">
                AI Prompt
              </label>
              <textarea
                className="w-full h-32 border border-gray-300 rounded-md p-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-cyan"
                placeholder="Enter your prompt for the AI assistant..."
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                AI Response
              </label>
              <div className="border border-gray-300 rounded-md p-2 h-32 text-sm text-gray-500">
                AI response will appear here...
              </div>
            </div>
          </div>
        )}

        {activeTab === 'output' && (
          <div className="h-full p-4">
            <pre className="bg-gray-800 text-green-400 p-4 h-full overflow-y-auto text-sm rounded">
              {output || 'No output yet. Run your code to see results.'}
            </pre>
          </div>
        )}
      </div>
    </div>
  );
};

export default InteractivePlayground;