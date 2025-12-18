import React, { useState, useEffect } from 'react';

const InteractivePlayground = ({ lesson, course, user }) => {
  const [playgroundType, setPlaygroundType] = useState('code'); // 'code', 'prompt', 'quiz'
  const [language, setLanguage] = useState('javascript'); // 'javascript', 'python', 'html'
  const [code, setCode] = useState('// Write your JavaScript code here\nconsole.log("Hello, World!");');
  const [prompt, setPrompt] = useState('');
  const [quizAnswers, setQuizAnswers] = useState({});
  const [output, setOutput] = useState('');
  const [isRunning, setIsRunning] = useState(false);

  // Set default playground type based on lesson title
  useEffect(() => {
    if (lesson) {
      if (lesson.title.toLowerCase().includes('prompt') || lesson.title.toLowerCase().includes('ai')) {
        setPlaygroundType('prompt');
      } else if (lesson.title.toLowerCase().includes('quiz') || lesson.title.toLowerCase().includes('test')) {
        setPlaygroundType('quiz');
      } else {
        setPlaygroundType('code');
      }
    }
  }, [lesson]);

  const handleRunCode = () => {
    setIsRunning(true);
    setOutput('Executing code in secure sandbox...\n');
    
    try {
      // Create a sandboxed iframe for code execution
      const iframe = document.createElement('iframe');
      iframe.style.display = 'none';
      iframe.sandbox = 'allow-scripts';
      
      // Create HTML content with the code to execute
      let htmlContent = '';
      
      if (language === 'javascript') {
        htmlContent = `
          <!DOCTYPE html>
          <html>
          <head>
            <script>
              // Override console.log to capture output
              const originalLog = console.log;
              const logs = [];
              console.log = function(...args) {
                logs.push(args.join(' '));
                originalLog.apply(console, args);
              };
              
              // Execute the user code
              try {
                ${code}
                // Send results back to parent
                window.parent.postMessage({
                  type: 'code-result',
                  logs: logs,
                  error: null
                }, '*');
              } catch (error) {
                window.parent.postMessage({
                  type: 'code-result',
                  logs: logs,
                  error: error.message
                }, '*');
              }
            </script>
          </head>
          <body></body>
          </html>
        `;
      } else if (language === 'html') {
        htmlContent = `
          <!DOCTYPE html>
          <html>
          <head>
            <script>
              window.addEventListener('load', function() {
                // Capture any console output
                const originalLog = console.log;
                const logs = [];
                console.log = function(...args) {
                  logs.push(args.join(' '));
                  originalLog.apply(console, args);
                };
                
                try {
                  // Execute any JavaScript in the HTML
                  const scripts = document.querySelectorAll('script');
                  scripts.forEach(script => {
                    if (script.textContent) {
                      eval(script.textContent);
                    }
                  });
                  
                  window.parent.postMessage({
                    type: 'code-result',
                    logs: logs,
                    error: null,
                    html: document.body.innerHTML
                  }, '*');
                } catch (error) {
                  window.parent.postMessage({
                    type: 'code-result',
                    logs: logs,
                    error: error.message
                  }, '*');
                }
              });
            </script>
          </head>
          <body>
            ${code}
          </body>
          </html>
        `;
      } else if (language === 'python') {
        // For Python, we'll simulate since we can't execute it in browser
        htmlContent = `
          <!DOCTYPE html>
          <html>
          <head>
            <script>
              // Simulate Python execution
              const code = \`${code}\`;
              const logs = [];
              
              // Simple Python-like simulation
              if (code.includes('print(')) {
                // Extract print statements
                const printMatches = code.match(/print\\([^)]*\\)/g);
                if (printMatches) {
                  printMatches.forEach(match => {
                    const content = match.replace('print(', '').replace(')', '').replace(/"/g, '').replace(/'/g, '');
                    logs.push(content);
                  });
                }
              }
              
              window.parent.postMessage({
                type: 'code-result',
                logs: logs,
                error: null,
                simulated: true
              }, '*');
            </script>
          </head>
          <body></body>
          </html>
        `;
      }
      
      iframe.srcdoc = htmlContent;
      document.body.appendChild(iframe);
      
      // Listen for results from the iframe
      const handleMessage = (event) => {
        if (event.data.type === 'code-result') {
          window.removeEventListener('message', handleMessage);
          document.body.removeChild(iframe);
          
          setIsRunning(false);
          
          if (event.data.error) {
            setOutput(`Error: ${event.data.error}`);
          } else if (event.data.simulated) {
            setOutput(`Simulated Python Output:
${event.data.logs.join('
')}

Note: This is a simulation. Real Python execution requires a backend service.`);
          } else if (event.data.html) {
            setOutput(`HTML Rendered Output:
${event.data.html}

Console Output:
${event.data.logs.join('
')}`);
          } else {
            setOutput(`Console output:\n${event.data.logs.join('\n')}`);
          }
        }
      };
      
      window.addEventListener('message', handleMessage);
      
      // Timeout for safety
      setTimeout(() => {
        window.removeEventListener('message', handleMessage);
        if (document.body.contains(iframe)) {
          document.body.removeChild(iframe);
        }
        if (isRunning) {
          setIsRunning(false);
          setOutput('Execution timed out or failed');
        }
      }, 5000);
    } catch (error) {
      setIsRunning(false);
      setOutput(`Sandbox error: ${error.message}`);
    }
  };

  const handleRunPrompt = () => {
    setIsRunning(true);
    setOutput('Processing prompt...\n');
    
    // Simulate AI response delay
    setTimeout(() => {
      setIsRunning(false);
      setOutput(`AI Response:
Based on your prompt "${prompt}", here's a suggested approach:

1. Define clear objectives
2. Identify target audience
3. Structure your response logically

This is a simulated response for demonstration purposes.`);
    }, 1500);
  };

  const handleQuizAnswer = (questionId, answer) => {
    setQuizAnswers({
      ...quizAnswers,
      [questionId]: answer
    });
  };

  const renderCodePlayground = () => (
    <div className="flex flex-col h-full">
      <div className="flex-1 flex flex-col">
        <div className="p-4 border-b border-gray-200 bg-gray-50">
          <h3 className="font-medium text-gray-900">Code Editor</h3>
          <p className="text-sm text-gray-500">Write and test your code in real-time</p>
        </div>
        
        <div className="p-2 bg-gray-100 border-b border-gray-200">
          <select
            value={language}
            onChange={(e) => {
              setLanguage(e.target.value);
              if (e.target.value === 'javascript') {
                setCode('// Write your JavaScript code here\nconsole.log("Hello, World!");');
              } else if (e.target.value === 'html') {
                setCode('<!-- Write your HTML code here -->\n<h1>Hello, World!</h1>\n<script>\n  console.log("This is JavaScript inside HTML");\n</script>');
              } else if (e.target.value === 'python') {
                setCode('# Write your Python code here\nprint("Hello, World!")');
              }
            }}
            className="px-3 py-1 border border-gray-300 rounded text-sm focus:outline-none focus:ring-2 focus:ring-brand-cyan"
          >
            <option value="javascript">JavaScript</option>
            <option value="html">HTML/CSS</option>
            <option value="python">Python (Simulated)</option>
          </select>
        </div>
        
        <div className="flex-1 flex flex-col">
          <textarea
            value={code}
            onChange={(e) => setCode(e.target.value)}
            className="flex-1 font-mono text-sm p-4 border-b border-gray-200 resize-none focus:outline-none"
            placeholder="Write your code here..."
          />
          
          <div className="p-4 bg-gray-800 text-gray-100 flex-1">
            <div className="flex justify-between items-center mb-2">
              <h4 className="font-medium">Output</h4>
              <button
                onClick={handleRunCode}
                disabled={isRunning}
                className="px-3 py-1 bg-green-600 text-white text-sm rounded hover:bg-green-700 disabled:opacity-50"
              >
                {isRunning ? 'Running...' : 'Run Code'}
              </button>
            </div>
            <pre className="whitespace-pre-wrap text-sm bg-black p-3 rounded">
              {output || 'Click "Run Code" to see output'}
            </pre>
          </div>
        </div>
      </div>
    </div>
  );

  const renderPromptPlayground = () => (
    <div className="flex flex-col h-full">
      <div className="p-4 border-b border-gray-200 bg-gray-50">
        <h3 className="font-medium text-gray-900">Prompt Engineering Playground</h3>
        <p className="text-sm text-gray-500">Experiment with AI prompts</p>
      </div>
      
      <div className="flex-1 flex flex-col p-4">
        <label className="block text-sm font-medium text-gray-700 mb-2">
          Enter your prompt:
        </label>
        <textarea
          value={prompt}
          onChange={(e) => setPrompt(e.target.value)}
          className="flex-1 p-3 border border-gray-300 rounded-lg resize-none focus:ring-2 focus:ring-brand-cyan focus:border-transparent"
          placeholder="Enter your AI prompt here..."
        />
        
        <div className="mt-4">
          <button
            onClick={handleRunPrompt}
            disabled={isRunning || !prompt.trim()}
            className="px-4 py-2 bg-brand-cyan text-white rounded-lg font-medium hover:bg-brand-navy disabled:opacity-50"
          >
            {isRunning ? 'Processing...' : 'Run Prompt'}
          </button>
        </div>
        
        <div className="mt-4 flex-1">
          <label className="block text-sm font-medium text-gray-700 mb-2">
            AI Response:
          </label>
          <div className="p-3 border border-gray-300 rounded-lg bg-gray-50 h-48 overflow-y-auto">
            <pre className="whitespace-pre-wrap text-sm">
              {output || 'Run your prompt to see the AI response'}
            </pre>
          </div>
        </div>
      </div>
    </div>
  );

  const renderQuizPlayground = () => (
    <div className="flex flex-col h-full">
      <div className="p-4 border-b border-gray-200 bg-gray-50">
        <h3 className="font-medium text-gray-900">Knowledge Check</h3>
        <p className="text-sm text-gray-500">Test your understanding</p>
      </div>
      
      <div className="flex-1 p-4 overflow-y-auto">
        <div className="space-y-6">
          {/* Sample quiz questions - in a real app, these would come from the lesson data */}
          <div className="p-4 border border-gray-200 rounded-lg">
            <h4 className="font-medium text-gray-900 mb-3">What is the primary purpose of this technique?</h4>
            <div className="space-y-2">
              {['Option A', 'Option B', 'Option C', 'Option D'].map((option, index) => (
                <label key={index} className="flex items-center">
                  <input
                    type="radio"
                    name="question1"
                    className="mr-2"
                    onChange={() => handleQuizAnswer('q1', option)}
                  />
                  <span>{option}</span>
                </label>
              ))}
            </div>
          </div>
          
          <div className="p-4 border border-gray-200 rounded-lg">
            <h4 className="font-medium text-gray-900 mb-3">Which scenario best applies this concept?</h4>
            <div className="space-y-2">
              {['Scenario 1', 'Scenario 2', 'Scenario 3', 'Scenario 4'].map((option, index) => (
                <label key={index} className="flex items-center">
                  <input
                    type="radio"
                    name="question2"
                    className="mr-2"
                    onChange={() => handleQuizAnswer('q2', option)}
                  />
                  <span>{option}</span>
                </label>
              ))}
            </div>
          </div>
          
          <div className="p-4 border border-gray-200 rounded-lg">
            <h4 className="font-medium text-gray-900 mb-3">True or False: This principle always applies.</h4>
            <div className="space-y-2">
              <label className="flex items-center">
                <input
                  type="radio"
                  name="question3"
                  className="mr-2"
                  onChange={() => handleQuizAnswer('q3', 'True')}
                />
                <span>True</span>
              </label>
              <label className="flex items-center">
                <input
                  type="radio"
                  name="question3"
                  className="mr-2"
                  onChange={() => handleQuizAnswer('q3', 'False')}
                />
                <span>False</span>
              </label>
            </div>
          </div>
        </div>
        
        <div className="mt-6">
          <button className="px-4 py-2 bg-brand-cyan text-white rounded-lg font-medium hover:bg-brand-navy">
            Submit Answers
          </button>
        </div>
      </div>
    </div>
  );

  return (
    <div className="h-full flex flex-col">
      <div className="flex border-b border-gray-200 bg-white">
        <button
          className={`px-4 py-3 text-sm font-medium ${
            playgroundType === 'code'
              ? 'text-brand-cyan border-b-2 border-brand-cyan'
              : 'text-gray-500 hover:text-gray-700'
          }`}
          onClick={() => setPlaygroundType('code')}
        >
          Code Editor
        </button>
        <button
          className={`px-4 py-3 text-sm font-medium ${
            playgroundType === 'prompt'
              ? 'text-brand-cyan border-b-2 border-brand-cyan'
              : 'text-gray-500 hover:text-gray-700'
          }`}
          onClick={() => setPlaygroundType('prompt')}
        >
          Prompt Playground
        </button>
        <button
          className={`px-4 py-3 text-sm font-medium ${
            playgroundType === 'quiz'
              ? 'text-brand-cyan border-b-2 border-brand-cyan'
              : 'text-gray-500 hover:text-gray-700'
          }`}
          onClick={() => setPlaygroundType('quiz')}
        >
          Knowledge Check
        </button>
      </div>
      
      <div className="flex-1 overflow-hidden">
        {playgroundType === 'code' && renderCodePlayground()}
        {playgroundType === 'prompt' && renderPromptPlayground()}
        {playgroundType === 'quiz' && renderQuizPlayground()}
      </div>
    </div>
  );
};

export default InteractivePlayground;