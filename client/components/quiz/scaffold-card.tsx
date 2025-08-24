'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { ArrowRight } from 'lucide-react';
import { Scaffold } from '@/types/api';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import { evaluateAnswerWithLLM } from '@/services/api';

import { logger } from '@/lib/utils';
interface ScaffoldCardProps {
  scaffold: Scaffold;
  onSubmit: (answer: string, isCorrect: boolean) => void;
  onClose: () => void;
  scaffoldNumber: number;
  totalScaffolds: number;
  onContinue?: () => void; // New prop for continuing to next scaffold
}

export function ScaffoldCard({
  scaffold,
  onSubmit,
  onClose,
  scaffoldNumber,
  totalScaffolds,
  onContinue
}: ScaffoldCardProps) {
  const [writtenAnswer, setWrittenAnswer] = useState('');
  const [isEvaluating, setIsEvaluating] = useState(false);
  const [showFeedback, setShowFeedback] = useState(false);
  const [lastAnswer, setLastAnswer] = useState('');
  const [lastIsCorrect, setLastIsCorrect] = useState(false);
  const [llmFeedback, setLlmFeedback] = useState<string | null>(null);
  const [llmAnalysis, setLlmAnalysis] = useState<string | null>(null);

  // Reset state when scaffold changes
  useEffect(() => {
    setShowFeedback(false);
    setWrittenAnswer('');
    setLlmFeedback(null);
    setLlmAnalysis(null);
    setLastAnswer('');
    setLastIsCorrect(false);
  }, [scaffold.scaffoldId]);

  const handleSubmit = async () => {
    if (!writtenAnswer.trim()) return;

    setIsEvaluating(true);
    try {
      // Use LLM evaluation for scaffold attempts
      const llmResult = await evaluateAnswerWithLLM(
        scaffold.scaffoldText, // Use scaffold text as question
        scaffold.scaffoldCorrectAnswer,
        writtenAnswer
      );
      
      // Store the feedback for display
      setLastAnswer(writtenAnswer);
      setLastIsCorrect(llmResult.isCorrect);
      setLlmFeedback(llmResult.feedback);
      setLlmAnalysis(llmResult.detailedAnalysis);
      setShowFeedback(true);
      
      // Truncate answer if it's too long for database (safety measure)
      const truncatedAnswer = writtenAnswer.length > 2000 ? writtenAnswer.substring(0, 2000) + '...' : writtenAnswer;
      onSubmit(truncatedAnswer, llmResult.isCorrect);
    } catch (error) {
      logger.error('Error evaluating scaffold with LLM, falling back to exact matching:', error);
      // Fallback to exact matching if LLM fails
      const isCorrect = writtenAnswer.toLowerCase().trim() === scaffold.scaffoldCorrectAnswer.toLowerCase().trim();
      
      // Store the feedback for display (fallback case)
      setLastAnswer(writtenAnswer);
      setLastIsCorrect(isCorrect);
      setLlmFeedback(isCorrect ? "Correct!" : "Incorrect. Please try again.");
      setLlmAnalysis("LLM evaluation failed - using exact matching fallback");
      setShowFeedback(true);
      
      // Truncate answer if it's too long for database (safety measure)
      const truncatedAnswer = writtenAnswer.length > 2000 ? writtenAnswer.substring(0, 2000) + '...' : writtenAnswer;
      onSubmit(truncatedAnswer, isCorrect);
    } finally {
      setIsEvaluating(false);
    }
  };

  const canSubmit = writtenAnswer.trim() !== '';

  const handleTryAgain = () => {
    setShowFeedback(false);
    setWrittenAnswer('');
    setLlmFeedback(null);
    setLlmAnalysis(null);
  };

  return (
    <Card className="w-full max-w-2xl mx-auto border-orange-200 bg-orange-50/50">
      <CardHeader>
        <div className="flex justify-between items-start">
          <div className="flex-1">
            <div className="flex items-center justify-between mb-2">
              <Badge variant="secondary" className="bg-orange-100 text-orange-800">
                Step {scaffoldNumber} of {totalScaffolds}
              </Badge>
            </div>
            <CardTitle className="text-lg leading-relaxed">
              <div className="prose prose-md max-w-none [&_p]:mb-2 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm [&_pre]:bg-gray-50 [&_pre]:border [&_pre]:border-gray-200 [&_pre]:p-3 [&_pre]:rounded [&_pre]:overflow-x-auto">
                <ReactMarkdown remarkPlugins={[remarkGfm]}>{scaffold.scaffoldText}</ReactMarkdown>
              </div>
            </CardTitle>
          </div>
        </div>
      </CardHeader>

      <CardContent className="space-y-6">
        <div className="space-y-2">
          <label htmlFor="scaffold-answer" className="text-sm font-medium text-gray-700">
            Your Answer:
          </label>
          <Textarea
            id="scaffold-answer"
            placeholder="Type your answer here..."
            value={writtenAnswer}
            onChange={(e) => setWrittenAnswer(e.target.value)}
            className="min-h-[100px]"
          />
        </div>

        {/* Feedback Section */}
        {showFeedback && (
          <div className="mt-4 p-4 bg-gray-50 border border-gray-200 rounded-lg relative">
            {/* Close button */}
            <Button
              variant="ghost"
              size="sm"
              onClick={() => setShowFeedback(false)}
              className="absolute top-2 right-2 h-6 w-6 p-0"
            >
              ✕
            </Button>
            
            <div className="mb-3">
              <h4 className="font-semibold text-gray-900 mb-2">
                {lastIsCorrect ? '✅ Correct!' : '❌ Incorrect'}
              </h4>
              <p className="text-sm text-gray-600 mb-3">
                Your answer: <span className="font-mono bg-gray-100 px-2 py-1 rounded">{lastAnswer}</span>
              </p>
            </div>

            {/* Show LLM feedback */}
            {llmFeedback && (
              <div className="mb-3">
                <h5 className="font-medium text-gray-800 mb-2">AI Feedback:</h5>
                <div className="text-sm text-gray-700 bg-white p-3 rounded border">
                  <div className="prose prose-sm max-w-none [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm [&_code]:text-gray-800 [&_pre]:bg-gray-50 [&_pre]:border [&_pre]:border-gray-200 [&_pre]:p-3 [&_pre]:rounded [&_pre]:overflow-x-auto [&_pre_code]:bg-transparent [&_pre_code]:text-gray-800 [&_pre_code]:px-0 [&_pre_code]:py-0 [&_pre_code]:rounded-none">
                    <ReactMarkdown remarkPlugins={[remarkGfm]}>{llmFeedback}</ReactMarkdown>
                  </div>
                </div>
              </div>
            )}

            {/* Action buttons */}
            <div className="flex justify-end gap-2">
              {!lastIsCorrect && (
                <Button
                  variant="outline"
                  onClick={handleTryAgain}
                  size="sm"
                >
                  Try Again
                </Button>
              )}
              {lastIsCorrect && (
                <Button
                  onClick={onContinue || onClose}
                  size="sm"
                  className="bg-green-600 hover:bg-green-700"
                >
                  {onContinue ? 'Continue to Next Step' : 'Continue'}
                </Button>
              )}
            </div>
          </div>
        )}

        {/* Submit Button - only show when not showing feedback */}
        {!showFeedback && (
          <div className="flex justify-end">
            <Button
              onClick={handleSubmit}
              disabled={!canSubmit || isEvaluating}
              className="flex items-center gap-2"
            >
              {isEvaluating ? 'Evaluating...' : 'Submit Step'}
              {!isEvaluating && <ArrowRight className="h-4 w-4" />}
            </Button>
          </div>
        )}
      </CardContent>
    </Card>
  );
}