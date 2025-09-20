'use client';

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { KCMastery } from '@/types/api';

interface KCMasteryChartProps {
  kcMasteryData: KCMastery[];
}

export function KCMasteryChart({ kcMasteryData }: KCMasteryChartProps) {
  if (!kcMasteryData || kcMasteryData.length === 0) {
    return (
      <Card className="border-0 shadow-sm">
        <CardHeader className="pb-4">
          <CardTitle className="text-xl font-semibold text-gray-900">Knowledge Component Mastery</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="text-center py-16">
            <p className="text-gray-500">No mastery data available yet.</p>
          </div>
        </CardContent>
      </Card>
    );
  }

  // Sort by mastery level (highest first)
  const sortedData = [...kcMasteryData].sort((a, b) => b.pmastery - a.pmastery);

  return (
    <Card className="border-0 shadow-sm">
      <CardHeader className="pb-4">
        <CardTitle className="text-xl font-semibold text-gray-900">Knowledge Component Mastery</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-3">
          {sortedData.map((kc) => {
            const masteryPercentage = Math.round(kc.pmastery * 100);
            
            const getMasteryColor = (percentage: number) => {
              if (percentage >= 80) return 'bg-emerald-500';
              if (percentage >= 60) return 'bg-blue-500';
              if (percentage >= 40) return 'bg-amber-500';
              return 'bg-gray-400';
            };

            const getMasteryStatus = (percentage: number) => {
              if (percentage >= 80) return 'Mastered';
              if (percentage >= 60) return 'Proficient';
              if (percentage >= 40) return 'Learning';
              return 'Beginner';
            };

            return (
              <div key={kc.kcId} className="flex items-center justify-between p-4 bg-white border border-gray-100 rounded-lg hover:border-gray-200 transition-colors">
                {/* KC Name */}
                <div className="flex-1 min-w-0 pr-4">
                  <h3 className="font-medium text-gray-900 truncate">
                    {kc.kcName || `KC ${kc.kcId}`}
                  </h3>
                </div>
                
                {/* Mastery Status */}
                <div className="flex items-center gap-4">
                  <div className="text-right">
                    <div className="text-sm font-medium text-gray-900">
                      {masteryPercentage}%
                    </div>
                    <div className="text-xs text-gray-500">
                      {getMasteryStatus(masteryPercentage)}
                    </div>
                  </div>
                  
                  {/* Progress Bar */}
                  <div className="w-24">
                    <div className="w-full bg-gray-200 rounded-full h-2">
                      <div
                        className={`h-2 rounded-full transition-all duration-300 ${getMasteryColor(masteryPercentage)}`}
                        style={{ width: `${masteryPercentage}%` }}
                      />
                    </div>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
        
        {/* Summary Stats */}
        <div className="mt-8 pt-6 border-t border-gray-100">
          <div className="grid grid-cols-3 gap-6">
            <div className="text-center">
              <div className="text-2xl font-semibold text-emerald-600">
                {kcMasteryData.filter(kc => kc.pmastery >= 0.8).length}
              </div>
              <div className="text-sm text-gray-600">Mastered</div>
            </div>
            
            <div className="text-center">
              <div className="text-2xl font-semibold text-blue-600">
                {kcMasteryData.filter(kc => kc.pmastery >= 0.6 && kc.pmastery < 0.8).length}
              </div>
              <div className="text-sm text-gray-600">Proficient</div>
            </div>
            
            <div className="text-center">
              <div className="text-2xl font-semibold text-amber-600">
                {kcMasteryData.filter(kc => kc.pmastery < 0.6).length}
              </div>
              <div className="text-sm text-gray-600">Learning</div>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
