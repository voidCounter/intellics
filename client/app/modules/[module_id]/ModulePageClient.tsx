"use client";

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { BookOpen, ArrowLeft, Brain, Play, PlayIcon } from 'lucide-react';
import { useModuleData } from '@/hooks/useModuleData';
import { Module, ModuleLessonMapping } from '@/types/api';
import { ProtectedRoute } from '@/components/auth/protected-route';

export default function ModulePageClient() {
  const params = useParams();
  const { modules, lessons, isLoading, error } = useModuleData(params.module_id as string);
  const [currentModule, setCurrentModule] = useState<Module | null>(null);
  const [moduleLessons, setModuleLessons] = useState<ModuleLessonMapping[]>([]);

  // Helper function to truncate text at word boundary
  const truncateText = (text: string, maxLength: number = 120): string => {
    if (text.length <= maxLength) return text;
    
    // Find the last space before maxLength
    const truncated = text.substring(0, maxLength);
    const lastSpace = truncated.lastIndexOf(' ');
    
    if (lastSpace > 0) {
      return truncated.substring(0, lastSpace) + '...';
    }
    
    return truncated + '...';
  };

  // React Query handles loading automatically, no need for manual useEffect

  useEffect(() => {
    if (modules.length > 0 && params.module_id) {
      const moduleId = params.module_id as string;
      const module = modules.find(m => m.module_id === moduleId);
      setCurrentModule(module || null);
      // For now, show all lessons since our new Lesson type doesn't have module_id
      // TODO: Update when backend provides proper lesson-module relationships
      setModuleLessons(lessons);
    }
  }, [modules, lessons, params.module_id]);

  if (isLoading) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-gray-600">Loading modules...</p>
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
            <p className="text-red-600">Error loading modules: {error}</p>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  if (!currentModule) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-gray-600">Module not found</p>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-8 max-w-7xl">
        {/* Back Button */}
        <div className="mb-6">
          <Button variant="link" asChild className="flex items-center gap-2 w-fit">
            <Link href="/">
              <ArrowLeft className="h-4 w-4" />
              Back to Home
            </Link>
          </Button>
        </div>
        
        {/* Module Header */}
        <div className="mb-8">
          <div className="flex items-start gap-6">
            {/* Icon */}
            <div className="bg-secondary p-4 rounded-xl flex-shrink-0">
              <BookOpen className="h-8 w-8 text-primary" />
            </div>
            
            {/* Content */}
            <div className="flex-1 min-w-0">
              <h1 className="text-3xl font-bold text-gray-900 mb-2">
                {currentModule.module_name}
              </h1>
              <p className="text-gray-600 text-lg mb-4">
                {currentModule.description}
              </p>
              <div className="flex items-center gap-4">
                <Badge variant="secondary" className="text-sm px-3 py-1">
                  {moduleLessons.length} lesson{moduleLessons.length !== 1 ? 's' : ''}
                </Badge>
                <Button asChild variant="default" size="sm">
                  <Link href={`/modules/${params.module_id}/practice`}>
                    <Play className="h-4 w-4 mr-2" />
                    Start Practice
                  </Link>
                </Button>
              </div>
            </div>
          </div>
        </div>

        {/* Lessons Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {moduleLessons.map((lesson, index) => (
                <Card key={lesson.lessonId} className="hover:shadow-lg transition-shadow flex flex-col">
                  <CardHeader className='gap-2'>
                    <div className="flex items-center justify-between">
                      <Badge variant="outline" className="text-xs">
                        Lesson {index + 1}
                      </Badge>
                    </div>
                    <CardTitle className="text-lg font-bold leading-tight">
                      {lesson.lessonName}
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="flex flex-col flex-1 justify-between -mt-4">
                    <div className="text-gray-600 mb-4 text-sm leading-relaxed prose prose-sm max-w-none">
                      <div className="text-gray-600 text-sm leading-relaxed">
                        {(() => {
                          const text = lesson.shortDescription || lesson.lessonName;
                          const truncatedText = truncateText(text, 120);
                          
                          // Simple markdown rendering for basic formatting
                          const formattedText = truncatedText
                            .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>') // Bold
                            .replace(/\*(.*?)\*/g, '<em>$1</em>') // Italic
                            .replace(/`(.*?)`/g, '<code class="bg-gray-100 px-1 py-0.5 rounded text-xs">$1</code>') // Inline code
                            .replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2" class="text-blue-600 hover:underline">$1</a>'); // Links
                          
                          return (
                            <div 
                              dangerouslySetInnerHTML={{ __html: formattedText }}
                              className="prose prose-sm max-w-none"
                            />
                          );
                        })()}
                      </div>
                    </div>
                    <Button 
                      asChild 
                      variant={"secondary"}
                      className=""
                    >
                      <Link href={`/modules/${params.module_id}/lessons/${lesson.lessonId}`}>
                        Start Lesson
                      </Link>
                    </Button>
                  </CardContent>
                </Card>
              ))}
            </div>
            {moduleLessons.length === 0 && (
              <div className="text-center py-12">
                <p className="text-gray-600">No lessons available for this module yet.</p>
              </div>
            )}
        </div>
      </ProtectedRoute>
    );
}

