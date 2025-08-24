'use client';

import React, { useState, useEffect, useCallback, useRef } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { HelpCircle, Lightbulb, ArrowRight } from 'lucide-react';
import { Question, Scaffold } from '@/types/api';
import { ScaffoldCard } from './scaffold-card';
import { toast } from 'sonner';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from "@/components/ui/accordion";
import { useLearningStore } from '@/lib/stores';
import { evaluateAnswerWithLLM } from '@/services/api';

import { logger } from '@/lib/utils';
interface QuestionCardProps {
  question: Question;
  onSubmit: (answer: string, isCorrect: boolean, aiEvaluation?: { correctnessScore: number; feedback: string; analysis: string }) => void;
  onHint: (level: number) => void;
  onScaffold: () => void;
  onScaffoldUsage: (scaffoldId: string) => void;
  onScaffoldSubmit: (scaffoldId: string, answer: string, isCorrect: boolean) => void;
  onSkip: () => void;
  onContinue: () => void;
  usedHints: Set<string>;
  questionNumber: number;
  totalQuestions: number;
}

// Custom hook for question state management
function useQuestionState(questionId: string) {
  const [state, setState] = useState({
    selectedAnswer: '',
    writtenAnswer: '',
    showHint1: false,
    showHint2: false,
    showExplanation: false,
    lastAnswer: '',
    lastIsCorrect: false,
    llmFeedback: null as string | null,
    llmAnalysis: null as string | null,
    isEvaluating: false,
    showScaffoldContainer: false,
    activeScaffoldValue: undefined as string | undefined,
    unlockedScaffoldIndex: 0,
    scaffoldsUnlocked: false,
    viewedScaffolds: new Set<string>()
  });

  const questionStateKey = `question_${questionId}_state`;
  const previousQuestionIdRef = useRef<string | null>(null);

  const saveState = useCallback(() => {
    sessionStorage.setItem(questionStateKey, JSON.stringify({
      ...state,
      viewedScaffolds: Array.from(state.viewedScaffolds)
    }));
  }, [state, questionStateKey]);

  const loadState = useCallback(() => {
    try {
      const saved = sessionStorage.getItem(questionStateKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        setState(prev => ({
          ...prev,
          ...parsed,
          viewedScaffolds: new Set(parsed.viewedScaffolds || [])
        }));
      }
    } catch (error) {
      logger.warn('Failed to load question state:', error);
    }
  }, [questionStateKey, questionId]);

  const updateState = useCallback((updates: Partial<typeof state>) => {
    setState(prev => {
      const newState = { ...prev, ...updates };
      // Auto-save state changes
      setTimeout(() => {
        const stateToSave = {
          ...newState,
          viewedScaffolds: Array.from(newState.viewedScaffolds)
        };
        sessionStorage.setItem(questionStateKey, JSON.stringify(stateToSave));
      }, 0);
      return newState;
    });
  }, [questionStateKey, questionId]);

  // Simple: reset answer fields when question changes
  useEffect(() => {
    if (previousQuestionIdRef.current && previousQuestionIdRef.current !== questionId) {
      logger.log('🔄 Question changed from', previousQuestionIdRef.current, 'to', questionId, '- resetting answer fields');
      setState(prev => ({
        ...prev,
        selectedAnswer: '',
        writtenAnswer: '',
        showExplanation: false,
        lastAnswer: '',
        lastIsCorrect: false,
        llmFeedback: null,
        llmAnalysis: null,
        isEvaluating: false,
        activeScaffoldValue: undefined
      }));
    }
    previousQuestionIdRef.current = questionId;
    loadState();
  }, [questionId, loadState]);

  // Clean up on page unload
  useEffect(() => {
    const handleBeforeUnload = () => {
      const keysToRemove = [];
      for (let i = 0; i < sessionStorage.length; i++) {
        const key = sessionStorage.key(i);
        if (key && key.startsWith('question_') && key.includes('_state')) {
          keysToRemove.push(key);
        }
      }
      keysToRemove.forEach(key => sessionStorage.removeItem(key));
    };

    window.addEventListener('beforeunload', handleBeforeUnload);
    return () => {
      window.removeEventListener('beforeUnload', handleBeforeUnload);
    };
  }, []);

  return { state, updateState, saveState };
}

