'use client';

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { CheckCircle, XCircle, Trophy, RotateCcw } from 'lucide-react';
import { formatTimestamp } from '@/lib/utils';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';

interface QuizResult {
  questionId: string;
  questionText: string;
  userAnswer: string;
  correctAnswer: string;
  isCorrect: boolean;
  hintsUsed: number;
  scaffoldUsed: boolean;
}

interface QuizResultsProps {
  results: QuizResult[];
  onRetake: () => void;
  onContinue: () => void;
}

export function QuizResults({ results, onRetake, onContinue }: QuizResultsProps) {
  const answeredQuestions = results.filter(r => r.userAnswer !== 'Skipped');
  const correctAnswers = answeredQuestions.filter(r => r.isCorrect).length;
  const totalAnswered = answeredQuestions.length;
  const skippedQuestions = results.filter(r => r.userAnswer === 'Skipped').length;
  const score = totalAnswered > 0 ? Math.round((correctAnswers / totalAnswered) * 100) : 0;

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle>Quiz Results</CardTitle>
      </CardHeader>
      <CardContent>
        {/* Summary Section */}
        <div className="mb-6 p-4 bg-gray-50 rounded-lg">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-center">
            <div>
              <div className="text-2xl font-bold text-blue-600">{score}%</div>
              <div className="text-sm text-gray-600">Score</div>
            </div>
            <div>
              <div className="text-2xl font-bold text-green-600">{correctAnswers}/{totalAnswered}</div>
              <div className="text-sm text-gray-600">Correct Answers</div>
            </div>
            <div>
              <div className="text-2xl font-bold text-gray-600">{skippedQuestions}</div>
              <div className="text-sm text-gray-600">Skipped</div>
            </div>
          </div>
        </div>

        <div className="space-y-4">
          {results.map((result, index) => (
            <div key={index} className="p-4 border rounded-lg">
              <div className="flex justify-between items-start mb-2">
                <h3 className="font-medium">Question {index + 1}</h3>
                <Badge variant={
                  result.userAnswer === 'Skipped' ? "secondary" : 
                  result.isCorrect ? "default" : "destructive"
                }>
                  {result.userAnswer === 'Skipped' ? "Skipped" : 
                   result.isCorrect ? "Correct" : "Incorrect"}
                </Badge>
              </div>
              <div className="prose prose-sm max-w-none [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm">
                <ReactMarkdown remarkPlugins={[remarkGfm]}>{result.questionText}</ReactMarkdown>
              </div>
              <div className="space-y-1 text-sm">
                <p>Your answer: {result.userAnswer}</p>
                {result.userAnswer !== 'Skipped' && !result.isCorrect && (
                  <p className="text-green-600">Correct answer: {result.correctAnswer}</p>
                )}
                {result.hintsUsed > 0 && (
                  <p className="text-amber-600">Hints used: {result.hintsUsed}</p>
                )}
                {result.scaffoldUsed && (
                  <p className="text-blue-600">Scaffolding used</p>
                )}
              </div>
            </div>
          ))}
        </div>
        <div className="flex justify-end gap-4 mt-6">
          <Button variant="outline" onClick={onRetake}>
            Retake Quiz
          </Button>
          <Button onClick={onContinue}>
            Continue Learning
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}