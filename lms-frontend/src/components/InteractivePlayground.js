import React, { useState } from 'react';

const InteractivePlayground = ({ activeTab, onTabChange, lesson }) => {
  const [code, setCode] = useState('// Write your code here\nconsole.log("Hello, Vibe Coding!");');
  const [prompt, setPrompt] = useState('');
  const [output, setOutput] = useState('');
  const [isGenerating, setIsGenerating] = useState(false);

  const handleGenerate = async () => {
    if (!prompt.trim()) return;
    
    setIsGenerating(true);
    setOutput('Generating response...');
    
    // Simulate AI response
    setTimeout(() => {
      setOutput(`AI Response to: "${prompt}"

This is a simulated response. In a real implementation, this would connect to an AI service to generate code or content based on your prompt.

For example, if you asked for a function to calculate factorial, it might generate:

function factorial(n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

console.log(factorial(5)); // Output: 120`);
      setIsGenerating(false);
    }, 1500);
  };

  const handleRunCode = () => {
    setOutput('Running code...\n\nThis is a simulation. In a real implementation, this would execute your code in a secure environment.\n\nCode executed successfully!');
  };

  return (
    <div className="h-96 border-t border-gray-200 flex flex-col">
      <div className="flex border-b border-gray-200">
        <button
          onClick={() => onTabChange('code')}
          className={`px-4 py-2 font-medium text-sm ${
            activeTab === 'code'
              ? 'text-brand-cyan border-b-2 border-brand-cyan'
              : 'text-gray-500 hover:text-gray-700'
          }`}
        >
          Code Editor
        </button>
        <button
          onClick={() => onTabChange('ai')}
          className={`px-4 py-2 font-medium text-sm ${
            activeTab === 'ai'
              ? 'text-brand-cyan border-b-2 border-brand-cyan'
              : 'text-gray-500 hover:text-gray-700'
          }`}
        >
          AI Prompt Playground
        </button>
        <button
          onClick={() => onTabChange('output')}
          className={`px-4 py-2 font-medium text-sm ${
            activeTab === 'output'
              ? 'text-brand-cyan border-b-2 border-brand-cyan'
              : 'text-gray-500 hover:text-gray-700'
          }`}
        >
          Output
        </button>
      </div>

      <div className="flex-1 overflow-hidden">
        {activeTab === 'code' && (
          <div className="h-full flex flex-col">
            <div className="flex-1 p-4">
              <textarea
                value={code}
                onChange={(e) => setCode(e.target.value)}
                className="w-full h-full font-mono text-sm p-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-brand-cyan focus:border-brand-cyan"
                placeholder="Write your code here..."
              />
            </div>
            <div className="p-4 border-t border-gray-200">
              <button
                onClick={handleRunCode}
                className="btn-primary"
              >
                Run Code
              </button>
            </div>
          </div>
        )}

        {activeTab === 'ai' && (
          <div className="h-full flex flex-col">
            <div className="flex-1 p-4">
              <textarea
                value={prompt}
                onChange={(e) => setPrompt(e.target.value)}
                className="w-full h-full font-mono text-sm p-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-brand-cyan focus:border-brand-cyan"
                placeholder="Ask the AI to help you with your project. For example: 'Create a function that sorts an array of numbers' or 'Help me design a user interface for a todo app'"
              />
            </div>
            <div className="p-4 border-t border-gray-200">
              <button
                onClick={handleGenerate}
                disabled={isGenerating || !prompt.trim()}
                className="btn-primary disabled:opacity-50"
              >
                {isGenerating ? 'Generating...' : 'Ask AI'}
              </button>
            </div>
          </div>
        )}

        {activeTab === 'output' && (
          <div className="h-full p-4">
            <pre className="w-full h-full bg-gray-900 text-green-400 font-mono text-sm p-4 rounded-lg overflow-auto whitespace-pre-wrap">
              {output || 'Output will appear here after running code or asking AI...'}
            </pre>
          </div>
        )}
      </div>
    </div>
  );
};

export default InteractivePlayground;