// Custom hook for answer submission logic
function useAnswerSubmission(question: Question, onSubmit: (answer: string, isCorrect: boolean, aiEvaluation?: { correctnessScore: number; feedback: string; analysis: string }) => void) {
  const [isEvaluating, setIsEvaluating] = useState(false);

  const submitAnswer = useCallback(async (answer: string) => {
    if (!answer.trim()) return { isCorrect: false, feedback: null, analysis: null };

    let isCorrect = false;
    let feedback: string | null = null;
    let analysis: string | null = null;
    let correctnessScore: number = 0;

    if (question.type === 'MULTIPLE_CHOICE') {
      isCorrect = answer === question.correct_option_key;
    } else if (question.type === 'WRITTEN') {
      setIsEvaluating(true);
      try {
        const llmResult = await evaluateAnswerWithLLM(
          question.question_text,
          question.correct_answer_text,
          answer,
          question.answer_explanation
        );
        isCorrect = llmResult.isCorrect;
        feedback = llmResult.feedback;
        analysis = llmResult.detailedAnalysis;
        correctnessScore = llmResult.correctnessScore;
      } catch (error) {
        logger.error('LLM evaluation failed:', error);
        isCorrect = answer.toLowerCase().trim() === question.correct_answer_text.toLowerCase().trim();
        toast.info("LLM evaluation unavailable, using exact matching.");
      } finally {
        setIsEvaluating(false);
      }
    }

    const truncatedAnswer = answer.length > 2000 ? answer.substring(0, 2000) + '...' : answer;
    
    // Only pass AI evaluation data if we have it
    if (question.type === 'WRITTEN' && feedback && analysis) {
      onSubmit(truncatedAnswer, isCorrect, { 
        correctnessScore, 
        feedback, 
        analysis 
      });
    } else {
      onSubmit(truncatedAnswer, isCorrect);
    }

    return { isCorrect, feedback, analysis };
  }, [question, onSubmit]);

  return { submitAnswer, isEvaluating };
}

// Hint component
function HintDisplay({ hint, isVisible, title }: { hint: string; isVisible: boolean; title: string }) {
  if (!isVisible) return null;
  
  return (
    <div className="p-3 bg-blue-50 border border-blue-200 rounded-md mt-2">
      <div className="text-sm text-blue-800">
        <strong>{title}:</strong> 
        <div className="prose prose-sm max-w-none mt-1 [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm [&_code]:text-gray-800 [&_pre]:bg-gray-50 [&_pre]:border [&_pre]:border-gray-200 [&_pre]:p-3 [&_pre]:rounded [&_pre]:overflow-x-auto [&_pre_code]:bg-transparent [&_pre_code]:text-gray-800 [&_pre_code]:px-0 [&_pre_code]:py-0 [&_pre_code]:rounded-none">
          <ReactMarkdown remarkPlugins={[remarkGfm]}>{hint}</ReactMarkdown>
        </div>
      </div>
    </div>
  );
}

