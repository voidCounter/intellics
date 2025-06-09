'use client';

import { useEffect, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import ReactMarkdown, { Components } from 'react-markdown';
import remarkGfm from 'remark-gfm';
import { Prism as SyntaxHighlighter } from 'react-syntax-highlighter';
import { oneLight } from 'react-syntax-highlighter/dist/esm/styles/prism';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { ArrowLeft, TestTube, CheckCircle } from 'lucide-react';
import { useAppStore } from '@/lib/store';
import { QuestionCard } from '@/components/quiz/question-card';
import { ScaffoldCard } from '@/components/quiz/scaffold-card';
import { QuizResults } from '@/components/quiz/quiz-results';
import { Lesson, Question } from '@/lib/store';
import { useLessonTracking } from '@/lib/hooks/useLessonTracking';

interface QuizResult {
    questionId: number;
    questionText: string;
    userAnswer: string;
    correctAnswer: string;
    isCorrect: boolean;
    hintsUsed: number;
    scaffoldUsed: boolean;
}

export default function LessonPageClient() {
    const params = useParams();
    const router = useRouter();
    const {
        lessons,
        questions,
        loadData,
        setCurrentLesson,
        currentLesson,
        showQuiz,
        setShowQuiz,
        currentQuestionIndex,
        setCurrentQuestionIndex,
        addInteraction,
        updateKCMastery,
        requestHint,
        startScaffold,
        currentScaffolds,
        currentScaffoldIndex,
        showScaffold,
        setShowScaffold,
        nextScaffold,
        usedHints,
        startTimer,
        getTimeSpent,
        resetQuizState
    } = useAppStore();

    const [lessonQuestions, setLessonQuestions] = useState<Question[]>([]);
    const [quizResults, setQuizResults] = useState<QuizResult[]>([]);
    const [showResults, setShowResults] = useState(false);

    // Use the lesson tracking hook
    useLessonTracking();

    useEffect(() => {
        console.log('LessonPageClient mounted');
        loadData();
    }, [loadData]);

    useEffect(() => {
        if (lessons.length > 0 && params.lesson_id) {
            const lessonId = parseInt(params.lesson_id as string);
            const lesson = lessons.find(l => l.lesson_id === lessonId);
            setCurrentLesson(lesson || null);

            if (lesson) {
                const filteredQuestions = questions.filter(q => q.lesson_id === lessonId);
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
            startTimer();
        }
    };

    const handleQuestionSubmit = (answer: string, isCorrect: boolean) => {
        const currentQuestion = lessonQuestions[currentQuestionIndex];
        if (!currentQuestion) return;

        // Update mastery for both correct and incorrect answers
        updateKCMastery(1, isCorrect); // Using KC 1 as example

        // Count hints used for this question
        const hintsUsed = Array.from(usedHints).filter(hint =>
            hint.startsWith(`${currentQuestion.question_id}-`)
        ).length;

        // Add to results
        const result: QuizResult = {
            questionId: currentQuestion.question_id,
            questionText: currentQuestion.question_text,
            userAnswer: answer,
            correctAnswer: currentQuestion.correct_answer,
            isCorrect,
            hintsUsed,
            scaffoldUsed: false // Track this properly in real implementation
        };

        const newResults = [...quizResults, result];
        setQuizResults(newResults);

        // Log question submission for both correct and incorrect answers
        addInteraction({
            interaction_type: 'question_submit',
            question_id: currentQuestion.question_id,
            lesson_id: currentLesson?.lesson_id,
            student_answer: answer,
            is_correct: isCorrect,
            hint_level: hintsUsed
        });

        // Only move to next question if answer is correct
        if (isCorrect) {
            if (currentQuestionIndex < lessonQuestions.length - 1) {
                setCurrentQuestionIndex(currentQuestionIndex + 1);
                startTimer(); // Reset timer for next question
            } else {
                // Quiz complete
                setShowResults(true);
                setShowQuiz(false);
            }
        }

        setShowScaffold(false);
    };

    const handleScaffoldSubmit = (answer: string, isCorrect: boolean) => {
        const currentScaffold = currentScaffolds[currentScaffoldIndex];
        if (!currentScaffold) return;

        if (isCorrect) {
            nextScaffold();
        }
    };

    const handleRetakeQuiz = () => {
        resetQuizState();
        setQuizResults([]);
        setShowResults(false);
        handleStartQuiz();
    };

    const handleContinueLearning = () => {
        resetQuizState();
        setQuizResults([]);
        setShowResults(false);
        router.push('/');
    };

    const components: Components = {
        code({ node, inline, className, children, ...props }: any) {
            const match = /language-(\w+)/.exec(className || '');
            return !inline && match ? (
                <SyntaxHighlighter
                    style={oneLight}
                    language={match[1]}
                    PreTag="div"
                    {...props}
                >
                    {String(children).replace(/\n$/, '')}
                </SyntaxHighlighter>
            ) : (
                <code className={className} {...props}>
                    {children}
                </code>
            );
        },
    };

    if (!currentLesson) {
        return (
            <div className="container mx-auto px-4 py-8">
                <div className="text-center">
                    <p className="text-gray-600">Loading lesson...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="container mx-auto px-4 py-8">
            {/* Back Button */}
            <div className="mb-6">
                <Button variant="ghost" asChild className="flex items-center gap-2">
                    <Link href={`/modules/${currentLesson.module_id}`}>
                        <ArrowLeft className="h-4 w-4" />
                        Back to Module
                    </Link>
                </Button>
            </div>

            {showResults ? (
                <QuizResults
                    results={quizResults}
                    onRetake={handleRetakeQuiz}
                    onContinue={handleContinueLearning}
                />
            ) : showQuiz ? (
                <div className="space-y-6">
                    {showScaffold && currentScaffolds.length > 0 ? (
                        <ScaffoldCard
                            scaffold={currentScaffolds[currentScaffoldIndex]}
                            onSubmit={handleScaffoldSubmit}
                            onClose={() => setShowScaffold(false)}
                            scaffoldNumber={currentScaffoldIndex + 1}
                            totalScaffolds={currentScaffolds.length}
                        />
                    ) : (
                        lessonQuestions[currentQuestionIndex] && (
                            <QuestionCard
                                question={lessonQuestions[currentQuestionIndex]}
                                onSubmit={handleQuestionSubmit}
                                onHint={(level) => requestHint(lessonQuestions[currentQuestionIndex].question_id, level)}
                                onScaffold={() => startScaffold(lessonQuestions[currentQuestionIndex].question_id)}
                                usedHints={usedHints}
                                questionNumber={currentQuestionIndex + 1}
                                totalQuestions={lessonQuestions.length}
                            />
                        )
                    )}
                </div>
            ) : (
                <>
                    {/* Lesson Header */}
                    <div className="mb-8">
                        <Badge variant="secondary" className="mb-2">
                            Lesson Content
                        </Badge>
                        <h1 className="text-3xl font-bold text-gray-900 mb-2">
                            {currentLesson.lesson_name}
                        </h1>
                        <p className="text-gray-600">{currentLesson.description}</p>
                    </div>

                    {/* Lesson Content */}
                    <Card className="mb-8">
                        <CardContent className="prose prose-lg max-w-none p-8">
                            <ReactMarkdown
                                remarkPlugins={[remarkGfm]}
                                components={components}
                            >
                                {currentLesson.content}
                            </ReactMarkdown>
                        </CardContent>
                    </Card>

                    {/* Quiz Section */}
                    {lessonQuestions.length > 0 && (
                        <Card>
                            <CardHeader>
                                <CardTitle className="flex items-center gap-2">
                                    <TestTube className="h-5 w-5" />
                                    Test Your Understanding
                                </CardTitle>
                            </CardHeader>
                            <CardContent>
                                <p className="text-gray-600 mb-4">
                                    Ready to test what you've learned? Take the quiz to check your understanding
                                    and get personalized feedback.
                                </p>
                                <div className="flex items-center gap-4">
                                    <Badge variant="outline">
                                        {lessonQuestions.length} question{lessonQuestions.length !== 1 ? 's' : ''}
                                    </Badge>
                                    <Button onClick={handleStartQuiz} className="flex items-center gap-2">
                                        <CheckCircle className="h-4 w-4" />
                                        Start Quiz
                                    </Button>
                                </div>
                            </CardContent>
                        </Card>
                    )}
                </>
            )}
        </div>
    );
}
