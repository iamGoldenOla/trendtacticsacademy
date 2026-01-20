import React, { useEffect, useRef } from 'react';
import mermaid from 'mermaid';

// Initialize mermaid with configuration
mermaid.initialize({
    startOnLoad: true,
    theme: 'default',
    securityLevel: 'loose',
    fontFamily: 'Inter, system-ui, sans-serif',
    themeVariables: {
        primaryColor: '#00D9FF',
        primaryTextColor: '#000',
        primaryBorderColor: '#00D9FF',
        lineColor: '#4ADE80',
        secondaryColor: '#4ADE80',
        tertiaryColor: '#fff'
    }
});

const MermaidDiagram = ({ chart, className = '' }) => {
    const elementRef = useRef(null);
    const idRef = useRef(`mermaid-${Math.random().toString(36).substr(2, 9)}`);

    useEffect(() => {
        if (elementRef.current && chart) {
            try {
                // Clear previous content
                elementRef.current.innerHTML = chart;

                // Render the diagram
                mermaid.contentLoaded();
            } catch (error) {
                console.error('Mermaid rendering error:', error);
                elementRef.current.innerHTML = `
          <div class="bg-red-50 border border-red-200 rounded-lg p-4 text-red-700">
            <p class="font-semibold">Diagram Error</p>
            <p class="text-sm">Unable to render diagram. Please check the syntax.</p>
          </div>
        `;
            }
        }
    }, [chart]);

    if (!chart) {
        return null;
    }

    return (
        <div className={`mermaid-container my-6 ${className}`}>
            <div
                ref={elementRef}
                id={idRef.current}
                className="flex justify-center items-center bg-white rounded-lg p-6 border border-gray-200 shadow-sm"
            />
        </div>
    );
};

export default MermaidDiagram;
