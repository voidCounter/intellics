'use client';

import { useEffect } from 'react';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Brain, BookOpen, Target, Users } from 'lucide-react';
import { useAppStore } from '@/lib/store';
import { toast } from "sonner";

export default function Home() {
  const { modules, loadData } = useAppStore();
  const resetStore = useAppStore(state => state.resetStore);

  useEffect(() => {
    loadData();
  }, [loadData]);

  const handleReset = () => {
    resetStore();
    toast.success("All data has been reset successfully!");
  };

  return (
    <div className="container mx-auto px-4 py-8">
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
  );
}