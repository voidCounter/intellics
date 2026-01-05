'use client';

import { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import {
  BookOpen,
  Play,
  Search,
  GraduationCap,
  Target,
  Zap
} from 'lucide-react';
import Link from 'next/link';
import { useHomeData } from '@/hooks/useHomeData';
import { Module } from '@/types/api';
import { ProtectedRoute } from '@/components/auth/protected-route';

export default function ModulesPage() {
  const { modules, isLoading, error, loadModules } = useHomeData();
  const [searchQuery, setSearchQuery] = useState('');

  useEffect(() => {
    loadModules();
  }, [loadModules]);

  // Filter modules based on search query
  const filteredModules = modules.filter(module =>
    module.module_name.toLowerCase().includes(searchQuery.toLowerCase()) ||
    module.description.toLowerCase().includes(searchQuery.toLowerCase())
  );

  if (isLoading) {
    return (
      <ProtectedRoute>
        <div className="min-h-screen bg-gradient-to-br from-gray-900 to-gray-950 text-gray-100">
          <div className="container mx-auto px-4 py-12">
            <div className="text-center mb-12">
              <h1 className="text-4xl font-bold mb-4">Learning Modules</h1>
              <p className="text-gray-400 max-w-2xl mx-auto">
                Explore our collection of computer science modules designed for adaptive learning
              </p>
            </div>

            <div className="max-w-md mx-auto mb-8">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-4 w-4" />
                <input
                  type="text"
                  placeholder="Search modules..."
                  className="w-full bg-gray-800 border border-gray-700 rounded-lg pl-10 pr-4 py-3 text-gray-100 focus:outline-none focus:ring-2 focus:ring-primary/50"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {[...Array(6)].map((_, index) => (
                <Card key={index} className="bg-gray-800/50 border-gray-700 animate-pulse">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div className="bg-gray-700 p-3 rounded-lg flex-shrink-0">
                        <BookOpen className="h-6 w-6 text-gray-400" />
                      </div>
                    </div>
                    <CardTitle className="text-xl h-6 bg-gray-700 rounded w-3/4"></CardTitle>
                    <CardDescription className="h-4 bg-gray-700 rounded w-full mt-2"></CardDescription>
                    <CardDescription className="h-4 bg-gray-700 rounded w-5/6 mt-2"></CardDescription>
                  </CardHeader>
                  <CardContent>
                    <div className="h-4 bg-gray-700 rounded w-full mb-4"></div>
                    <div className="h-10 bg-gray-700 rounded-lg w-full"></div>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  if (error) {
    return (
      <ProtectedRoute>
        <div className="min-h-screen bg-gradient-to-br from-gray-900 to-gray-950 text-gray-100 flex items-center justify-center">
          <div className="text-center">
            <h2 className="text-2xl font-bold mb-4">Error Loading Modules</h2>
            <p className="text-gray-400 mb-6">{error}</p>
            <Button onClick={() => loadModules()}>Retry</Button>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  return (
    <ProtectedRoute>
      <div className="min-h-screen bg-gradient-to-br from-gray-900 to-gray-950 text-gray-100">
        <div className="container mx-auto px-4 py-12">
          <div className="text-center mb-12">
            <div className="inline-flex items-center gap-2 mb-4 px-4 py-2 bg-primary/10 rounded-full border border-primary/20">
              <GraduationCap className="h-4 w-4 text-primary" />
              <span className="text-sm font-medium text-primary">Learning Path</span>
            </div>
            <h1 className="text-4xl font-bold mb-4">Learning Modules</h1>
            <p className="text-gray-400 max-w-2xl mx-auto">
              Explore our collection of computer science modules designed for adaptive learning.
              Each module adapts to your pace and provides personalized feedback.
            </p>
          </div>

          <div className="max-w-md mx-auto mb-8">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-4 w-4" />
              <input
                type="text"
                placeholder="Search modules..."
                className="w-full bg-gray-800 border border-gray-700 rounded-lg pl-10 pr-4 py-3 text-gray-100 focus:outline-none focus:ring-2 focus:ring-primary/50"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
              />
            </div>
          </div>

          {filteredModules.length === 0 ? (
            <div className="text-center py-12">
              <h3 className="text-xl font-medium mb-2">No modules found</h3>
              <p className="text-gray-400">
                {searchQuery ? `No modules match your search for "${searchQuery}"` : 'No modules are available at this time'}
              </p>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {filteredModules.map((module) => (
                <Card key={module.module_id} className="bg-gray-800/50 border-gray-700 hover:border-primary/30 transition-all duration-300 group">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div className="bg-primary/10 p-3 rounded-lg flex-shrink-0 group-hover:bg-primary/20 transition-colors">
                        <BookOpen className="h-6 w-6 text-primary" />
                      </div>
                      <Badge variant="secondary" className="text-xs">
                        {module.module_id.substring(0, 8)}...
                      </Badge>
                    </div>
                    <CardTitle className="text-xl">{module.module_name}</CardTitle>
                    <CardDescription className="text-gray-400">
                      {module.description}
                    </CardDescription>
                  </CardHeader>
                  <CardContent>
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-2 text-sm text-gray-400">
                        <Target className="h-4 w-4" />
                        <span>Adaptive Learning</span>
                      </div>
                      <Button asChild>
                        <Link href={`/modules/${module.module_id}`}>
                          <Play className="h-4 w-4 mr-2" />
                          Start Learning
                        </Link>
                      </Button>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </div>
      </div>
    </ProtectedRoute>
  );
}