"use client";

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { BookOpen, ArrowLeft } from 'lucide-react';
import { useAppStore } from '@/lib/store';
import { Module, Lesson } from '@/lib/store';

export default function ModulePageClient() {
  const params = useParams();
  const { modules, lessons, loadData } = useAppStore();
  const [currentModule, setCurrentModule] = useState<Module | null>(null);
  const [moduleLessons, setModuleLessons] = useState<Lesson[]>([]);

  useEffect(() => {
    loadData();
  }, [loadData]);

  useEffect(() => {
    if (modules.length > 0 && params.module_id) {
      const moduleId = parseInt(params.module_id as string);
      const module = modules.find(m => m.module_id === moduleId);
      setCurrentModule(module || null);
      const filteredLessons = lessons.filter(l => l.module_id === moduleId);
      setModuleLessons(filteredLessons);
    }
  }, [modules, lessons, params.module_id]);

  if (!currentModule) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center">
          <p className="text-gray-600">Loading module...</p>
        </div>
      </div>
    );
  }

  return (
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
      {/* Module Header */}
      <div className="mb-8">
        <div className="flex items-center gap-3 mb-4">
          <div className="bg-blue-600 p-3 rounded-lg">
            <BookOpen className="h-6 w-6 text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold text-gray-900">{currentModule.module_name}</h1>
            <p className="text-gray-600 mt-1">{currentModule.description}</p>
          </div>
        </div>
        <Badge variant="secondary" className="text-sm">
          {moduleLessons.length} lesson{moduleLessons.length !== 1 ? 's' : ''} available
        </Badge>
      </div>
      {/* Lessons Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {moduleLessons.map((lesson, index) => (
          <Card key={lesson.lesson_id} className="hover:shadow-lg transition-shadow">
            <CardHeader>
              <div className="flex items-center justify-between">
                <Badge variant="outline" className="text-xs">
                  Lesson {index + 1}
                </Badge>
              </div>
              <CardTitle className="text-lg leading-tight">
                {lesson.lesson_name}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-gray-600 mb-4 text-sm leading-relaxed">
                {lesson.description}
              </p>
              <Button asChild className="w-full">
                <Link href={`/lessons/${lesson.lesson_id}`}>
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
  );
}

