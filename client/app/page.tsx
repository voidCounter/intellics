'use client';

import { useEffect } from 'react';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useAuthStore, useMainStore } from '@/lib/stores';
import { useHomeData } from '@/hooks/useHomeData';
import { toast } from "sonner";
import { ProtectedRoute } from '@/components/auth/protected-route';

export default function Home() {
  const { modules, isLoading, error, loadModules } = useHomeData();
  const { isAuthenticated } = useAuthStore();
  const { resetAllStores } = useMainStore();

  useEffect(() => {
    // We only load data if the user is authenticated
    if (isAuthenticated) {
      loadModules();
    }
  }, [loadModules, isAuthenticated]);

  const handleReset = () => {
    resetAllStores();
    toast.success("All data has been reset successfully!");
  };

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
            <Button 
              onClick={() => loadModules()} 
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

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-8 max-w-7xl">
        <div className="flex justify-end mb-4">
          <Button
            variant="destructive"
            onClick={handleReset}
            className="flex items-center gap-2"
          >
            Reset Data
          </Button>
        </div>
        {/* Modules Section */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {modules.map((module) => (
            <Card key={module.module_id} className="hover:shadow-lg transition-shadow">
              <CardHeader>
                <CardTitle className="text-xl">{module.module_name}</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-gray-600 mb-4">{module.description}</p>
                <Button asChild className="w-full">
                  <Link href={`/modules/${module.module_id}`}>
                    Start Learning
                  </Link>
                </Button>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </ProtectedRoute>
  );
}