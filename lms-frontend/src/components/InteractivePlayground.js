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

    try {
      // Call Supabase Edge Function for AI Playground
      const response = await fetch('https://uimdbodamoeyukrghchb.supabase.co/functions/v1/ai-playground', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc'
        },
        body: JSON.stringify({
          prompt: prompt,
          model: 'openai/gpt-4o-mini'
        })
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to generate AI response');
      }

      const data = await response.json();
      setOutput(data.response || 'No response generated');

    } catch (error) {
      console.error('AI Generation Error:', error);
      setOutput(`Error: ${error.message}\n\nPlease try again or contact support if the issue persists.`);
    } finally {
      setIsGenerating(false);
    }
  };

  const handleRunCode = () => {
    setOutput('Running code...\n\nThis is a simulation. In a real implementation, this would execute your code in a secure environment.\n\nCode executed successfully!');
  };

  return (
    <div className="h-96 border-t border-gray-200 flex flex-col">
      <div className="flex border-b border-gray-200">
        <button
          onClick={() => onTabChange('code')}
          className={`px-4 py-2 font-medium text-sm ${activeTab === 'code'
              ? 'text-brand-cyan border-b-2 border-brand-cyan'
              : 'text-gray-500 hover:text-gray-700'
            }`}
        >
          Code Editor
        </button>
        <button
          onClick={() => onTabChange('ai')}
          className={`px-4 py-2 font-medium text-sm ${activeTab === 'ai'
              ? 'text-brand-cyan border-b-2 border-brand-cyan'
              : 'text-gray-500 hover:text-gray-700'
            }`}
        >
          AI Prompt Playground
        </button>
        <button
          onClick={() => onTabChange('output')}
          className={`px-4 py-2 font-medium text-sm ${activeTab === 'output'
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