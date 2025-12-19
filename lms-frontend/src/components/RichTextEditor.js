import React, { useState } from 'react';

const RichTextEditor = ({ value, onChange, placeholder }) => {
  const [content, setContent] = useState(value || '');

  const handleChange = (newValue) => {
    setContent(newValue);
    if (onChange) {
      onChange(newValue);
    }
  };

  const insertMarkdown = (markdownSyntax) => {
    const textarea = document.getElementById('rich-text-editor');
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const selectedText = content.substring(start, end);
    const newText = content.substring(0, start) + markdownSyntax.replace('{}', selectedText) + content.substring(end);
    
    handleChange(newText);
    setTimeout(() => {
      textarea.focus();
      textarea.setSelectionRange(
        start + markdownSyntax.indexOf('{}'), 
        start + markdownSyntax.indexOf('{}') + selectedText.length
      );
    }, 0);
  };

  return (
    <div className="border border-gray-300 rounded-md overflow-hidden">
      {/* Toolbar */}
      <div className="bg-gray-50 border-b border-gray-300 p-2 flex flex-wrap gap-1">
        <button
          type="button"
          className="p-1 rounded hover:bg-gray-200"
          onClick={() => insertMarkdown('# {}')}
          title="Heading 1"
        >
          <span className="font-bold">H1</span>
        </button>
        <button
          type="button"
          className="p-1 rounded hover:bg-gray-200"
          onClick={() => insertMarkdown('## {}')}
          title="Heading 2"
        >
          <span className="font-bold">H2</span>
        </button>
        <button
          type="button"
          className="p-1 rounded hover:bg-gray-200"
          onClick={() => insertMarkdown('**{}**')}
          title="Bold"
        >
          <span className="font-bold">B</span>
        </button>
        <button
          type="button"
          className="p-1 rounded hover:bg-gray-200"
          onClick={() => insertMarkdown('*{}*')}
          title="Italic"
        >
          <span className="italic">I</span>
        </button>
        <button
          type="button"
          className="p-1 rounded hover:bg-gray-200"
          onClick={() => insertMarkdown('- {}')}
          title="Bullet List"
        >
          <span>•</span>
        </button>
        <button
          type="button"
          className="p-1 rounded hover:bg-gray-200"
          onClick={() => insertMarkdown('1. {}')}
          title="Numbered List"
        >
          <span>1.</span>
        </button>
        <button
          type="button"
          className="p-1 rounded hover:bg-gray-200"
          onClick={() => insertMarkdown('[{}]()}')}
          title="Link"
        >
          <span>🔗</span>
        </button>
        <button
          type="button"
          className="p-1 rounded hover:bg-gray-200"
          onClick={() => insertMarkdown('`{}`')}
          title="Code"
        >
          <span className="font-mono">&lt;/&gt;</span>
        </button>
      </div>

      {/* Textarea */}
      <textarea
        id="rich-text-editor"
        className="w-full h-64 p-3 focus:outline-none resize-none font-mono text-sm"
        value={content}
        onChange={(e) => handleChange(e.target.value)}
        placeholder={placeholder || 'Write your lesson content using Markdown...'}
      />

      {/* Preview Toggle */}
      <div className="bg-gray-50 border-t border-gray-300 p-2 text-xs text-gray-500">
        Supports Markdown syntax. Use toolbar buttons or type markdown directly.
      </div>
    </div>
  );
};

export default RichTextEditor;