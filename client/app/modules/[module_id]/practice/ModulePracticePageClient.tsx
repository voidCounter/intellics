'use client';

import { useEffect, useState, useRef } from 'react';
import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { ArrowLeft, Play, Brain, BookOpen } from 'lucide-react';
import { useModuleData } from '@/hooks/useModuleData';

import { QuestionCard } from '@/components/quiz/question-card';
import { QuizResults } from '@/components/quiz/quiz-results';
import { Module, Question } from '@/types/api';
import { ProtectedRoute } from '@/components/auth/protected-route';
import { useSessionStore } from '@/lib/stores';
import { useNextQuestionWithScaffolds, useGetNextQuestion } from '@/hooks/useQuestionRecommendations';
import { useInteractionLogger } from '@/lib/services/interactionLogger';
import { logger } from '@/lib/utils';

interface QuizResult {
  questionId: string;
  questionText: string;
  userAnswer: string;
  correctAnswer: string;
  isCorrect: boolean;
  hintsUsed: number;
  scaffoldUsed: boolean;
}

export default function ModulePracticePageClient() {
  const params = useParams();
  const router = useRouter();

  const { modules, lessons, isLoading, error } = useModuleData(params.module_id as string);
  const [currentModule, setCurrentModule] = useState<Module | null>(null);
  const [showQuiz, setShowQuiz] = useState(true); // Start with quiz immediately
  const { sessionId } = useSessionStore();
  const interactionLogger = useInteractionLogger();

  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [quizResults, setQuizResults] = useState<QuizResult[]>([]);
  const [showResults, setShowResults] = useState(false);
  const [usedHints, setUsedHints] = useState<Set<string>>(new Set());
  const [usedScaffolds, setUsedScaffolds] = useState<Set<string>>(new Set());
  const [currentQuestion, setCurrentQuestion] = useState<Question | null>(null);
  const practiceStartTimeRef = useRef<number | null>(null);
  const startTestSentRef = useRef<boolean>(null);

  // Get the first question when starting practice
  const { data: firstQuestion, isLoading: questionLoading } = useNextQuestionWithScaffolds(
    undefined, // No lesson ID for module practice
    params.module_id as string,
    { 
      enabled: showQuiz && currentQuestionIndex === 0,
      staleTime: 10 * 60 * 1000, // 10 minutes - prevent refetching when switching tabs
      refetchOnWindowFocus: false, // Never refetch when switching tabs
      refetchOnMount: false, // Don't refetch when component mounts
      refetchOnReconnect: false // Don't refetch when reconnecting
    }
  );

  // Set the first question when it loads
  useEffect(() => {
    if (firstQuestion && currentQuestionIndex === 0) {
      setCurrentQuestion(firstQuestion);
    }
  }, [firstQuestion, currentQuestionIndex]);

  // Mutation for getting the next question
  const getNextQuestion = useGetNextQuestion();

  useEffect(() => {
    if (modules.length > 0 && params.module_id) {
      const moduleId = params.module_id as string;
      const module = modules.find(m => m.module_id === moduleId);
      setCurrentModule(module || null);
    }
  }, [modules, params.module_id]);

  // Track practice start when component mounts (only once)
  useEffect(() => {
    if (currentModule && sessionId) {
      practiceStartTimeRef.current = Date.now();
    }
  }, [currentModule, params.module_id, sessionId]);

  // Reset tracking when module changes
  useEffect(() => {
    if (params.module_id) {
      logger.log('🔄 Resetting interaction tracking for module:', params.module_id);
      startTestSentRef.current = false;
      setUsedHints(new Set());
      setUsedScaffolds(new Set());
    }
  }, [params.module_id]);

  // Log practice exit when component unmounts
  useEffect(() => {
    return () => {
      if (practiceStartTimeRef.current && currentModule && sessionId) {
        const timeSpent = Math.floor((Date.now() - practiceStartTimeRef.current) / 1000);
        if (timeSpent > 10) {
          logger.log('Module practice session ended, time spent:', timeSpent, 'seconds');
        }
      }
    };
  }, [currentModule, params.module_id, sessionId]);

  // Log question presented when currentQuestion changes
  useEffect(() => {
    if (currentQuestion && sessionId) {
      logger.log('📝 Question presented:', currentQuestion.question_id);
      interactionLogger.logQuestionPresented(
        sessionId,
        currentQuestion.question_id,
        undefined, // No lesson ID for module practice
        params.module_id as string
      ).catch((error: unknown) => {
        logger.error('Failed to log question presented interaction:', error);
      });
    }
  }, [currentQuestion, sessionId, params.module_id, interactionLogger]);

  const handleStartQuiz = () => {
    logger.log('🎯 handleStartQuiz called, startTestSentRef.current:', startTestSentRef.current);
    
    setShowQuiz(true);
    setCurrentQuestionIndex(0);
    setCurrentQuestion(null); // Reset current question
    setQuizResults([]);
    setShowResults(false);
    setUsedHints(new Set());
    setUsedScaffolds(new Set());
    
    // Track practice start when user actually starts the quiz (only once per session)
    if (currentModule && sessionId && !startTestSentRef.current) {
      logger.log('📤 Module practice session started');
      practiceStartTimeRef.current = Date.now();
      startTestSentRef.current = true;
      
      // Note: Question presented is already logged by useEffect when currentQuestion changes
      // No need to log it again here to avoid duplicates
    }
  };

  const handleHint = (level: number) => {
    if (!currentQuestion || !sessionId) return;
    
    // Track hint usage
    const hintKey = `${currentQuestion.question_id}-${level}`;
    setUsedHints(prev => new Set([...Array.from(prev), hintKey]));
    
    // Log hint interaction
    if (sessionId) {
      interactionLogger.logHintRequested(
        sessionId,
        currentQuestion.question_id,
        level,
        undefined, // No lesson ID for module practice
        params.module_id as string
      ).catch((error: unknown) => {
        logger.error('Failed to log hint interaction:', error);
      });
    }
  };

  const handleScaffold = () => {
    if (!currentQuestion || !sessionId) return;
    
    // Track scaffold usage
    setUsedScaffolds(prev => new Set([...Array.from(prev), currentQuestion.question_id]));
  };

  const handleScaffoldUsage = (scaffoldId: string) => {
    if (!currentQuestion || !sessionId) return;
    
    // Track scaffold usage
    setUsedScaffolds(prev => new Set([...Array.from(prev), currentQuestion.question_id]));
    
    // Log scaffold usage interaction
    if (sessionId) {
      interactionLogger.logScaffoldRequested(
        sessionId,
        currentQuestion.question_id,
        scaffoldId,
        undefined, // No lesson ID for module practice
        params.module_id as string
      ).catch((error: unknown) => {
        logger.error('Failed to log scaffold usage interaction:', error);
      });
    }
  };

  const handleScaffoldSubmit = (scaffoldId: string, answer: string, isCorrect: boolean) => {
    if (!currentQuestion || !sessionId) return;
    
    // Log scaffold attempted interaction
    if (sessionId) {
      interactionLogger.logScaffoldAttempted(
        sessionId,
        currentQuestion.question_id,
        scaffoldId,
        answer,
        isCorrect,
        undefined, // No lesson ID for module practice
        params.module_id as string
      ).catch((error: unknown) => {
        logger.error('Failed to log scaffold attempted interaction:', error);
      });
    }
  };

  const handleSkip = async () => {
    if (!currentQuestion || !sessionId) return;
    
    try {
      // Log skip interaction and wait for it to complete
      logger.log('📝 Logging QUESTION_SKIPPED interaction for question:', currentQuestion.question_id);
      await interactionLogger.logQuestionSkipped(
        sessionId,
        currentQuestion.question_id,
        undefined, // No lesson ID for module practice
        params.module_id as string
      );
      logger.log('✅ QUESTION_SKIPPED interaction logged successfully');

      // Add a small delay to ensure the backend processes the interaction
      await new Promise(resolve => setTimeout(resolve, 100));

      // Add the question to results as skipped
      const result: QuizResult = {
        questionId: currentQuestion.question_id,
        questionText: currentQuestion.question_text,
        userAnswer: 'Skipped',
        correctAnswer: 'Skipped',
        isCorrect: false,
        hintsUsed: Array.from(usedHints).filter(hint => 
          hint.startsWith(currentQuestion.question_id)
        ).length,
        scaffoldUsed: Array.from(usedScaffolds).some(scaffold => 
          scaffold.startsWith(currentQuestion.question_id)
        )
      };
      setQuizResults(prev => [...prev, result]);

      // Now get the next question after the interaction is logged
      logger.log('🔄 Requesting next question after skip...');
      const nextQuestion = await getNextQuestion.mutateAsync({
        lessonId: undefined, // No lesson ID for module practice
        moduleId: params.module_id as string
      });

      if (nextQuestion) {
        logger.log('📝 Received next question:', nextQuestion.question_id, 'Previous question was:', currentQuestion?.question_id);
        
        // Move to next question
        setCurrentQuestionIndex(prev => prev + 1);
        // Update the current question immediately
        setCurrentQuestion(nextQuestion);
        
        // Log the next question presented
        if (sessionId) {
          logger.log('📝 Next question presented (skip):', nextQuestion.question_id);
          interactionLogger.logQuestionPresented(
            sessionId,
            nextQuestion.question_id,
            undefined, // No lesson ID for module practice
            params.module_id as string
          ).catch((error: unknown) => {
            logger.error('Failed to log next question presented interaction:', error);
          });
        }
      } else {
        // No more questions, show results
        setShowResults(true);
        setShowQuiz(false);
      }
    } catch (error) {
      logger.error('Failed to handle skip:', error);
      // If logging fails, still try to get next question
      try {
        logger.log('🔄 Attempting to get next question despite logging failure...');
        const nextQuestion = await getNextQuestion.mutateAsync({
          lessonId: undefined, // No lesson ID for module practice
          moduleId: params.module_id as string
        });

        if (nextQuestion) {
          setCurrentQuestionIndex(prev => prev + 1);
          setCurrentQuestion(nextQuestion);
          
          if (sessionId) {
            logger.log('📝 Next question presented (skip fallback):', nextQuestion.question_id);
            interactionLogger.logQuestionPresented(
              sessionId,
              nextQuestion.question_id,
              undefined,
              params.module_id as string
            ).catch((error: unknown) => {
              logger.error('Failed to log next question presented interaction:', error);
            });
          }
        } else {
          setShowResults(true);
          setShowQuiz(false);
        }
      } catch (nextQuestionError) {
        logger.error('Failed to get next question after skip:', nextQuestionError);
        // Show results anyway
        setShowResults(true);
        setShowQuiz(false);
      }
    }
  };

  const handleContinue = async () => {
    try {
      const nextQuestion = await getNextQuestion.mutateAsync({
        lessonId: undefined, // No lesson ID for module practice
        moduleId: params.module_id as string
      });

      if (nextQuestion) {
        // Move to next question
        setCurrentQuestionIndex(prev => prev + 1);
        // Update the current question immediately
        setCurrentQuestion(nextQuestion);
        
        // Log the next question presented
        if (sessionId) {
          logger.log('📝 Next question presented (continue):', nextQuestion.question_id);
          interactionLogger.logQuestionPresented(
            sessionId,
            nextQuestion.question_id,
            undefined, // No lesson ID for module practice
            params.module_id as string
          ).catch((error: unknown) => {
            logger.error('Failed to log next question presented interaction:', error);
          });
        }
      } else {
        // No more questions, show results
        setShowResults(true);
        setShowQuiz(false);
      }
    } catch (error) {
      logger.error('Failed to get next question:', error);
      // Show results anyway
      setShowResults(true);
      setShowQuiz(false);
    }
  };

  const handleQuestionSubmit = async (answer: string, isCorrect: boolean, aiEvaluation?: { correctnessScore: number; feedback: string; analysis: string }) => {
    if (!currentQuestion) return;

    // Check if this is a skip (empty answer and not correct)
    const isSkipped = answer === '' && !isCorrect;

    // Log question attempted interaction (for non-skips)
    if (!isSkipped && sessionId) {
      interactionLogger.logQuestionAttempted(
        sessionId,
        currentQuestion.question_id,
        answer,
        isCorrect,
        undefined, // No lesson ID for module practice
        params.module_id as string,
        undefined, // timeSpentSeconds
        aiEvaluation?.correctnessScore,
        aiEvaluation?.analysis
      ).catch((error: unknown) => {
        logger.error('Failed to log question attempted interaction:', error);
      });
    }

    // Log skip interaction if this is a skip
    if (isSkipped && sessionId) {
      try {
        logger.log('📝 Logging QUESTION_SKIPPED interaction for question:', currentQuestion.question_id);
        await interactionLogger.logQuestionSkipped(
          sessionId,
          currentQuestion.question_id,
          undefined, // No lesson ID for module practice
          params.module_id as string
        );
        logger.log('✅ QUESTION_SKIPPED interaction logged successfully');
      } catch (error) {
        logger.error('Failed to log QUESTION_SKIPPED interaction:', error);
      }
    }

    // Add a small delay after logging interactions to ensure backend processing
    if (isSkipped) {
      await new Promise(resolve => setTimeout(resolve, 100));
    }

    // Count hints used for this question
    const hintsUsed = Array.from(usedHints).filter(hint => 
      hint.startsWith(currentQuestion.question_id)
    ).length;

    // Extract correct answer based on question type
    let correctAnswer = 'Correct answer not available';
    if (currentQuestion.type === 'MULTIPLE_CHOICE' && 'correct_option_key' in currentQuestion) {
      const correctOption = currentQuestion.options?.find(opt => opt.option_key === currentQuestion.correct_option_key);
      correctAnswer = correctOption?.option_text || 'Correct option not found';
    } else if (currentQuestion.type === 'WRITTEN' && 'correct_answer_text' in currentQuestion) {
      correctAnswer = currentQuestion.correct_answer_text;
    }

    // Add to results
    const result: QuizResult = {
      questionId: currentQuestion.question_id,
      questionText: currentQuestion.question_text,
      userAnswer: isSkipped ? 'Skipped' : answer,
      correctAnswer,
      isCorrect: isSkipped ? false : isCorrect,
      hintsUsed: hintsUsed,
      scaffoldUsed: usedScaffolds.has(currentQuestion.question_id)
    };

    const newResults = [...quizResults, result];
    setQuizResults(newResults);

    // Only get next question for skips - for regular submissions, wait for user to click Continue
    if (isSkipped) {
      try {
        logger.log('🔄 Requesting next question after skip...');
        const nextQuestion = await getNextQuestion.mutateAsync({
          lessonId: undefined, // No lesson ID for module practice
          moduleId: params.module_id as string
        });

        if (nextQuestion) {
          // Move to next question
          setCurrentQuestionIndex(prev => prev + 1);
          setCurrentQuestion(nextQuestion); // Update current question immediately
          
          // Check if we got the same question
          if (nextQuestion.question_id === currentQuestion?.question_id) {
            logger.warn('⚠️ Received the same question after skip in handleQuestionSubmit. This might indicate a backend issue.');
          }
          
          // Log the next question presented
          if (sessionId) {
            logger.log('📝 Next question presented (skip):', nextQuestion.question_id);
            interactionLogger.logQuestionPresented(
              sessionId,
              nextQuestion.question_id,
              undefined, // No lesson ID for module practice
              params.module_id as string
            ).catch((error: unknown) => {
              logger.error('Failed to log next question presented interaction:', error);
            });
          }
        } else {
          // No more questions, show results
          setShowResults(true);
          setShowQuiz(false);
        }
      } catch (error) {
        logger.error('Failed to get next question:', error);
        // Show results anyway
        setShowResults(true);
        setShowQuiz(false);
      }
    }
    // For regular submissions (not skips), the user will click Continue to move to next question
  };

  const handleBackToModule = () => {
    router.push(`/modules/${params.module_id}`);
  };

  if (isLoading) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-gray-600">Loading module...</p>
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
            <p className="text-red-600">Error loading module: {error}</p>
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

  if (showQuiz && questionLoading) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="mb-6">
            <Button variant="ghost" onClick={handleBackToModule} className="flex items-center gap-2">
              <ArrowLeft className="h-4 w-4" />
              Back to Module
            </Button>
          </div>
          <div className="text-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
            <p className="text-gray-600">Loading next question...</p>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  if (showQuiz && !currentQuestion) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="mb-6">
            <Button variant="ghost" onClick={handleBackToModule} className="flex items-center gap-2">
              <ArrowLeft className="h-4 w-4" />
              Back to Module
            </Button>
          </div>
          <div className="text-center">
            <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-6 max-w-md mx-auto">
              <div className="text-yellow-600 text-4xl mb-4">🎯</div>
              <h3 className="text-lg font-semibold text-yellow-800 mb-2">No More Questions</h3>
              <p className="text-yellow-700 text-sm mb-4">
                You've completed all available questions for this module! 
                Great job! 🎉
              </p>
              <Button onClick={handleBackToModule} variant="outline" className="w-full">
                Back to Module
              </Button>
            </div>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  if (showResults) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="mb-6">
            <Button variant="ghost" onClick={handleBackToModule} className="flex items-center gap-2">
              <ArrowLeft className="h-4 w-4" />
              Back to Module
            </Button>
          </div>
          <QuizResults 
            results={quizResults} 
            onRetake={() => {
              setShowResults(false);
              setQuizResults([]);
              setCurrentQuestionIndex(0);
              setShowQuiz(true);
            }}
            onContinue={handleBackToModule}
          />
        </div>
      </ProtectedRoute>
    );
  }

  if (showQuiz && currentQuestion) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="mb-6">
            <Button variant="ghost" onClick={handleBackToModule} className="flex items-center gap-2">
              <ArrowLeft className="h-4 w-4" />
              Back to Module
            </Button>
          </div>

          <QuestionCard
            question={currentQuestion}
            onSubmit={handleQuestionSubmit}
            onHint={handleHint}
            onScaffold={handleScaffold}
            onScaffoldUsage={handleScaffoldUsage}
            onScaffoldSubmit={handleScaffoldSubmit}
            onSkip={handleSkip}
            onContinue={handleContinue}
            usedHints={usedHints}
            questionNumber={currentQuestionIndex + 1}
            totalQuestions={-1} // We don't know total count in this approach
          />
          
          {/* Finish Practice Button */}
          <div className="flex justify-center mt-6">
            <Button
              variant="outline"
              onClick={() => {
                setShowResults(true);
                setShowQuiz(false);
              }}
              className="px-8 py-3"
            >
              Finish Practice
            </Button>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-8">
        <div className="mb-6">
          <Button variant="ghost" onClick={handleBackToModule} className="flex items-center gap-2">
            <ArrowLeft className="h-4 w-4" />
            Back to Module
          </Button>
        </div>

        <div className="max-w-4xl mx-auto">
          <div className="text-center mb-8">
            <div className="bg-blue-600 p-4 rounded-full w-20 h-20 mx-auto mb-6 flex items-center justify-center">
              <Brain className="h-10 w-10 text-white" />
            </div>
            <h1 className="text-3xl font-bold text-gray-900 mb-4">
              Module Practice
            </h1>
            <p className="text-lg text-gray-600 mb-6">
              Test your understanding across all knowledge components in this module
            </p>
            
            <div className="bg-gray-50 rounded-lg p-4 mb-6 text-left">
              <h3 className="font-semibold text-gray-900 mb-2">🎯 Comprehensive Practice</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                <div>
                  <span className="font-medium">All KCs:</span> Questions from every knowledge component
                </div>
                <div>
                  <span className="font-medium">Prerequisites:</span> Includes foundational concepts
                </div>
                <div>
                  <span className="font-medium">Adaptive:</span> Personalized to your learning progress
                </div>
                <div>
                  <span className="font-medium">Module-wide:</span> Covers the entire module scope
                </div>
              </div>
            </div>

            <Button 
              onClick={handleStartQuiz} 
              size="lg" 
              className="px-8 py-3 text-lg"
            >
              <Play className="h-5 w-5 mr-2" />
              Start Module Practice
            </Button>
          </div>
        </div>
      </div>
    </ProtectedRoute>
  );
}
