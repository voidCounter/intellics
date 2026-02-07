'use client';

import React from 'react';
import { 
  X, 
  BookOpen, 
  Target, 
  ArrowRight, 
  Zap, 
  Calendar,
  MessageSquare,
  Trophy,
  Sparkles,
  Lightbulb,
  ArrowUpRight
} from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { Badge } from '@/components/ui/badge';
import Link from 'next/link';
import { motion, AnimatePresence } from 'framer-motion';

const MotionDiv = motion.div as any;
const MotionAnimatePresence = AnimatePresence as any;

interface KCDetailPanelProps {
  selectedNode: any | null;
  recommendedNode: any | null;
  onClose: () => void;
  onSelectRecommended: (id: string) => void;
}

export function KCDetailPanel({ 
  selectedNode, 
  recommendedNode, 
  onClose, 
  onSelectRecommended 
}: KCDetailPanelProps) {
  if (!selectedNode && !recommendedNode) return null;

  const isRecommendation = !selectedNode && recommendedNode;
  const activeNode = selectedNode || recommendedNode;
  const data = activeNode.data;
  const mastery = data.pmastery || 0;
  const masteryPercentage = Math.round(mastery * 100);
  
  const lastUpdated = data.updatedAt 
    ? new Date(data.updatedAt).toLocaleDateString('en-US', { 
        month: 'short', 
        day: 'numeric', 
        year: 'numeric' 
      })
    : 'Never';

  return (
    <MotionAnimatePresence>
      <MotionDiv
        key={selectedNode ? `kc-${selectedNode.id}` : 'recommendation'}
        initial={{ x: '100%' }}
        animate={{ x: 0 }}
        exit={{ x: '100%' }}
        transition={{ type: 'spring', damping: 25, stiffness: 120 }}
        className="absolute right-0 top-0 h-full w-80 md:w-96 bg-white/95 backdrop-blur-md border-l border-slate-200 shadow-2xl z-[100] flex flex-col"
      >
        {/* Header */}
        <div className="p-6 border-b border-slate-100 flex items-start justify-between">
          <div className="space-y-1">
            {isRecommendation ? (
              <Badge variant="secondary" className="text-[10px] uppercase tracking-wider font-bold text-amber-600 bg-amber-50 border-amber-100 mb-2 gap-1 animate-pulse">
                <Sparkles className="h-3 w-3" /> Next Best Action
              </Badge>
            ) : (
              <Badge variant="outline" className="text-[10px] uppercase tracking-wider font-bold text-blue-600 bg-blue-50 border-blue-100 mb-2">
                Knowledge Component
              </Badge>
            )}
            <h2 className="text-xl font-bold text-slate-900 leading-tight">
              {data.label}
            </h2>
          </div>
          {selectedNode && (
            <Button 
              variant="ghost" 
              onClick={onClose}
              className="rounded-full hover:bg-slate-100 text-slate-500 w-10 h-10 flex-shrink-0 aspect-square flex items-center justify-center p-0 transition-all"
            >
              <X className="h-5 w-5" />
            </Button>
          )}
        </div>

        {/* Content */}
        <div className="flex-1 overflow-y-auto p-6 space-y-8">
          
          {isRecommendation && (
            <div className="bg-blue-600 rounded-2xl p-6 text-white space-y-4 shadow-xl shadow-blue-200">
              <div className="flex items-center gap-2 font-bold text-blue-100 uppercase tracking-widest text-[10px]">
                <Lightbulb className="h-4 w-4" /> AI Coach Recommendation
              </div>
              <p className="text-sm font-medium leading-relaxed">
                You're ready to master this! Based on your progress in prerequisites, we suggest focusing here next.
              </p>
              <Button 
                onClick={() => onSelectRecommended(recommendedNode.id)}
                className="w-full bg-white text-blue-600 hover:bg-blue-50 font-bold py-5 rounded-xl transition-all"
              >
                Focus on this Skill <ArrowUpRight className="ml-2 h-4 w-4" />
              </Button>
            </div>
          )}

          {/* Mastery Section */}
          <div className="bg-slate-50/50 rounded-2xl p-5 border border-slate-100 space-y-4">
            <div className="flex items-center justify-between">
              <span className="text-sm font-bold text-slate-700 flex items-center gap-2">
                <Target className="h-4 w-4 text-blue-500" /> Current Mastery
              </span>
              <span className="text-lg font-black text-blue-600">
                {masteryPercentage}%
              </span>
            </div>
            <Progress value={masteryPercentage} className="h-2.5 bg-slate-200" />
            <p className="text-[11px] text-slate-500 flex items-center gap-1.5">
              <Calendar className="h-3 w-3" /> {isRecommendation ? 'Status updated' : 'Last engagement'}: {lastUpdated}
            </p>
          </div>

          {/* Description */}
          <div className="space-y-3">
            <h3 className="text-sm font-bold text-slate-800 uppercase tracking-widest flex items-center gap-2">
              <MessageSquare className="h-4 w-4 text-slate-400" /> About
            </h3>
            <p className="text-sm text-slate-600 leading-relaxed">
              {data.kcDescription || "No description available for this knowledge component."}
            </p>
          </div>

          {/* Lessons Section */}
          <div className="space-y-4">
            <h3 className="text-sm font-bold text-slate-800 uppercase tracking-widest flex items-center gap-2">
              <BookOpen className="h-4 w-4 text-slate-400" /> Related Lessons
            </h3>
            
            <div className="space-y-2">
              {data.linkedLessons && data.linkedLessons.length > 0 ? (
                data.linkedLessons.map((lesson: any) => (
                  <Link 
                    key={lesson.lesson_id}
                    href={`/modules/${lesson.module_id}/lessons/${lesson.lesson_id}`}
                    className="group block p-4 rounded-xl border border-slate-100 hover:border-blue-200 hover:bg-blue-50/30 transition-all duration-200"
                  >
                    <div className="flex items-center justify-between">
                      <div className="space-y-1">
                        <div className="text-sm font-bold text-slate-800 group-hover:text-blue-700 transition-colors">
                          {lesson.lesson_name}
                        </div>
                        <div className="text-[10px] text-slate-500 font-medium tracking-tight text-slate-400">
                          TARGET: {Math.round(lesson.target_mastery * 100)}%
                        </div>
                      </div>
                      <ArrowRight className="h-4 w-4 text-slate-300 group-hover:text-blue-500 group-hover:translate-x-1 transition-all" />
                    </div>
                  </Link>
                ))
              ) : (
                <div className="text-center py-6 border-2 border-dashed border-slate-100 rounded-xl">
                  <p className="text-xs text-slate-400">No lessons directly linked.</p>
                </div>
              )}
            </div>
          </div>
        </div>
      </MotionDiv>
    </MotionAnimatePresence>
  );
}
