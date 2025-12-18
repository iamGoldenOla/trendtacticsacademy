import React, { useState, useEffect } from 'react';

const InteractivePlayground = ({ lesson, course, user }) => {
  const [playgroundType, setPlaygroundType] = useState('code'); // 'code', 'prompt', 'quiz'
  const [language, setLanguage] = useState('javascript'); // 'javascript', 'python', 'html', 'css'
  const [code, setCode] = useState('// Write your JavaScript code here\nconsole.log("Hello, World!");\n\n// Try this example:\nfunction greet(name) {\n  return `Hello, ${name}!`;\n}\n\nconsole.log(greet("Student"));');
  const [prompt, setPrompt] = useState('Write a prompt to generate content about ' + (lesson?.title || 'this topic') + '. For example: "Explain the concept of variables in programming"');
  const [quizAnswers, setQuizAnswers] = useState({});
  const [output, setOutput] = useState('');
  const [isRunning, setIsRunning] = useState(false);
  const [savedSnippets, setSavedSnippets] = useState([]);
  const [snippetName, setSnippetName] = useState('');

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

  // Load saved snippets from localStorage
  useEffect(() => {
    const saved = localStorage.getItem(`playground-snippets-${lesson?.id}`);
    if (saved) {
      setSavedSnippets(JSON.parse(saved));
    }
  }, [lesson?.id]);

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
            <style>
              body { font-family: Arial, sans-serif; padding: 20px; }
              .container { max-width: 800px; margin: 0 auto; }
            </style>
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
            <div class="container">
              ${code}
            </div>
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
              
              // Simulate variable assignments
              const varMatches = code.match(/[a-zA-Z_][a-zA-Z0-9_]*\\s*=\\s*[^\\n]+/g);
              if (varMatches) {
                logs.push('Variables assigned:');
                varMatches.forEach(match => {
                  logs.push('  ' + match);
                });
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
      } else if (language === 'css') {
        htmlContent = `
          <!DOCTYPE html>
          <html>
          <head>
            <style>
              ${code}
            </style>
          </head>
          <body>
            <div class="preview-container">
              <h2>CSS Preview</h2>
              <div class="box">Styled Box Element</div>
              <p>This is a paragraph to demonstrate your CSS styles.</p>
              <button>Sample Button</button>
            </div>
          </body>
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
            setOutput(`❌ Error: ${event.data.error}`);
          } else if (event.data.simulated) {
            setOutput(`🐍 Simulated Python Output:
${event.data.logs.join('\n')}
Note: This is a simulation. Real Python execution requires a backend service.`);
          } else if (event.data.html) {
            setOutput(`🖥️ HTML Rendered Output:
${event.data.html.substring(0, 500)}${event.data.html.length > 500 ? '...' : ''}

📝 Console Output:
${event.data.logs.join('\n')}`);
          } else {
            setOutput(`📋 Console output:
${event.data.logs.join('\n')}`);
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
          setOutput('⏰ Execution timed out or failed');
        }
      }, 5000);
    } catch (error) {
      setIsRunning(false);
      setOutput(`💥 Sandbox error: ${error.message}`);
    }
  };

  const handleRunPrompt = () => {
    setIsRunning(true);
    setOutput('🧠 Processing prompt with AI...\n');
    
    // Simulate AI response delay
    setTimeout(() => {
      setIsRunning(false);
      setOutput(`🤖 AI Response:
Based on your prompt "${prompt}", here's a suggested approach:

1. Define clear objectives
2. Identify target audience
3. Structure your response logically
4. Provide concrete examples

Example response for your prompt:
---
${generateSampleAIResponse(prompt)}
---

💾 Tip: Save this prompt and response for future reference!`);
    }, 2000);
  };

  // Generate sample AI response based on prompt
  const generateSampleAIResponse = (promptText) => {
    if (promptText.toLowerCase().includes('variable')) {
      return `A variable is a named storage location in computer memory that holds data which can be changed during program execution.

Key characteristics:
- Has a name (identifier)
- Has a data type (number, string, boolean, etc.)
- Holds a value that can be modified
- Exists in a specific scope

Example in JavaScript:
\`\`\`javascript
let age = 25;        // Number variable
let name = "Alice";  // String variable
let isActive = true; // Boolean variable

age = 26;  // Value can be changed
console.log(name); // Outputs: Alice
\`\`\`

Variables are fundamental to programming as they allow programs to store and manipulate data dynamically.`;
    } else if (promptText.toLowerCase().includes('function')) {
      return `A function is a reusable block of code designed to perform a specific task.

Benefits of functions:
- Code reusability
- Modularity
- Easier debugging
- Better organization

Example in JavaScript:
\`\`\`javascript
// Function declaration
function calculateArea(length, width) {
  return length * width;
}

// Function call
let rectangleArea = calculateArea(10, 5);
console.log(rectangleArea); // Outputs: 50

// Arrow function (ES6)
const greet = (name) => {
  return \`Hello, \${name}!\`;
};

console.log(greet("World")); // Outputs: Hello, World!
\`\`\`

Functions help make code more readable and maintainable by breaking complex problems into smaller, manageable pieces.`;
    } else {
      return `I understand you're asking about "${promptText}". Here's a comprehensive explanation:

[Your detailed response would appear here]

Key points to remember:
1. First important concept
2. Second important concept
3. Practical application
4. Common pitfalls to avoid

Would you like me to elaborate on any specific aspect?`;
    }
  };

  const handleQuizAnswer = (questionId, answer) => {
    setQuizAnswers({
      ...quizAnswers,
      [questionId]: answer
    });
  };

  const saveSnippet = () => {
    if (!snippetName.trim() || !code.trim()) return;
    
    const newSnippet = {
      id: Date.now(),
      name: snippetName,
      code: code,
      language: language,
      createdAt: new Date().toISOString()
    };
    
    const updatedSnippets = [...savedSnippets, newSnippet];
    setSavedSnippets(updatedSnippets);
    localStorage.setItem(`playground-snippets-${lesson?.id}`, JSON.stringify(updatedSnippets));
    setSnippetName('');
  };

  const loadSnippet = (snippet) => {
    setCode(snippet.code);
    setLanguage(snippet.language);
    setSnippetName(snippet.name);
  };

  const deleteSnippet = (id) => {
    const updatedSnippets = savedSnippets.filter(s => s.id !== id);
    setSavedSnippets(updatedSnippets);
    localStorage.setItem(`playground-snippets-${lesson?.id}`, JSON.stringify(updatedSnippets));
  };

  const renderCodePlayground = () => (
    <div className="flex flex-col h-full bg-gray-50">
      <div className="flex-1 flex flex-col">
        <div className="p-4 border-b border-gray-200 bg-white">
          <h3 className="font-medium text-gray-900 flex items-center">
            <span className="mr-2">⌨️</span>
            Code Editor
          </h3>
          <p className="text-sm text-gray-500 mt-1">Write and test your code in real-time</p>
        </div>
        
        <div className="p-3 bg-gray-100 border-b border-gray-200 flex flex-wrap gap-2">
          <select
            value={language}
            onChange={(e) => {
              setLanguage(e.target.value);
              if (e.target.value === 'javascript') {
                setCode('// Write your JavaScript code here\nconsole.log("Hello, World!");\n\n// Try this example:\nfunction greet(name) {\n  return `Hello, ${name}!`;\n}\n\nconsole.log(greet("Student"));');
              } else if (e.target.value === 'html') {
                setCode('<!-- Write your HTML code here -->\n<div class="container">\n  <h1>Hello, World!</h1>\n  <p>This is a sample HTML page.</p>\n  <script>\n    console.log("This is JavaScript inside HTML");\n  </script>\n</div>');
              } else if (e.target.value === 'python') {
                setCode('# Write your Python code here\nprint("Hello, World!")\n\n# Try this example:\ndef greet(name):\n    return f"Hello, {name}!"\n\nprint(greet("Student"))');
              } else if (e.target.value === 'css') {
                setCode('/* Write your CSS code here */\n.container {\n  max-width: 800px;\n  margin: 0 auto;\n  padding: 20px;\n}\n\n.box {\n  background-color: #f0f0f0;\n  padding: 20px;\n  border-radius: 8px;\n  box-shadow: 0 2px 4px rgba(0,0,0,0.1);\n}');
              }
            }}
            className="px-3 py-1 border border-gray-300 rounded text-sm focus:outline-none focus:ring-2 focus:ring-brand-cyan bg-white"
          >
            <option value="javascript">JavaScript</option>
            <option value="html">HTML</option>
            <option value="css">CSS</option>
            <option value="python">Python (Simulated)</option>
          </select>
          
          <div className="flex gap-2">
            <button
              onClick={handleRunCode}
              disabled={isRunning}
              className="px-3 py-1 bg-green-600 text-white text-sm rounded hover:bg-green-700 disabled:opacity-50 flex items-center"
            >
              {isRunning ? (
                <>
                  <span className="mr-1">⏳</span> Running...
                </>
              ) : (
                <>
                  <span className="mr-1">▶️</span> Run Code
                </>
              )}
            </button>
            
            <input
              type="text"
              value={snippetName}
              onChange={(e) => setSnippetName(e.target.value)}
              placeholder="Snippet name"
              className="px-2 py-1 border border-gray-300 rounded text-sm focus:outline-none focus:ring-1 focus:ring-brand-cyan"
            />
            
            <button
              onClick={saveSnippet}
              disabled={!snippetName.trim()}
              className="px-3 py-1 bg-blue-600 text-white text-sm rounded hover:bg-blue-700 disabled:opacity-50"
            >
              Save
            </button>
          </div>
        </div>
        
        <div className="flex flex-1 overflow-hidden">
          <div className="w-3/4 flex flex-col border-r border-gray-200">
            <textarea
              value={code}
              onChange={(e) => setCode(e.target.value)}
              className="flex-1 font-mono text-sm p-4 border-b border-gray-200 resize-none focus:outline-none bg-white"
              placeholder="Write your code here..."
            />
          </div>
          
          <div className="w-1/4 flex flex-col bg-white">
            <div className="p-3 border-b border-gray-200 bg-gray-50">
              <h4 className="font-medium text-gray-900 text-sm">Saved Snippets</h4>
            </div>
            <div className="flex-1 overflow-y-auto">
              {savedSnippets.length > 0 ? (
                <div className="p-2 space-y-2">
                  {savedSnippets.map((snippet) => (
                    <div key={snippet.id} className="p-2 border border-gray-200 rounded text-sm hover:bg-gray-50">
                      <div className="flex justify-between items-start">
                        <div className="font-medium truncate">{snippet.name}</div>
                        <button 
                          onClick={() => deleteSnippet(snippet.id)}
                          className="text-red-500 hover:text-red-700 text-xs"
                        >
                          ✕
                        </button>
                      </div>
                      <div className="text-xs text-gray-500 mt-1">{snippet.language}</div>
                      <button
                        onClick={() => loadSnippet(snippet)}
                        className="mt-2 w-full px-2 py-1 bg-gray-200 text-gray-700 rounded text-xs hover:bg-gray-300"
                      >
                        Load
                      </button>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="p-4 text-center text-gray-500 text-sm">
                  No saved snippets yet.<br />
                  Save your code with a name to access it later.
                </div>
              )}
            </div>
          </div>
        </div>
        
        <div className="p-4 bg-gray-800 text-gray-100 flex-1 flex flex-col">
          <div className="flex justify-between items-center mb-2">
            <h4 className="font-medium flex items-center">
              <span className="mr-2">📤</span>
              Output
            </h4>
          </div>
          <pre className="flex-1 whitespace-pre-wrap text-sm bg-black p-3 rounded overflow-y-auto font-mono">
            {output || 'Click "Run Code" to see output'}
          </pre>
        </div>
      </div>
    </div>
  );

  const renderPromptPlayground = () => (
    <div className="flex flex-col h-full bg-gray-50">
      <div className="p-4 border-b border-gray-200 bg-white">
        <h3 className="font-medium text-gray-900 flex items-center">
          <span className="mr-2">🧠</span>
          Prompt Engineering Playground
        </h3>
        <p className="text-sm text-gray-500 mt-1">Experiment with AI prompts and get instant feedback</p>
      </div>
      
      <div className="flex-1 flex flex-col p-4 overflow-hidden">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 flex-1 overflow-hidden">
          <div className="flex flex-col">
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
                className="px-4 py-2 bg-brand-cyan text-white rounded-lg font-medium hover:bg-brand-navy disabled:opacity-50 flex items-center"
              >
                {isRunning ? (
                  <>
                    <span className="mr-2">🔄</span> Processing...
                  </>
                ) : (
                  <>
                    <span className="mr-2">⚡</span> Run Prompt
                  </>
                )}
              </button>
            </div>
          </div>
          
          <div className="flex flex-col">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              AI Response:
            </label>
            <div className="flex-1 p-3 border border-gray-300 rounded-lg bg-white overflow-y-auto">
              <pre className="whitespace-pre-wrap text-sm">
                {output || 'Run your prompt to see the AI response'}
              </pre>
            </div>
          </div>
        </div>
        
        <div className="mt-4 bg-blue-50 border border-blue-200 rounded-lg p-4">
          <h4 className="font-medium text-blue-900 mb-2">💡 Prompt Engineering Tips</h4>
          <ul className="list-disc pl-5 space-y-1 text-blue-800 text-sm">
            <li>Be specific about what you want the AI to do</li>
            <li>Include examples to guide the response format</li>
            <li>Specify the target audience and tone</li>
            <li>Ask for step-by-step explanations when needed</li>
          </ul>
        </div>
      </div>
    </div>
  );

  const renderQuizPlayground = () => (
    <div className="flex flex-col h-full bg-gray-50">
      <div className="p-4 border-b border-gray-200 bg-white">
        <h3 className="font-medium text-gray-900 flex items-center">
          <span className="mr-2">❓</span>
          Knowledge Check
        </h3>
        <p className="text-sm text-gray-500 mt-1">Test your understanding of the lesson concepts</p>
      </div>
      
      <div className="flex-1 p-4 overflow-y-auto">
        <div className="max-w-3xl mx-auto space-y-6">
          <div className="p-4 border border-gray-200 rounded-lg bg-white shadow-sm">
            <h4 className="font-medium text-gray-900 mb-3">What is the primary purpose of this technique?</h4>
            <div className="space-y-2">
              {[
                'To increase computational complexity', 
                'To optimize performance and efficiency', 
                'To reduce code readability', 
                'To complicate the development process'
              ].map((option, index) => (
                <label key={index} className="flex items-center p-2 hover:bg-gray-50 rounded cursor-pointer border border-gray-100">
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
          
          <div className="p-4 border border-gray-200 rounded-lg bg-white shadow-sm">
            <h4 className="font-medium text-gray-900 mb-3">Which scenario best applies this concept?</h4>
            <div className="space-y-2">
              {[
                'When working with small datasets only', 
                'In situations requiring real-time processing', 
                'For decorative UI elements only', 
                'During database backup operations'
              ].map((option, index) => (
                <label key={index} className="flex items-center p-2 hover:bg-gray-50 rounded cursor-pointer border border-gray-100">
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
          
          <div className="p-4 border border-gray-200 rounded-lg bg-white shadow-sm">
            <h4 className="font-medium text-gray-900 mb-3">True or False: This principle always applies in all contexts.</h4>
            <div className="space-y-2">
              <label className="flex items-center p-2 hover:bg-gray-50 rounded cursor-pointer border border-gray-100">
                <input
                  type="radio"
                  name="question3"
                  className="mr-3 h-4 w-4 text-brand-cyan focus:ring-brand-cyan"
                  onChange={() => handleQuizAnswer('q3', 'True')}
                />
                <span>True</span>
              </label>
              <label className="flex items-center p-2 hover:bg-gray-50 rounded cursor-pointer border border-gray-100">
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
          
          <div className="p-4 border border-gray-200 rounded-lg bg-white shadow-sm">
            <h4 className="font-medium text-gray-900 mb-3">Short Answer: Explain how this concept relates to the previous lesson.</h4>
            <textarea
              className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-brand-cyan focus:border-transparent"
              rows="3"
              placeholder="Type your answer here..."
              onChange={(e) => handleQuizAnswer('q4', e.target.value)}
            />
          </div>
        </div>
        
        <div className="mt-6 max-w-3xl mx-auto">
          <button className="px-4 py-2 bg-brand-cyan text-white rounded-lg font-medium hover:bg-brand-navy flex items-center">
            <span className="mr-2">📤</span>
            Submit Answers
          </button>
        </div>
      </div>
    </div>
  );

  return (
    <div className="h-full flex flex-col bg-white">
      <div className="flex border-b border-gray-200 bg-gray-50">
        <button
          className={`px-4 py-3 text-sm font-medium flex items-center ${
            playgroundType === 'code'
              ? 'text-brand-cyan border-b-2 border-brand-cyan bg-white'
              : 'text-gray-500 hover:text-gray-700 hover:bg-gray-100'
          }`}
          onClick={() => setPlaygroundType('code')}
        >
          <span className="mr-2">⌨️</span>
          Code Editor
        </button>
        <button
          className={`px-4 py-3 text-sm font-medium flex items-center ${
            playgroundType === 'prompt'
              ? 'text-brand-cyan border-b-2 border-brand-cyan bg-white'
              : 'text-gray-500 hover:text-gray-700 hover:bg-gray-100'
          }`}
          onClick={() => setPlaygroundType('prompt')}
        >
          <span className="mr-2">🧠</span>
          Prompt Playground
        </button>
        <button
          className={`px-4 py-3 text-sm font-medium flex items-center ${
            playgroundType === 'quiz'
              ? 'text-brand-cyan border-b-2 border-brand-cyan bg-white'
              : 'text-gray-500 hover:text-gray-700 hover:bg-gray-100'
          }`}
          onClick={() => setPlaygroundType('quiz')}
        >
          <span className="mr-2">❓</span>
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