// Answer explanation component
function AnswerExplanation({ 
  isVisible, 
  isCorrect, 
  answer, 
  feedback, 
  analysis, 
  question, 
  onClose 
}: {
  isVisible: boolean;
  isCorrect: boolean;
  answer: string;
  feedback: string | null;
  analysis: string | null;
  question: Question;
  onClose: () => void;
}) {
  if (!isVisible) return null;

  return (
    <div className="mt-4 p-4 bg-gray-50 border border-gray-200 rounded-lg relative">
      <Button variant="ghost" size="sm" onClick={onClose} className="absolute top-2 right-2 h-6 w-6 p-0">✕</Button>
      
      <div className="mb-3">
        <h4 className="font-semibold text-gray-900 mb-2">
          {isCorrect ? '✅ Correct!' : '❌ Incorrect'}
        </h4>
        <p className="text-sm text-gray-600 mb-3">
          Your answer: <span className="font-mono bg-gray-100 px-2 py-1 rounded">{answer}</span>
        </p>
      </div>

      {question.type === 'MULTIPLE_CHOICE' && answer && (
        <div className="mb-3">
          <h5 className="font-medium text-gray-800 mb-2">Explanation for your choice:</h5>
          <div className="text-sm text-gray-700 bg-white p-3 rounded border">
            {(() => {
              const selectedOption = question.options?.find(opt => opt.option_key === answer);
              if (selectedOption?.option_explanation) {
                return (
                  <div className="prose prose-sm max-w-none [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm [&_code]:text-gray-800 [&_pre]:bg-gray-50 [&_pre]:border [&_pre]:border-gray-200 [&_pre]:p-3 [&_pre]:rounded [&_pre]:overflow-x-auto [&_pre_code]:bg-transparent [&_pre_code]:text-gray-800 [&_pre_code]:px-0 [&_pre_code]:py-0 [&_pre_code]:rounded-none">
                    <ReactMarkdown remarkPlugins={[remarkGfm]}>{selectedOption.option_explanation}</ReactMarkdown>
                  </div>
                );
              }
              return <span className="text-gray-500 italic">No explanation available for this option.</span>;
            })()}
          </div>
        </div>
      )}

      {question.type === 'WRITTEN' && feedback && (
        <div className="mb-3">
          <h5 className="font-medium text-gray-800 mb-2">AI Feedback:</h5>
          <div className="text-sm text-gray-700 bg-white p-3 rounded border">
            <div className="prose prose-sm max-w-none [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm [&_code]:text-gray-800 [&_pre]:bg-gray-50 [&_pre]:border [&_pre]:border-gray-200 [&_pre]:p-3 [&_pre]:rounded [&_pre]:overflow-x-auto [&_pre_code]:bg-transparent [&_pre_code]:text-gray-800 [&_pre_code]:px-0 [&_pre_code]:py-0 [&_pre_code]:rounded-none">
              <ReactMarkdown remarkPlugins={[remarkGfm]}>{feedback}</ReactMarkdown>
            </div>
          </div>
        </div>
      )}

      {question.type === 'WRITTEN' && isCorrect && 'answer_explanation' in question && question.answer_explanation && (
        <div className="mb-3">
          <h5 className="font-medium text-gray-800 mb-2">Answer Explanation:</h5>
          <div className="text-sm text-gray-700 bg-white p-3 rounded border">
            <div className="prose prose-sm max-w-none [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm [&_code]:text-gray-800 [&_pre]:bg-gray-50 [&_pre]:border [&_pre]:border-gray-200 [&_pre]:p-3 [&_pre]:rounded [&_pre]:overflow-x-auto [&_pre_code]:bg-transparent [&_pre_code]:text-gray-800 [&_pre_code]:px-0 [&_pre_code]:py-0 [&_pre_code]:rounded-none">
              <ReactMarkdown remarkPlugins={[remarkGfm]}>{question.answer_explanation}</ReactMarkdown>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export function QuestionCard({
  question,
  onSubmit,
  onHint,
  onScaffold,
  onScaffoldUsage,
  onScaffoldSubmit,
  onSkip,
  onContinue,
  usedHints,
  questionNumber,
  totalQuestions
}: QuestionCardProps) {
  const { currentLesson } = useLearningStore();
  const { state, updateState } = useQuestionState(question.question_id);
  const { submitAnswer, isEvaluating } = useAnswerSubmission(question, onSubmit);

  // Debug: Log when component renders
  logger.log('🔄 QuestionCard rendered for question:', question.question_id, 'at:', new Date().toISOString());

  const scaffolds = question.scaffolds || [];
  const allScaffoldsCompleted = scaffolds.length > 0 && state.unlockedScaffoldIndex >= scaffolds.length;
  
  // Hint logic: show hint if it's been used OR if it's currently visible
  const hint1Used = usedHints.has(`${question.question_id}-1`);
  const hint2Used = usedHints.has(`${question.question_id}-2`);
  const shouldShowHint1 = hint1Used || state.showHint1;
  const shouldShowHint2 = hint2Used || state.showHint2;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const answer = question.type === 'MULTIPLE_CHOICE' ? state.selectedAnswer : state.writtenAnswer;
    
    const result = await submitAnswer(answer);
    
    updateState({
      lastAnswer: answer,
      lastIsCorrect: result.isCorrect,
      llmFeedback: result.feedback,
      llmAnalysis: result.analysis,
      showExplanation: true
    });

    if (result.isCorrect) {
      toast.success("Correct! Great job! Click Continue to see the next question.");
    } else {
      toast.error("Incorrect. That's not quite right. Try again!");
    }
  };

  const handleHint = (level: number) => {
    onHint(level);
    if (level === 1) updateState({ showHint1: true });
    if (level === 2) updateState({ showHint2: true });
  };

  const handleStartScaffold = () => {
    if (!state.scaffoldsUnlocked) {
      onScaffold();
      updateState({ scaffoldsUnlocked: true });
    }
    updateState({ showScaffoldContainer: true, activeScaffoldValue: undefined, unlockedScaffoldIndex: 0 });
  };

  const handleScaffoldSubmit = (scaffoldData: Scaffold, answer: string, isCorrect: boolean, scaffoldIndex: number) => {
    onScaffoldSubmit(scaffoldData.scaffoldId, answer, isCorrect);
    if (isCorrect) {
      updateState({ unlockedScaffoldIndex: Math.max(state.unlockedScaffoldIndex, scaffoldIndex + 1) });
    }
  };

  const handleScaffoldView = (scaffoldId: string) => {
    if (!state.viewedScaffolds.has(scaffoldId)) {
      onScaffoldUsage(scaffoldId);
      const newViewedScaffolds = new Set(state.viewedScaffolds).add(scaffoldId);
      updateState({ viewedScaffolds: newViewedScaffolds });
    }
  };

  const handleContinue = () => {
    updateState({ 
      showExplanation: false, 
      showHint1: false, 
      showHint2: false, 
      showScaffoldContainer: false 
    });
    if (state.lastIsCorrect) onContinue();
  };

  const handleNextQuestion = () => {
    updateState({ 
      showExplanation: false, 
      showHint1: false, 
      showHint2: false, 
      showScaffoldContainer: false 
    });
    onContinue();
  };

  const canSubmit = question.type === 'MULTIPLE_CHOICE' 
    ? state.selectedAnswer !== '' 
    : state.writtenAnswer.trim() !== '';

  if (!question) {
    return (
      <Card className="w-full max-w-2xl mx-auto">
        <CardContent className="flex items-center justify-center p-8">
          <p className="text-gray-600">Loading question...</p>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <div className="flex justify-between items-start">
          <div className="flex-1">
            <div className="flex items-center gap-2 mb-2">
              <Badge variant="outline">Question {questionNumber}</Badge>
            </div>
            <CardTitle className="text-lg leading-relaxed">
              <div className="prose prose-md max-w-none [&_p]:mb-2 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm [&_code]:text-gray-800 [&_pre]:bg-gray-50 [&_pre]:border [&_pre]:border-gray-200 [&_pre]:p-3 [&_pre]:rounded [&_pre]:overflow-x-auto [&_pre_code]:bg-transparent [&_pre_code]:text-gray-800 [&_pre_code]:px-0 [&_pre_code]:py-0 [&_pre_code]:rounded-none">
                <ReactMarkdown remarkPlugins={[remarkGfm]}>{question.question_text}</ReactMarkdown>
              </div>
            </CardTitle>
          </div>
        </div>
      </CardHeader>

      <CardContent className="space-y-6">
        {/* Question Input */}
        {question.type === 'MULTIPLE_CHOICE' ? (
          <RadioGroup value={state.selectedAnswer} onValueChange={(value) => updateState({ selectedAnswer: value })}>
            {question.options?.map((option: any, index: number) => (
              <div key={index} className="flex items-center space-x-2">
                <RadioGroupItem value={option.option_key} id={`option-${index}-${question.question_id}`} />
                <Label htmlFor={`option-${index}-${question.question_id}`} className="flex-1 cursor-pointer">
                  <div className="prose prose-sm max-w-none [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm [&_code]:text-gray-800 [&_pre]:bg-gray-50 [&_pre]:border [&_pre]:border-gray-200 [&_pre]:p-3 [&_pre]:rounded [&_pre]:overflow-x-auto [&_pre_code]:bg-transparent [&_pre_code]:text-gray-800 [&_pre_code]:px-0 [&_pre_code]:py-0 [&_pre_code]:rounded-none">
                    <ReactMarkdown remarkPlugins={[remarkGfm]}>{option.option_text}</ReactMarkdown>
                  </div>
                </Label>
              </div>
            ))}
          </RadioGroup>
        ) : (
          <div className="space-y-2">
            <Label htmlFor={`written-answer-${question.question_id}`}>Your Answer:</Label>
            <Textarea
              id={`written-answer-${question.question_id}`}
              placeholder="Type your answer here..."
              value={state.writtenAnswer}
              onChange={(e) => updateState({ writtenAnswer: e.target.value })}
              className="min-h-[100px]"
            />
          </div>
        )}

        {/* Hints and Scaffolding */}
        <div className="space-y-3">
          <div className="flex gap-2 flex-wrap">
            {question.hint_level_1 && (
              <Button
                variant="outline"
                size="sm"
                onClick={() => handleHint(1)}
                disabled={hint1Used}
                className="flex items-center gap-1"
              >
                <HelpCircle className="h-4 w-4" />
                {hint1Used ? 'Hint 1 Used' : 'Hint 1'}
              </Button>
            )}
            {question.hint_level_2 && (
              <Button
                variant="outline"
                size="sm"
                onClick={() => handleHint(2)}
                disabled={hint2Used || !hint1Used}
                className="flex items-center gap-1"
              >
                <HelpCircle className="h-4 w-4" />
                {hint2Used ? 'Hint 2 Used' : 'Hint 2'}
              </Button>
            )}
            {scaffolds.length > 0 && (
              <Button
                variant="outline"
                size="sm"
                onClick={handleStartScaffold}
                disabled={!hint1Used || !hint2Used}
                className="flex items-center gap-1"
              >
                <Lightbulb className="h-4 w-4" />
                {!hint1Used || !hint2Used ? 'Complete Hints First' : 'Need Help?'}
              </Button>
            )}
          </div>

                     {question.hint_level_1 && <HintDisplay hint={question.hint_level_1} isVisible={shouldShowHint1} title="Hint 1" />}
           {question.hint_level_2 && <HintDisplay hint={question.hint_level_2} isVisible={shouldShowHint2} title="Hint 2" />}

          {/* Scaffolding Accordion */}
          {state.showScaffoldContainer && scaffolds.length > 0 && (
            <Accordion
              type="single"
              collapsible
              className="w-full mt-4"
              value={state.activeScaffoldValue}
              onValueChange={(value) => {
                updateState({ activeScaffoldValue: value });
                if (value && value.startsWith('scaffold-')) {
                  const scaffoldIndex = parseInt(value.split('-')[1]);
                  if (scaffoldIndex >= 0 && scaffoldIndex < scaffolds.length) {
                    const scaffoldId = scaffolds[scaffoldIndex].scaffoldId;
                    handleScaffoldView(scaffoldId);
                  }
                }
              }}
            >
              {scaffolds.map((scaffold, idx) => (
                <AccordionItem
                  value={`scaffold-${idx}`}
                  key={scaffold.scaffoldId}
                  disabled={idx > state.unlockedScaffoldIndex}
                  className={idx > state.unlockedScaffoldIndex ? "opacity-50 pointer-events-none" : ""}
                >
                  <AccordionTrigger 
                    disabled={idx > state.unlockedScaffoldIndex}
                    className={idx > state.unlockedScaffoldIndex ? "text-gray-400 cursor-not-allowed" : ""}
                  >
                    <span className={idx > state.unlockedScaffoldIndex ? "text-gray-400" : ""}>
                      Step {idx + 1}
                    </span>
                  </AccordionTrigger>
                  <AccordionContent>
                    <ScaffoldCard
                      scaffold={scaffold}
                      onSubmit={(answer, isCorrect) => handleScaffoldSubmit(scaffold, answer, isCorrect, idx)}
                      onClose={() => updateState({ activeScaffoldValue: undefined })}
                      scaffoldNumber={idx + 1}
                      totalScaffolds={scaffolds.length}
                      onContinue={() => {
                        updateState({ activeScaffoldValue: undefined });
                        if (idx < scaffolds.length - 1) {
                          setTimeout(() => {
                            const nextScaffoldIndex = idx + 1;
                            const nextScaffold = scaffolds[nextScaffoldIndex];
                            updateState({ activeScaffoldValue: `scaffold-${nextScaffoldIndex}` });
                            if (nextScaffold && !state.viewedScaffolds.has(nextScaffold.scaffoldId)) {
                              onScaffoldUsage(nextScaffold.scaffoldId);
                              const newViewedScaffolds = new Set(state.viewedScaffolds).add(nextScaffold.scaffoldId);
                              updateState({ viewedScaffolds: newViewedScaffolds });
                            }
                          }, 100);
                        } else {
                          toast.info("All steps completed! The answer is now available below.");
                        }
                      }}
                    />
                  </AccordionContent>
                </AccordionItem>
              ))}
              
              <AccordionItem
                value="answer"
                disabled={!allScaffoldsCompleted}
                className={!allScaffoldsCompleted ? "opacity-50 pointer-events-none" : ""}
              >
                <AccordionTrigger 
                  disabled={!allScaffoldsCompleted}
                  className={!allScaffoldsCompleted ? "text-gray-400 cursor-not-allowed" : ""}
                >
                  <span className={!allScaffoldsCompleted ? "text-gray-400" : ""}>Answer</span>
                </AccordionTrigger>
                <AccordionContent>
                  <div className="p-4 bg-green-50 border border-green-200 rounded-md">
                    <div className="text-sm text-green-800">
                      <strong>Answer:</strong> 
                      <div className="mt-2 p-3 bg-white border border-green-200 rounded-md">
                        {question.type === 'MULTIPLE_CHOICE' ? (
                          <div>
                            <p className="font-medium mb-2">Correct Option:</p>
                            {question.options?.find(opt => opt.option_key === question.correct_option_key)?.option_text || 'Answer not available'}
                          </div>
                        ) : (
                          <div>
                            <p className="font-medium mb-2">Correct Answer:</p>
                            <p className="font-mono bg-gray-100 px-2 py-1 rounded">{question.correct_answer_text}</p>
                          </div>
                        )}
                      </div>
                    </div>
                    {!allScaffoldsCompleted && (
                      <div className="mt-3 p-2 bg-amber-50 border border-amber-200 rounded text-xs text-amber-700">
                        Complete all scaffold steps to view the answer.
                      </div>
                    )}
                  </div>
                </AccordionContent>
              </AccordionItem>
            </Accordion>
          )}

          {/* Answer Explanation */}
          <AnswerExplanation
            isVisible={state.showExplanation}
            isCorrect={state.lastIsCorrect}
            answer={state.lastAnswer}
            feedback={state.llmFeedback}
            analysis={state.llmAnalysis}
            question={question}
            onClose={() => updateState({ showExplanation: false })}
          />
        </div>

        {/* Action Buttons */}
        <div className="flex justify-end gap-2">
          {!state.showExplanation ? (
            <>
              <Button variant="ghost" onClick={onSkip}>Skip</Button>
              <Button
                onClick={handleSubmit}
                disabled={!canSubmit || isEvaluating}
                className="flex items-center gap-2"
              >
                {isEvaluating ? 'Evaluating...' : 'Submit Answer'}
                {!isEvaluating && <ArrowRight className="h-4 w-4" />}
              </Button>
            </>
          ) : state.lastIsCorrect ? (
            <Button onClick={handleContinue} className="flex items-center gap-2">
              Continue
              <ArrowRight className="h-4 w-4" />
            </Button>
          ) : (
            <>
              <Button variant="ghost" onClick={onSkip}>Skip</Button>
              <Button variant="outline" onClick={handleNextQuestion} className="flex items-center gap-2">
                Next Question
              </Button>
              <Button
                onClick={handleSubmit}
                disabled={!canSubmit || isEvaluating}
                className="flex items-center gap-2"
              >
                {isEvaluating ? 'Evaluating...' : 'Submit Answer'}
                {!isEvaluating && <ArrowRight className="h-4 w-4" />}
              </Button>
            </>
          )}
        </div>
      </CardContent>
    </Card>
  );
}