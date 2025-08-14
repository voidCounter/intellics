'use client';

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import ReactMarkdown, { Components } from 'react-markdown';
import remarkGfm from 'remark-gfm';
import SyntaxHighlighter from 'react-syntax-highlighter';
import atomOneLight from 'react-syntax-highlighter/dist/styles/atom-one-light';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { ArrowLeft, BookOpen, TestTube } from 'lucide-react';
import { useData } from '@/hooks/useData';
import { Lesson } from '@/types/api';
import { ProtectedRoute } from '@/components/auth/protected-route';

export default function LessonPageClient() {
  const params = useParams();
  const { lessons, loadData } = useData();
  const [currentLesson, setCurrentLesson] = useState<Lesson | null>(null);

  useEffect(() => {
    console.log('LessonPageClient mounted');
    loadData();
  }, [loadData]);

  useEffect(() => {
    if (lessons.length > 0 && params.lesson_id) {
      const lessonId = params.lesson_id as string;
      const lesson = lessons.find(l => l.lesson_id === lessonId);
      setCurrentLesson(lesson || null);
    }
  }, [lessons, params.lesson_id]);

  // Custom components for ReactMarkdown
  const components: Components = {
    code({ className, children, ...props }: any) {
      const match = /language-(\w+)/.exec(className || '');
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
          {String(children).replace(/\n$/, '')}
        </SyntaxHighlighter>
      );
    },
  };

  if (!currentLesson) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-gray-600">Loading lesson...</p>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-8">
        {/* Back Button */}
        <div className="mb-6">
          <Button variant="ghost" asChild className="flex items-center gap-2">
            <Link href="/">
              <ArrowLeft className="h-4 w-4" />
              Back to Home
            </Link>
          </Button>
        </div>

        {/* Lesson Header */}
        <div className="mb-8">
          <div className="flex items-center gap-3 mb-4">
            <div className="bg-blue-600 p-3 rounded-lg">
              <BookOpen className="h-6 w-6 text-white" />
            </div>
            <div>
              <h1 className="text-3xl font-bold text-gray-900">{currentLesson.lesson_name}</h1>
            </div>
          </div>
        </div>

        {/* Lesson Content */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Main Content */}
          <div className="lg:col-span-2">
            <Card>
              <CardHeader>
                <CardTitle>Lesson Content</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="prose max-w-none">
                  <ReactMarkdown 
                    remarkPlugins={[remarkGfm]} 
                    components={components}
                  >
                    {currentLesson.lesson_content}
                  </ReactMarkdown>
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-4">
            {/* Practice Button */}
            <Card>
              <CardContent className="p-6">
                <div className="text-center">
                  <TestTube className="h-12 w-12 text-blue-600 mx-auto mb-4" />
                  <h3 className="text-lg font-semibold text-gray-900 mb-2">Ready to Practice?</h3>
                  <p className="text-gray-600 mb-4">
                    Test your understanding with practice questions based on this lesson.
                  </p>
                  <Button asChild className="w-full" size="lg">
                    <Link href={`/lessons/${currentLesson.lesson_id}/practice`}>
                      <TestTube className="h-4 w-4 mr-2" />
                      Start Practice Questions
                    </Link>
                  </Button>
                </div>
              </CardContent>
            </Card>

            {/* Lesson Info */}
            <Card>
              <CardHeader>
                <CardTitle className="text-lg">Lesson Information</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex justify-between">
                  <span className="text-gray-600">Lesson ID:</span>
                  <Badge variant="outline" className="font-mono text-xs">
                    {currentLesson.lesson_id}
                  </Badge>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Content Length:</span>
                  <span className="text-sm text-gray-900">
                    {currentLesson.lesson_content.length} characters
                  </span>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </ProtectedRoute>
  );
}
