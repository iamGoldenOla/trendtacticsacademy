import React, { useState, useRef } from 'react';

const RichTextEditor = ({ value, onChange, placeholder }) => {
  const [content, setContent] = useState(value || '');
  const textareaRef = useRef(null);

  const handleChange = (newValue) => {
    setContent(newValue);
    if (onChange) {
      onChange(newValue);
    }
  };

  const insertTextAtCursor = (text) => {
    const textarea = textareaRef.current;
    if (!textarea) return;
    
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const newContent = content.substring(0, start) + text + content.substring(end);
    handleChange(newContent);
    
    // Set cursor position after inserted text
    setTimeout(() => {
      textarea.focus();
      textarea.setSelectionRange(start + text.length, start + text.length);
    }, 0);
  };

  const wrapSelectionWithTag = (tag) => {
    const textarea = textareaRef.current;
    if (!textarea) return;
    
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const selectedText = content.substring(start, end);
    const wrappedText = `<${tag}>${selectedText}</${tag}>`;
    const newContent = content.substring(0, start) + wrappedText + content.substring(end);
    handleChange(newContent);
    
    // Set cursor position after wrapped text
    setTimeout(() => {
      textarea.focus();
      textarea.setSelectionRange(start + wrappedText.length, start + wrappedText.length);
    }, 0);
  };

  const insertYouTubeEmbed = () => {
    const url = prompt('Enter YouTube video URL:');
    if (url) {
      // Extract video ID from URL
      let videoId = '';
      if (url.includes('youtube.com/watch?v=')) {
        videoId = url.split('v=')[1]?.split('&')[0];
      } else if (url.includes('youtu.be/')) {
        videoId = url.split('youtu.be/')[1]?.split('?')[0];
      } else {
        videoId = url.split('/').pop();
      }
      
      if (videoId) {
        const embedCode = `\n<div class="youtube-video">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/${videoId}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>\n`;
        insertTextAtCursor(embedCode);
      } else {
        alert('Invalid YouTube URL');
      }
    }
  };

  const insertCodeBlock = () => {
    const language = prompt('Enter programming language (e.g., javascript, python, html):', 'javascript');
    if (language) {
      const code = prompt('Enter your code:');
      if (code) {
        const codeBlock = `\n<pre class="code-block language-${language}"><code>${code}</code></pre>\n`;
        insertTextAtCursor(codeBlock);
      }
    }
  };

  const insertImage = () => {
    const url = prompt('Enter image URL:');
    if (url) {
      const alt = prompt('Enter image description:') || 'Course image';
      const imageTag = `\n<img src="${url}" alt="${alt}" class="course-image" />\n`;
      insertTextAtCursor(imageTag);
    }
  };

  const insertCallout = (type) => {
    const calloutTypes = {
      info: { icon: 'ℹ️', class: 'callout-info', title: 'Information' },
      warning: { icon: '⚠️', class: 'callout-warning', title: 'Warning' },
      success: { icon: '✅', class: 'callout-success', title: 'Success' },
      error: { icon: '❌', class: 'callout-error', title: 'Error' }
    };
    
    const callout = calloutTypes[type];
    if (callout) {
      const content = prompt(`Enter ${callout.title} content:`) || `${callout.title} content`;
      const calloutTag = `\n<div class="${callout.class}">
  <div class="callout-header">${callout.icon} ${callout.title}</div>
  <div class="callout-content">${content}</div>
</div>\n`;
      insertTextAtCursor(calloutTag);
    }
  };

  const insertList = (type) => {
    const itemCount = prompt(`How many ${type} items?`, '3');
    const count = parseInt(itemCount);
    
    if (!isNaN(count) && count > 0) {
      let listItems = '';
      for (let i = 1; i <= count; i++) {
        listItems += type === 'ordered' 
          ? `\n<ol><li>Item ${i}</li></ol>` 
          : `\n<ul><li>Item ${i}</li></ul>`;
      }
      
      const listTag = `\n<div class="custom-list">${listItems}</div>\n`;
      insertTextAtCursor(listTag);
    }
  };

  return (
    <div className="rich-text-editor border border-gray-300 rounded-lg overflow-hidden">
      <div className="editor-toolbar mb-2 flex flex-wrap gap-2 p-2 bg-gray-100 rounded-t-lg">
        <button
          type="button"
          onClick={() => wrapSelectionWithTag('h2')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 font-medium"
          title="Heading"
        >
          H2
        </button>
        <button
          type="button"
          onClick={() => wrapSelectionWithTag('h3')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 font-medium"
          title="Subheading"
        >
          H3
        </button>
        <button
          type="button"
          onClick={() => wrapSelectionWithTag('strong')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 font-bold"
          title="Bold"
        >
          B
        </button>
        <button
          type="button"
          onClick={() => wrapSelectionWithTag('em')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 italic"
          title="Italic"
        >
          I
        </button>
        <div className="border-r border-gray-300 h-6 my-auto"></div>
        <button
          type="button"
          onClick={insertYouTubeEmbed}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 flex items-center"
          title="Insert YouTube Video"
        >
          <span className="mr-1">🎥</span> Video
        </button>
        <button
          type="button"
          onClick={insertCodeBlock}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 flex items-center"
          title="Insert Code Block"
        >
          <span className="mr-1">{'</>'}</span> Code
        </button>
        <button
          type="button"
          onClick={insertImage}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 flex items-center"
          title="Insert Image"
        >
          <span className="mr-1">🖼️</span> Image
        </button>
        <div className="border-r border-gray-300 h-6 my-auto"></div>
        <button
          type="button"
          onClick={() => insertCallout('info')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 flex items-center"
          title="Insert Info Callout"
        >
          <span className="mr-1">ℹ️</span> Info
        </button>
        <button
          type="button"
          onClick={() => insertCallout('warning')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 flex items-center"
          title="Insert Warning Callout"
        >
          <span className="mr-1">⚠️</span> Warn
        </button>
        <button
          type="button"
          onClick={() => insertCallout('success')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 flex items-center"
          title="Insert Success Callout"
        >
          <span className="mr-1">✅</span> Success
        </button>
        <div className="border-r border-gray-300 h-6 my-auto"></div>
        <button
          type="button"
          onClick={() => insertList('unordered')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 flex items-center"
          title="Insert Bullet List"
        >
          <span className="mr-1">•</span> Bullets
        </button>
        <button
          type="button"
          onClick={() => insertList('ordered')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50 flex items-center"
          title="Insert Numbered List"
        >
          <span className="mr-1">1.</span> Numbers
        </button>
      </div>
      
      <textarea
        ref={textareaRef}
        value={content}
        onChange={(e) => handleChange(e.target.value)}
        placeholder={placeholder || 'Enter your content here... Use the toolbar above to format your text.'}
        className="w-full h-64 p-4 border-t border-gray-300 focus:ring-2 focus:ring-brand-cyan focus:border-transparent resize-none font-mono text-sm"
      />
      
      <div className="p-2 bg-gray-50 text-xs text-gray-500 border-t border-gray-300 rounded-b-lg">
        Tip: Select text and click a formatting button to apply formatting. Use the special buttons to insert media and callouts.
      </div>
    </div>
  );
};

export default RichTextEditor;