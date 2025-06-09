'use client';

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { CheckCircle, XCircle, Trophy, RotateCcw } from 'lucide-react';
import { formatTimestamp } from '@/lib/utils';

interface QuizResult {
  questionId: number;
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
  const correctAnswers = results.filter(r => r.isCorrect).length;
  const totalQuestions = results.length;
  const score = Math.round((correctAnswers / totalQuestions) * 100);

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle>Quiz Results</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          {results.map((result, index) => (
            <div key={index} className="p-4 border rounded-lg">
              <div className="flex justify-between items-start mb-2">
                <h3 className="font-medium">Question {index + 1}</h3>
                <Badge variant={result.isCorrect ? "default" : "destructive"}>
                  {result.isCorrect ? "Correct" : "Incorrect"}
                </Badge>
              </div>
              <p className="text-gray-600 mb-2">{result.questionText}</p>
              <div className="space-y-1 text-sm">
                <p>Your answer: {result.userAnswer}</p>
                {!result.isCorrect && (
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