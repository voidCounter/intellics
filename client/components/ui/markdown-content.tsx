'use client';

import ReactMarkdown, { Components } from 'react-markdown';
import remarkGfm from 'remark-gfm';
import SyntaxHighlighter from 'react-syntax-highlighter';
import atomOneLight from 'react-syntax-highlighter/dist/styles/atom-one-light';
import { useEffect, useRef, useState, useMemo } from 'react';
import mermaid from 'mermaid';

// Initialize Mermaid with performance optimizations
mermaid.initialize({
  startOnLoad: false, // Don't auto-start rendering
  theme: 'default',
  securityLevel: 'loose',
  fontFamily: 'inherit', // Use system fonts for better performance
  logLevel: 1, // Reduce logging in production
  maxTextSize: 50000, // Limit text size for performance
});

// Simple Mermaid Diagram Component
function MermaidDiagram({ chart, index }: { chart: string; index: number }) {
  const elementRef = useRef<HTMLDivElement>(null);
  const [error, setError] = useState<string | null>(null);
  const [isRendering, setIsRendering] = useState(false);
  const renderedChartRef = useRef<string>('');

  // Render diagram immediately
  useEffect(() => {
    if (elementRef.current && chart !== renderedChartRef.current) {
      console.log(`Rendering Mermaid diagram ${index}:`, chart.substring(0, 100) + '...');
      elementRef.current.innerHTML = '';
      setError(null);
      setIsRendering(true);
      
      const uniqueId = `mermaid-${index}-${Math.random().toString(36).substr(2, 9)}`;
      
      mermaid.render(uniqueId, chart)
        .then(({ svg }) => {
          console.log(`Mermaid diagram ${index} rendered successfully`);
          if (elementRef.current) {
            elementRef.current.innerHTML = svg;
            renderedChartRef.current = chart;
          }
          setIsRendering(false);
        })
        .catch((err) => {
          console.error(`Mermaid rendering error for diagram ${index}:`, err);
          setError(`Failed to render diagram: ${err.message}`);
          setIsRendering(false);
        });
    }
  }, [chart, index]);

  // Show error state
  if (error) {
    return (
      <div className="my-4 p-4 bg-red-50 border border-red-200 rounded-lg">
        <div className="text-red-600 text-sm">{error}</div>
        <details className="mt-2">
          <summary className="cursor-pointer text-red-500 text-xs">Show raw chart code</summary>
          <pre className="mt-2 text-xs bg-red-100 p-2 rounded overflow-x-auto">{chart}</pre>
        </details>
      </div>
    );
  }

  // Show rendered diagram or loading state
  return (
    <div className="my-4 p-4 bg-gray-50 rounded-lg overflow-x-auto">
      {isRendering && (
        <div className="text-center text-gray-500 text-sm mb-2">
          <div className="inline-flex items-center gap-2">
            <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-blue-600"></div>
            Rendering diagram...
          </div>
        </div>
      )}
      <div ref={elementRef} className="flex justify-center" />
    </div>
  );
}

interface MarkdownContentProps {
  content: string;
  variant?: 'default' | 'admin' | 'lesson';
  className?: string;
}

export function MarkdownContent({ content, variant = 'default', className = '' }: MarkdownContentProps) {
  const mermaidIndexRef = useRef(0);

  // Memoize the custom components to prevent unnecessary re-renders
  const components: Components = useMemo(() => ({
    code({ className, children, ...props }: any) {
      const match = /language-(\w+)/.exec(className || '');
      const codeContent = String(children).replace(/\n$/, '');
      
      // Check if it's a Mermaid diagram
      if (match && match[1] === 'mermaid') {
        const currentIndex = mermaidIndexRef.current++;
        // Create a simple hash for the chart content
        const chartHash = codeContent.split('').reduce((a, b) => {
          a = ((a << 5) - a + b.charCodeAt(0)) & 0xffffffff;
          return a;
        }, 0);
        return <MermaidDiagram key={`mermaid-${currentIndex}-${chartHash}`} chart={codeContent} index={currentIndex} />;
      }
      
      // Regular code block
      return !match ? (
        <code className={className} {...props}>
          {children}
        </code>
      ) : (
        <SyntaxHighlighter
          style={atomOneLight}
          language={match[1]}
          PreTag="div"
        >
          {codeContent}
        </SyntaxHighlighter>
      );
    },
    // Custom components for better styling
    h1: ({ children }) => <h1 className="text-2xl font-bold mb-4">{children}</h1>,
    h2: ({ children }) => <h2 className="text-xl font-bold mb-3">{children}</h2>,
    h3: ({ children }) => <h3 className="text-lg font-semibold mb-2">{children}</h3>,
    p: ({ children }) => <p className="mb-3 leading-relaxed">{children}</p>,
    ul: ({ children }) => <ul className="list-disc mb-3 space-y-1 pl-5">{children}</ul>,
    ol: ({ children }) => <ol className="list-decimal mb-3 space-y-1 pl-5">{children}</ol>,
    li: ({ children }) => <li className="mb-1">{children}</li>,
    blockquote: ({ children }) => <blockquote className="border-l-4 border-gray-300 pl-4 italic text-gray-600 mb-3">{children}</blockquote>,
    a: ({ href, children }) => <a href={href} className="text-blue-600 hover:underline" target="_blank" rel="noopener noreferrer">{children}</a>,
    table: ({ children }) => <table className="w-full border-collapse border border-gray-300 mb-3">{children}</table>,
    th: ({ children }) => <th className="border border-gray-300 px-3 py-2 bg-gray-50 font-semibold text-left">{children}</th>,
    td: ({ children }) => <td className="border border-gray-300 px-3 py-2">{children}</td>,
  }), []); // Empty dependency array since components don't depend on any state

  // Reset mermaid index when content changes
  useEffect(() => {
    mermaidIndexRef.current = 0;
  }, [content]);

  const baseClasses = variant === 'admin' 
    ? "prose prose-sm max-w-none min-h-[500px] p-4 border rounded-lg"
    : variant === 'lesson'
    ? "prose max-w-none [&_pre]:!bg-gray-50 [&_pre]:!border [&_pre]:!border-gray-200 [&_pre]:!text-gray-800 [&_pre]:!font-mono [&_pre]:!text-sm [&_pre_code]:!font-mono [&_pre_code]:!text-sm [&_code]:!font-mono [&_code]:!text-sm"
    : "prose max-w-none";

  return (
    <div className={`${baseClasses} ${className}`}>
      <ReactMarkdown 
        remarkPlugins={[remarkGfm]} 
        components={components}
      >
        {content}
      </ReactMarkdown>
    </div>
  );
}
