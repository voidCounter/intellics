'use client';

import { useEffect, useState, useRef } from 'react';
import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { ArrowLeft, TestTube, CheckCircle } from 'lucide-react';
import { useLessonData } from '@/hooks/useLessonData';

import { QuestionCard } from '@/components/quiz/question-card';
import { QuizResults } from '@/components/quiz/quiz-results';
import { Lesson, Question } from '@/types/api';
import { ProtectedRoute } from '@/components/auth/protected-route';
import { useSessionStore } from '@/lib/stores';
import { useNextQuestionWithScaffolds, useGetNextQuestion } from '@/hooks/useQuestionRecommendations';
import { useInteractionLogger } from '@/lib/services/interactionLogger';

interface QuizResult {
  questionId: string;
  questionText: string;
  userAnswer: string;
  correctAnswer: string;
  isCorrect: boolean;
  hintsUsed: number;
  scaffoldUsed: boolean;
}

export default function PracticePageClient() {
  const params = useParams();
  const router = useRouter();

  const { currentLesson, isLoading: lessonLoading, error: lessonError } = useLessonData(params.lesson_id as string);
  const [showQuiz, setShowQuiz] = useState(true); // Start with quiz immediately
  const { sessionId } = useSessionStore();
  const interactionLogger = useInteractionLogger();

  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [quizResults, setQuizResults] = useState<QuizResult[]>([]);
  const [showResults, setShowResults] = useState(false);
  const [usedHints, setUsedHints] = useState<Set<string>>(new Set());
  const [usedScaffolds, setUsedScaffolds] = useState<Set<string>>(new Set());
  const practiceStartTimeRef = useRef<number | null>(null);
  const startTestSentRef = useRef<boolean>(false);


  // Get the current question with scaffolds for complete data
  const { data: currentQuestion, isLoading: questionLoading } = useNextQuestionWithScaffolds(
    params.lesson_id as string,
    params.module_id as string,
    { enabled: showQuiz }
  );

  // Mutation for getting the next question
  const getNextQuestion = useGetNextQuestion();

  useEffect(() => {
    console.log('PracticePageClient mounted');
    // No need to load all lessons - we already have the lesson ID from params
  }, []);

  // Track practice start when component mounts (only once)
  useEffect(() => {
    if (currentLesson && sessionId) {
      practiceStartTimeRef.current = Date.now();
      // Track practice session start time
    }
  }, [currentLesson, params.module_id, sessionId]);

  // Reset tracking when lesson changes
  useEffect(() => {
    if (params.lesson_id) {
      console.log('🔄 Resetting interaction tracking for lesson:', params.lesson_id);
      startTestSentRef.current = false; // Reset the practice start flag when lesson changes
      setUsedHints(new Set());
      setUsedScaffolds(new Set());
    }
  }, [params.lesson_id]);

  // Log practice exit when component unmounts
  useEffect(() => {
    return () => {
      if (practiceStartTimeRef.current && currentLesson && sessionId) {
        const timeSpent = Math.floor((Date.now() - practiceStartTimeRef.current) / 1000);
        if (timeSpent > 10) { // Only log if spent more than 10 seconds
          console.log('Practice session ended, time spent:', timeSpent, 'seconds');
        }
      }
    };
  }, [currentLesson, params.module_id, sessionId]);

  // Log question presented when currentQuestion changes
  useEffect(() => {
    if (currentQuestion && sessionId) {
      console.log('📝 Question presented:', currentQuestion.question_id);
      interactionLogger.logQuestionPresented(
        sessionId,
        currentQuestion.question_id,
        params.lesson_id as string,
        params.module_id as string
      ).catch((error: unknown) => {
        console.error('Failed to log question presented interaction:', error);
      });
    }
  }, [currentQuestion, sessionId, params.lesson_id, params.module_id, interactionLogger]);

  const handleStartQuiz = () => {
    console.log('🎯 handleStartQuiz called, startTestSentRef.current:', startTestSentRef.current);
    
    setShowQuiz(true);
    setCurrentQuestionIndex(0);
    setQuizResults([]);
    setShowResults(false);
    setUsedHints(new Set());
    setUsedScaffolds(new Set());
    
    // Track practice start when user actually starts the quiz (only once per session)
    if (currentLesson && sessionId && !startTestSentRef.current) {
      console.log('📤 Practice session started');
      practiceStartTimeRef.current = Date.now();
      startTestSentRef.current = true;
      
      // Log the first question presented when quiz starts
      if (currentQuestion && sessionId) {
        console.log('📝 First question presented on quiz start:', currentQuestion.question_id);
        interactionLogger.logQuestionPresented(
          sessionId,
          currentQuestion.question_id,
          params.lesson_id as string,
          params.module_id as string
        ).catch((error: unknown) => {
          console.error('Failed to log first question presented interaction:', error);
        });
      }
    } else {
      console.log('⏭️ Skipping practice start tracking:', {
        hasCurrentLesson: !!currentLesson,
        hasSessionId: !!sessionId,
        startTestSent: startTestSentRef.current
      });
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
        params.lesson_id as string,
        params.module_id as string
      ).catch((error: unknown) => {
        console.error('Failed to log hint interaction:', error);
      });
    }
  };

  const handleScaffold = () => {
    if (!currentQuestion || !sessionId) return;
    
    // Track scaffold usage - just mark that user has accessed scaffold help
    // Don't log interaction yet - wait for actual scaffold usage
    setUsedScaffolds(prev => new Set([...Array.from(prev), currentQuestion.question_id]));
    
    // No interaction logging here - will be logged when user actually uses a specific scaffold
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
        params.lesson_id as string,
        params.module_id as string
      ).catch((error: unknown) => {
        console.error('Failed to log scaffold usage interaction:', error);
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
        params.lesson_id as string,
        params.module_id as string
      ).catch((error: unknown) => {
        console.error('Failed to log scaffold attempted interaction:', error);
      });
    }
  };

  const handleSkip = () => {
    if (!currentQuestion || !sessionId) return;
    
    // Log skip interaction
    if (sessionId) {
      interactionLogger.logQuestionSkipped(
        sessionId,
        currentQuestion.question_id,
        params.lesson_id as string,
        params.module_id as string
      ).catch((error: unknown) => {
        console.error('Failed to log skip interaction:', error);
      });
    }
  };

  const handleQuestionSubmit = async (answer: string, isCorrect: boolean) => {
    if (!currentQuestion) return;

    // Check if this is a skip (empty answer and not correct)
    const isSkipped = answer === '' && !isCorrect;

    // Log question attempted interaction
    if (!isSkipped && sessionId) {
      interactionLogger.logQuestionAttempted(
        sessionId,
        currentQuestion.question_id,
        answer,
        isCorrect,
        params.lesson_id as string,
        params.module_id as string
      ).catch((error: unknown) => {
        console.error('Failed to log question attempted interaction:', error);
      });
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

    // Get the next question
    try {
      const nextQuestion = await getNextQuestion.mutateAsync({
        lessonId: params.lesson_id as string,
        moduleId: params.module_id as string
      });

      if (nextQuestion) {
        // Move to next question
        setCurrentQuestionIndex(prev => prev + 1);
        // The useNextQuestionWithScaffolds hook will automatically update with the new question
        
        // Log the next question presented
        if (sessionId) {
          console.log('📝 Next question presented:', nextQuestion.question_id);
          interactionLogger.logQuestionPresented(
            sessionId,
            nextQuestion.question_id,
            params.lesson_id as string,
            params.module_id as string
          ).catch((error: unknown) => {
            console.error('Failed to log next question presented interaction:', error);
          });
        }
      } else {
        // No more questions, show results
        setShowResults(true);
        setShowQuiz(false);
      }
    } catch (error) {
      console.error('Failed to get next question:', error);
      // Show results anyway
      setShowResults(true);
      setShowQuiz(false);
    }
  };

  const handleBackToLesson = () => {
    router.push(`/modules/${params.module_id}/lessons/${params.lesson_id}`);
  };

  if (lessonLoading) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
            <p className="text-gray-600">Loading lesson...</p>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  if (lessonError) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-red-600">Error loading lesson: {lessonError}</p>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  if (!currentLesson) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-gray-600">Lesson not found</p>
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
            <Button variant="ghost" onClick={handleBackToLesson} className="flex items-center gap-2">
              <ArrowLeft className="h-4 w-4" />
              Back to Lesson
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
            <Button variant="ghost" onClick={handleBackToLesson} className="flex items-center gap-2">
              <ArrowLeft className="h-4 w-4" />
              Back to Lesson
            </Button>
          </div>
          <div className="text-center">
            <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-6 max-w-md mx-auto">
              <div className="text-yellow-600 text-4xl mb-4">🎯</div>
              <h3 className="text-lg font-semibold text-yellow-800 mb-2">No More Questions</h3>
              <p className="text-yellow-700 text-sm mb-4">
                You've completed all available questions for this lesson! 
                Great job! 🎉
              </p>
              <Button onClick={handleBackToLesson} variant="outline" className="w-full">
                Back to Lesson
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
            <Button variant="ghost" onClick={handleBackToLesson} className="flex items-center gap-2">
              <ArrowLeft className="h-4 w-4" />
              Back to Lesson
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
            onContinue={handleBackToLesson}
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
            <Button variant="ghost" onClick={handleBackToLesson} className="flex items-center gap-2">
              <ArrowLeft className="h-4 w-4" />
              Back to Lesson
            </Button>
          </div>
          <div className="mb-4">
            <Badge variant="outline">
              Question {currentQuestionIndex + 1}
            </Badge>
          </div>
          <QuestionCard
            question={currentQuestion}
            onSubmit={handleQuestionSubmit}
            onHint={handleHint}
            onScaffold={handleScaffold}
            onScaffoldUsage={handleScaffoldUsage}
            onScaffoldSubmit={handleScaffoldSubmit}
            onSkip={handleSkip}
            usedHints={usedHints}
            questionNumber={currentQuestionIndex + 1}
            totalQuestions={-1} // We don't know total count in this approach
          />
        </div>
      </ProtectedRoute>
    );
  }

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-8">
        <div className="mb-6">
          <Button variant="ghost" onClick={handleBackToLesson} className="flex items-center gap-2">
            <ArrowLeft className="h-4 w-4" />
            Back to Lesson
          </Button>
        </div>

        <div className="max-w-4xl mx-auto">
          <div className="text-center mb-8">
            <div className="bg-blue-600 p-4 rounded-full w-20 h-20 mx-auto mb-6 flex items-center justify-center">
              <TestTube className="h-10 w-10 text-white" />
            </div>
            <h1 className="text-3xl font-bold text-gray-900 mb-4">
              Practice Questions
            </h1>
            <p className="text-lg text-gray-600 mb-6">
              Test your understanding with personalized questions that adapt to your learning progress
            </p>
            
            <div className="bg-gray-50 rounded-lg p-4 mb-6 text-left">
              <h3 className="font-semibold text-gray-900 mb-2">🎯 Adaptive Learning</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                <div>
                  <span className="font-medium">Personalized:</span> Questions based on your mastery gaps
                </div>
                <div>
                  <span className="font-medium">Spaced Repetition:</span> Optimized timing for retention
                </div>
                <div>
                  <span className="font-medium">Prerequisites:</span> Includes foundational concepts when needed
                </div>
                <div>
                  <span className="font-medium">Progress Tracking:</span> Monitors your learning journey
                </div>
              </div>
            </div>

            <Button 
              onClick={handleStartQuiz} 
              size="lg" 
              className="px-8 py-3 text-lg"
            >
              <TestTube className="h-5 w-5 mr-2" />
              Start Practice
            </Button>
          </div>
        </div>
      </div>
    </ProtectedRoute>
  );
}
