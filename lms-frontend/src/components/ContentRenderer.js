import React from 'react';
import MermaidDiagram from './MermaidDiagram';

/**
 * Enhanced content renderer that handles:
 * - Mermaid diagrams
 * - HTML content
 * - Markdown-style formatting
 */
const ContentRenderer = ({ content, className = '' }) => {
    if (!content) {
        return null;
    }

    // Check if content contains mermaid diagrams
    const mermaidRegex = /```mermaid\n([\s\S]*?)```/g;
    const hasMermaid = mermaidRegex.test(content);

    if (!hasMermaid) {
        // No mermaid diagrams, render as HTML
        return (
            <div
                className={`prose prose-lg max-w-none ${className}`}
                dangerouslySetInnerHTML={{ __html: content }}
            />
        );
    }

    // Split content into parts (text and mermaid blocks)
    const parts = [];
    let lastIndex = 0;
    let match;

    // Reset regex
    mermaidRegex.lastIndex = 0;

    while ((match = mermaidRegex.exec(content)) !== null) {
        // Add text before mermaid block
        if (match.index > lastIndex) {
            const textBefore = content.substring(lastIndex, match.index);
            if (textBefore.trim()) {
                parts.push({
                    type: 'html',
                    content: textBefore,
                    key: `html-${lastIndex}`
                });
            }
        }

        // Add mermaid block
        parts.push({
            type: 'mermaid',
            content: match[1].trim(),
            key: `mermaid-${match.index}`
        });

        lastIndex = match.index + match[0].length;
    }

    // Add remaining text after last mermaid block
    if (lastIndex < content.length) {
        const textAfter = content.substring(lastIndex);
        if (textAfter.trim()) {
            parts.push({
                type: 'html',
                content: textAfter,
                key: `html-${lastIndex}`
            });
        }
    }

    // Render all parts
    return (
        <div className={className}>
            {parts.map((part) => {
                if (part.type === 'mermaid') {
                    return (
                        <MermaidDiagram
                            key={part.key}
                            chart={part.content}
                        />
                    );
                } else {
                    return (
                        <div
                            key={part.key}
                            className="prose prose-lg max-w-none"
                            dangerouslySetInnerHTML={{ __html: part.content }}
                        />
                    );
                }
            })}
        </div>
    );
};

export default ContentRenderer;
