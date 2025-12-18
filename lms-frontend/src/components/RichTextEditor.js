import React, { useState } from 'react';

const RichTextEditor = ({ value, onChange, placeholder }) => {
  const [content, setContent] = useState(value || '');

  const handleChange = (newValue) => {
    setContent(newValue);
    if (onChange) {
      onChange(newValue);
    }
  };

  const insertText = (text) => {
    const textarea = document.getElementById('rich-text-editor');
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const newContent = content.substring(0, start) + text + content.substring(end);
    handleChange(newContent);
    textarea.focus();
  };

  const insertElement = (tag) => {
    const textarea = document.getElementById('rich-text-editor');
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const selectedText = content.substring(start, end);
    const newText = `<${tag}>${selectedText}</${tag}>`;
    const newContent = content.substring(0, start) + newText + content.substring(end);
    handleChange(newContent);
    textarea.focus();
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
        const embedCode = `<div class="youtube-video">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/${videoId}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>`;
        insertText(embedCode);
      } else {
        alert('Invalid YouTube URL');
      }
    }
  };

  const insertCodeBlock = () => {
    const code = prompt('Enter your code:');
    if (code) {
      const codeBlock = `<pre class="code-block"><code>${code}</code></pre>`;
      insertText(codeBlock);
    }
  };

  const insertImage = () => {
    const url = prompt('Enter image URL:');
    if (url) {
      const alt = prompt('Enter image description:') || 'Course image';
      const imageTag = `<img src="${url}" alt="${alt}" class="course-image" />`;
      insertText(imageTag);
    }
  };

  return (
    <div className="rich-text-editor">
      <div className="editor-toolbar mb-2 flex flex-wrap gap-2 p-2 bg-gray-100 rounded-t-lg">
        <button
          type="button"
          onClick={() => insertElement('h2')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50"
          title="Heading"
        >
          H2
        </button>
        <button
          type="button"
          onClick={() => insertElement('h3')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50"
          title="Subheading"
        >
          H3
        </button>
        <button
          type="button"
          onClick={() => insertElement('strong')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm font-bold hover:bg-gray-50"
          title="Bold"
        >
          B
        </button>
        <button
          type="button"
          onClick={() => insertElement('em')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm italic hover:bg-gray-50"
          title="Italic"
        >
          I
        </button>
        <button
          type="button"
          onClick={insertYouTubeEmbed}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50"
          title="Insert YouTube Video"
        >
          🎥
        </button>
        <button
          type="button"
          onClick={insertCodeBlock}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50"
          title="Insert Code Block"
        >
          {'</>'}
        </button>
        <button
          type="button"
          onClick={insertImage}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50"
          title="Insert Image"
        >
          🖼️
        </button>
        <button
          type="button"
          onClick={() => insertText('<div class="callout-info">Important information here</div>')}
          className="px-3 py-1 bg-white border border-gray-300 rounded text-sm hover:bg-gray-50"
          title="Insert Callout"
        >
          💡
        </button>
      </div>
      
      <textarea
        id="rich-text-editor"
        value={content}
        onChange={(e) => handleChange(e.target.value)}
        placeholder={placeholder || 'Enter your content here...'}
        className="w-full h-64 p-4 border border-gray-300 rounded-b-lg focus:ring-2 focus:ring-brand-cyan focus:border-transparent"
      />
      
      <div className="mt-2 text-sm text-gray-500">
        Tip: Select text and click a formatting button to apply formatting
      </div>
    </div>
  );
};

export default RichTextEditor;