'use client';

import { useEffect, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { ArrowLeft, TestTube, CheckCircle } from 'lucide-react';
import { useLearningStore } from '@/lib/stores';
import { useData } from '@/hooks/useData';
import { QuestionCard } from '@/components/quiz/question-card';
import { QuizResults } from '@/components/quiz/quiz-results';
import { Lesson, Question } from '@/types/api';
import { ProtectedRoute } from '@/components/auth/protected-route';

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
  const { lessons, questions, loadData } = useData();
  const { currentLesson, setCurrentLesson, showQuiz, setShowQuiz } = useLearningStore();

  const [lessonQuestions, setLessonQuestions] = useState<Question[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [quizResults, setQuizResults] = useState<QuizResult[]>([]);
  const [showResults, setShowResults] = useState(false);

  useEffect(() => {
    console.log('PracticePageClient mounted');
    loadData();
  }, [loadData]);

  useEffect(() => {
    if (lessons.length > 0 && params.lesson_id) {
      const lessonId = params.lesson_id as string;
      const lesson = lessons.find(l => l.lesson_id === lessonId);
      setCurrentLesson(lesson || null);

      if (lesson) {
        // For now, filter questions by lesson_id (this might need to be updated based on your data structure)
        const filteredQuestions = questions.filter(q => 
          // You might need to adjust this based on how questions are linked to lessons
          q.question_text.includes(lesson.lesson_name) || true // Temporary: show all questions
        );
        setLessonQuestions(filteredQuestions);
      }
    }
  }, [lessons, questions, params.lesson_id, setCurrentLesson]);

  const handleStartQuiz = () => {
    if (lessonQuestions.length > 0) {
      setShowQuiz(true);
      setCurrentQuestionIndex(0);
      setQuizResults([]);
      setShowResults(false);
    }
  };

  const handleQuestionSubmit = (answer: string, isCorrect: boolean) => {
    const currentQuestion = lessonQuestions[currentQuestionIndex];
    if (!currentQuestion) return;

    // Add to results
    const result: QuizResult = {
      questionId: currentQuestion.question_id, // Keep as string UUID
      questionText: currentQuestion.question_text,
      userAnswer: answer,
      correctAnswer: getCorrectAnswer(currentQuestion),
      isCorrect,
      hintsUsed: 0, // TODO: Implement hint tracking
      scaffoldUsed: false // TODO: Implement scaffold tracking
    };

    const newResults = [...quizResults, result];
    setQuizResults(newResults);

    // Move to next question or show results
    if (currentQuestionIndex < lessonQuestions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    } else {
      setShowResults(true);
      setShowQuiz(false);
    }
  };

  const getCorrectAnswer = (question: Question): string => {
    if (question.type === 'MULTIPLE_CHOICE') {
      const correctOption = question.options.find(opt => opt.option_key === question.correct_option_key);
      return correctOption?.option_text || 'Unknown';
    } else {
      return question.correct_answer_text;
    }
  };

  const handleBackToLesson = () => {
    router.push(`/lessons/${params.lesson_id}`);
  };

  if (!currentLesson) {
    return (
      <ProtectedRoute>
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-gray-600">Loading lesson...</p>
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

  if (showQuiz && lessonQuestions.length > 0) {
    const currentQuestion = lessonQuestions[currentQuestionIndex];
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
              Question {currentQuestionIndex + 1} of {lessonQuestions.length}
            </Badge>
          </div>
          <QuestionCard
            question={currentQuestion}
            onSubmit={handleQuestionSubmit}
            onHint={() => {}} // TODO: Implement hint functionality
            onScaffold={() => {}} // TODO: Implement scaffold functionality
            usedHints={new Set()}
            questionNumber={currentQuestionIndex + 1}
            totalQuestions={lessonQuestions.length}
          />
        </div>
      </ProtectedRoute>
    );
  }

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-8">
        <div className="mb-6">
          <Button variant="ghost" asChild className="flex items-center gap-2">
            <Link href="/">
              <ArrowLeft className="h-4 w-4" />
              Back to Home
            </Link>
          </Button>
        </div>

        <div className="mb-8">
          <div className="flex items-center gap-3 mb-4">
            <div className="bg-blue-600 p-3 rounded-lg">
              <TestTube className="h-6 w-6 text-white" />
            </div>
            <div>
              <h1 className="text-3xl font-bold text-gray-900">Practice Questions</h1>
              <p className="text-gray-600 mt-1">
                Practice questions for: {currentLesson.lesson_name}
              </p>
            </div>
          </div>
          
          <div className="mb-6">
            <Badge variant="secondary" className="text-sm">
              {lessonQuestions.length} question{lessonQuestions.length !== 1 ? 's' : ''} available
            </Badge>
          </div>

          {lessonQuestions.length > 0 ? (
            <Card className="max-w-2xl">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <CheckCircle className="h-5 w-5 text-green-600" />
                  Ready to Practice?
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-gray-600 mb-4">
                  Test your knowledge with {lessonQuestions.length} practice questions based on this lesson.
                </p>
                <Button onClick={handleStartQuiz} className="w-full" size="lg">
                  <TestTube className="h-4 w-4 mr-2" />
                  Start Practice Questions
                </Button>
              </CardContent>
            </Card>
          ) : (
            <Card className="max-w-2xl">
              <CardContent className="text-center py-8">
                <TestTube className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                <h3 className="text-lg font-semibold text-gray-900 mb-2">No Practice Questions Available</h3>
                <p className="text-gray-600">
                  This lesson doesn't have any practice questions yet.
                </p>
              </CardContent>
            </Card>
          )}
        </div>
      </div>
    </ProtectedRoute>
  );
}
