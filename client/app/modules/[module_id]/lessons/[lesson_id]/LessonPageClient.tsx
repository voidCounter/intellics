'use client';

import { useEffect, useState, useRef, useMemo } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { ArrowLeft, BookOpen, Clock, Brain, Play } from 'lucide-react';
import { useLessonData } from '@/hooks/useLessonData';
import { Lesson } from '@/types/api';
import { ProtectedRoute } from '@/components/auth/protected-route';
import { useSessionStore } from '@/lib/stores';
import { MarkdownContent } from '@/components/ui/markdown-content';
import { useInteractionLogger } from '@/lib/services/interactionLogger';
import { logger } from '@/lib/utils';

export default function LessonPageClient() {
  const params = useParams();
  const { currentLesson, isLoading, error } = useLessonData(params.lesson_id as string);
  const sessionId = useSessionStore((state) => state.sessionId);
  const startTimeRef = useRef<number | null>(null);
  const interactionLogger = useInteractionLogger();

  // Debug session state
  useEffect(() => {
    logger.info('LessonPageClient - sessionId changed:', sessionId);
  }, [sessionId]);

  useEffect(() => {
    logger.info('LessonPageClient mounted');
  }, []);

  useEffect(() => {
    if (currentLesson && params.lesson_id) {
      const lessonId = params.lesson_id as string;
      
      // Log lesson start interaction using centralized logger
      if (currentLesson && sessionId) {
        startTimeRef.current = Date.now();
        logger.info('Logging lesson start - sessionId:', sessionId, 'lessonId:', lessonId, 'moduleId:', params.module_id);
        interactionLogger.logLessonStart(sessionId, lessonId, params.module_id as string)
          .catch((error: unknown) => {
            logger.error('Failed to log lesson start interaction:', error);
          });
      }
    }
  }, [currentLesson, params.lesson_id, params.module_id, sessionId]);

  // Log lesson exit when component unmounts
  useEffect(() => {
    return () => {
      if (startTimeRef.current && currentLesson && sessionId) {
        const timeSpent = Math.floor((Date.now() - startTimeRef.current) / 1000);
        if (timeSpent > 10) { // Only log if spent more than 10 seconds
          if (sessionId) {
            interactionLogger.logLessonExit(
              sessionId,
              currentLesson.lesson_id,
              params.module_id as string,
              timeSpent
            ).catch((error: unknown) => {
              logger.error('Failed to log lesson exit interaction:', error);
            });
          }
        }
      }
    };
  }, [currentLesson, params.module_id, sessionId]);

  // Memoize lesson content to prevent unnecessary re-renders
  const memoizedLessonContent = useMemo(() => {
    if (!currentLesson) return null;
    return (
      <MarkdownContent 
        content={currentLesson.lesson_content}
        variant="lesson"
      />
    );
  }, [currentLesson?.lesson_content]);


  if (isLoading) {
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

  if (error) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-red-600">Error loading lesson: {error}</p>
            <Button 
              onClick={() => window.location.reload()} 
              className="mt-4"
              variant="outline"
            >
              Retry
            </Button>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  if (!currentLesson) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-gray-600">Lesson not found</p>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-8 max-w-7xl">
        {/* Back Button */}
        <div className="mb-6 w-fit">
          <Button variant="link" asChild className="flex items-center gap-2">
            <Link href={`/modules/${params.module_id}`}>
              <ArrowLeft className="h-4 w-4" />
              Back to Module
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
              <div className="flex items-center gap-2 mt-2">
                <span className="text-sm text-gray-500">
                  <Clock className="h-4 w-4" />
                </span>
                <span className="text-sm text-gray-600">
                  {Math.ceil(currentLesson.lesson_content.split(' ').length / 200)} min read
                </span>
              </div>
            </div>
          </div>
        </div>

        {/* Lesson Content */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Main Content */}
          <div className="lg:col-span-2">
            <Card className='pt-6 border-0'>
              <CardContent className='border-0'>
                {memoizedLessonContent}
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-4">
            {/* Practice Button */}
            <Card>
              <CardContent className="p-6">
                <div className="text-center">
                  <Brain className="h-12 w-12 text-blue-600 mx-auto mb-4" />
                  <h3 className="text-lg font-semibold text-gray-900 mb-2">Ready to Practice?</h3>
                  <p className="text-gray-600 mb-4">
                    Test your understanding with practice questions based on this lesson.
                  </p>
                  <Button asChild className="w-full" size="lg">
                    <Link href={`/modules/${params.module_id}/lessons/${currentLesson.lesson_id}/practice`}>
                      <Play className="h-4 w-4 mr-2" />
                      Start Practice Questions
                    </Link>
                  </Button>
                </div>
              </CardContent>
            </Card>


          </div>
        </div>
      </div>
    </ProtectedRoute>
  );
}
