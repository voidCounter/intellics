'use client';

import React from 'react';
import { useUserKCMastery } from '@/hooks/useUserKCMastery';
import { useHomeData } from '@/hooks/useHomeData';
import { Card, CardContent } from '@/components/ui/card';
import { Brain, BookOpen, Target, Loader2 } from 'lucide-react';

export function ProfileStats() {
  const { data: masteryData, isLoading: masteryLoading } = useUserKCMastery();
  const { modules, isLoading: modulesLoading } = useHomeData();

  if (masteryLoading || modulesLoading) {
    return (
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {[1, 2, 3].map((i) => (
          <Card key={i} className="border-0 shadow-sm bg-white/50 backdrop-blur-sm animate-pulse h-24" />
        ))}
      </div>
    );
  }

  const totalMastery = masteryData?.reduce((acc, curr) => acc + curr.pmastery, 0) || 0;
  const avgMastery = masteryData?.length ? Math.round((totalMastery / masteryData.length) * 100) : 0;
  const kcCount = masteryData?.length || 0;
  const moduleCount = modules?.length || 0;

  const stats = [
    {
      label: 'Overall Mastery',
      value: `${avgMastery}%`,
      icon: Target,
      color: 'text-emerald-500',
      bgColor: 'bg-emerald-50',
      description: 'Average across all components'
    },
    {
      label: 'Skills Tracked',
      value: kcCount,
      icon: Brain,
      color: 'text-blue-500',
      bgColor: 'bg-blue-50',
      description: 'Knowledge components'
    },
    {
      label: 'Learning Modules',
      value: moduleCount,
      icon: BookOpen,
      color: 'text-indigo-500',
      bgColor: 'bg-indigo-50',
      description: 'Available for study'
    }
  ];

  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
      {stats.map((stat, index) => (
        <div key={index} className="p-6 border border-slate-200 bg-white rounded-xl">
          <div className="flex items-start justify-between">
            <div className="space-y-1">
              <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">
                {stat.label}
              </p>
              <h3 className="text-2xl font-bold text-slate-900 leading-none">{stat.value}</h3>
              <p className="text-[10px] text-slate-400 font-medium">{stat.description}</p>
            </div>
            <stat.icon className="h-4 w-4 text-slate-400" />
          </div>
        </div>
      ))}
    </div>
  );
}
