'use client';

import React, { useState, useEffect } from 'react';
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
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import { useLearningStore } from '@/lib/stores';

interface QuestionCardProps {
  question: Question;
  onSubmit: (answer: string, isCorrect: boolean) => void;
  onHint: (level: number) => void;
  onScaffold: () => void;
  onScaffoldUsage: (scaffoldId: string) => void;
  onScaffoldSubmit: (scaffoldId: string, answer: string, isCorrect: boolean) => void;
  onSkip: () => void;
  usedHints: Set<string>;
  questionNumber: number;
  totalQuestions: number;
}

export function QuestionCard({
  question,
  onSubmit,
  onHint,
  onScaffold,
  onScaffoldUsage,
  onScaffoldSubmit,
  onSkip,
  usedHints,
  questionNumber,
  totalQuestions
}: QuestionCardProps) {
  const { currentLesson } = useLearningStore();

  const [selectedAnswer, setSelectedAnswer] = useState('');
  const [writtenAnswer, setWrittenAnswer] = useState('');
  const [showHint1, setShowHint1] = useState(false);
  const [showHint2, setShowHint2] = useState(false);
  const [showExplanation, setShowExplanation] = useState(false);
  const [lastAnswer, setLastAnswer] = useState('');
  const [lastIsCorrect, setLastIsCorrect] = useState(false);

  // State for scaffolding accordion
  const [showScaffoldContainer, setShowScaffoldContainer] = useState(false);
  const [activeScaffoldValue, setActiveScaffoldValue] = useState<string | undefined>(undefined);
  const [unlockedScaffoldIndex, setUnlockedScaffoldIndex] = useState(0);

  // Return loading state if question is undefined
  if (!question) {
    return (
      <Card className="w-full max-w-2xl mx-auto">
        <CardContent className="flex items-center justify-center p-8">
          <p className="text-gray-600">Loading question...</p>
        </CardContent>
      </Card>
    );
  }

  const scaffolds = question.scaffolds || [];

  useEffect(() => {
    // Reset state when question changes
    setSelectedAnswer('');
    setWrittenAnswer('');
    setShowHint1(false);
    setShowHint2(false);
    setShowScaffoldContainer(false);
    setActiveScaffoldValue(undefined);
    setUnlockedScaffoldIndex(0);
    setShowExplanation(false);
    setLastAnswer('');
    setLastIsCorrect(false);
  }, [question.question_id]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const answer = question.type === 'MULTIPLE_CHOICE' ? selectedAnswer : writtenAnswer;
    if (!answer.trim()) return;
    
    let isCorrect = false;
    if (question.type === 'MULTIPLE_CHOICE') {
      isCorrect = answer === question.correct_option_key;
    } else {
      isCorrect = answer.toLowerCase().trim() === question.correct_answer_text.toLowerCase().trim();
    }

    // Store the answer and result for explanation display
    setLastAnswer(answer);
    setLastIsCorrect(isCorrect);
    setShowExplanation(true);

    if (isCorrect) {
      toast.success("Correct! Great job! Moving to the next question.");
    } else {
      toast.error("Incorrect. That's not quite right. Try again!");
    }
    // Call onSubmit for both correct and incorrect answers
    onSubmit(answer, isCorrect);
  };

  const handleContinue = () => {
    setShowExplanation(false);
    setShowHint1(false);
    setShowHint2(false);
    setShowScaffoldContainer(false);
  };

  const handleSkip = () => {
    // Call the parent skip handler for tracking
    onSkip();

    // Call onSubmit with empty answer to move to next question
    onSubmit('', false);
  };

  const handleHint = (level: number) => {
    onHint(level);
    if (level === 1) {
      setShowHint1(true);
    }
    if (level === 2) {
      setShowHint2(true);
    }
  };

  const handleStartScaffold = () => {
    // Call the parent scaffold handler for tracking
    onScaffold();
    
    // Don't hide hints - keep them visible once unlocked
    // setShowHint1(false);
    // setShowHint2(false);
    
    setShowScaffoldContainer(true);
    setActiveScaffoldValue(undefined);
    setUnlockedScaffoldIndex(0);
  };

  const handleScaffoldSubmit = (scaffoldData: Scaffold, answer: string, isCorrect: boolean, scaffoldIndex: number) => {
    // Call the parent scaffold submit handler for tracking
    onScaffoldSubmit(scaffoldData.scaffoldId, answer, isCorrect);

    if (isCorrect) {
      toast.success("Correct! Great job! Moving to the next step.");
      setUnlockedScaffoldIndex(prev => Math.max(prev, scaffoldIndex + 1));
      if (scaffoldIndex < scaffolds.length - 1) {
        setTimeout(() => {
          setActiveScaffoldValue(`scaffold-${scaffoldIndex + 1}`);
        }, 100);
      } else {
        setActiveScaffoldValue(undefined);
      }
    } else {
      toast.error("Incorrect. That's not quite right. Try again!");
    }
  };

  const handleScaffoldView = (scaffoldId: string) => {
    // Log scaffold view using the parent handler
    onScaffoldUsage(scaffoldId);
  };

  const canSubmit = question.type === 'MULTIPLE_CHOICE'
    ? selectedAnswer !== ''
    : writtenAnswer.trim() !== '';

  const hint1Used = usedHints.has(`${question.question_id}-1`);
  const hint2Used = usedHints.has(`${question.question_id}-2`);

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <div className="flex justify-between items-start">
          <div className="flex-1">
            <div className="flex items-center gap-2 mb-2">
              <Badge variant="outline">
                Question {questionNumber} of {totalQuestions}
              </Badge>
            </div>
            <CardTitle className="text-lg leading-relaxed">
              <div className="prose prose-md max-w-none [&_p]:mb-2 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm [&_pre]:bg-gray-50 [&_pre]:border [&_pre]:border-gray-200 [&_pre]:p-3 [&_pre]:rounded [&_pre]:overflow-x-auto">
                <ReactMarkdown remarkPlugins={[remarkGfm]}>{question.question_text}</ReactMarkdown>
              </div>
            </CardTitle>
          </div>
        </div>
      </CardHeader>

      <CardContent className="space-y-6">
        {question.type === 'MULTIPLE_CHOICE' ? (
          <RadioGroup value={selectedAnswer} onValueChange={setSelectedAnswer}>
            {question.options?.map((option: any, index: number) => (
              <div key={index} className="flex items-center space-x-2">
                <RadioGroupItem value={option.option_key} id={`option-${index}-${question.question_id}`} />
                <Label htmlFor={`option-${index}-${question.question_id}`} className="flex-1 cursor-pointer">
                  <div className="prose prose-sm max-w-none [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm">
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
              value={writtenAnswer}
              onChange={(e) => setWrittenAnswer(e.target.value)}
              className="min-h-[100px]"
            />
          </div>
        )}

        {/* Hints and Scaffolding Section */}
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

          {showHint1 && question.hint_level_1 && (
            <div className="p-3 bg-blue-50 border border-blue-200 rounded-md mt-2">
              <div className="text-sm text-blue-800">
                <strong>Hint 1:</strong> 
                <div className="prose prose-sm max-w-none mt-1 [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-blue-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm">
                  <ReactMarkdown remarkPlugins={[remarkGfm]}>{question.hint_level_1}</ReactMarkdown>
                </div>
              </div>
            </div>
          )}
          {showHint2 && question.hint_level_2 && (
            <div className="p-3 bg-blue-50 border border-blue-200 rounded-md mt-2">
              <div className="text-sm text-blue-800">
                <strong>Hint 2:</strong> 
                <div className="prose prose-sm max-w-none mt-1 [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-blue-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm">
                  <ReactMarkdown remarkPlugins={[remarkGfm]}>{question.hint_level_2}</ReactMarkdown>
                </div>
              </div>
            </div>
          )}

          {/* Scaffolding Accordion */}
          {showScaffoldContainer && scaffolds.length > 0 && (
            <Accordion
              type="single"
              collapsible
              className="w-full mt-4"
              value={activeScaffoldValue}
              onValueChange={(value) => {
                setActiveScaffoldValue(value);
                if (value) {
                  const scaffoldIndex = parseInt(value.split('-')[1]);
                  handleScaffoldView(scaffolds[scaffoldIndex].scaffoldId);
                }
              }}
            >
              {scaffolds.map((scaffold, idx) => (
                <AccordionItem
                  value={`scaffold-${idx}`}
                  key={scaffold.scaffoldId}
                  disabled={idx > unlockedScaffoldIndex}
                >
                  <AccordionTrigger disabled={idx > unlockedScaffoldIndex}>
                    Step {idx + 1}
                  </AccordionTrigger>
                  <AccordionContent>
                    <ScaffoldCard
                      scaffold={scaffold}
                      onSubmit={(answer, isCorrect) => handleScaffoldSubmit(scaffold, answer, isCorrect, idx)}
                      onClose={() => setActiveScaffoldValue(undefined)}
                      scaffoldNumber={idx + 1}
                      totalScaffolds={scaffolds.length}
                    />
                  </AccordionContent>
                </AccordionItem>
              ))}
            </Accordion>
          )}

          {/* Answer Explanation Section */}
          {showExplanation && (
            <div className="mt-4 p-4 bg-gray-50 border border-gray-200 rounded-lg">
              <div className="mb-3">
                <h4 className="font-semibold text-gray-900 mb-2">
                  {lastIsCorrect ? '✅ Correct!' : '❌ Incorrect'}
                </h4>
                <p className="text-sm text-gray-600 mb-3">
                  Your answer: <span className="font-mono bg-gray-100 px-2 py-1 rounded">{lastAnswer}</span>
                </p>
              </div>

              {/* Show option explanation for multiple choice questions */}
              {question.type === 'MULTIPLE_CHOICE' && lastAnswer && (
                <div className="mb-3">
                  <h5 className="font-medium text-gray-800 mb-2">Explanation for your choice:</h5>
                  <div className="text-sm text-gray-700 bg-white p-3 rounded border">
                    {(() => {
                      const selectedOption = question.options?.find(opt => opt.option_key === lastAnswer);
                      if (selectedOption?.option_explanation) {
                        return (
                          <div className="prose prose-sm max-w-none [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm">
                            <ReactMarkdown remarkPlugins={[remarkGfm]}>{selectedOption.option_explanation}</ReactMarkdown>
                          </div>
                        );
                      }
                      return <span className="text-gray-500 italic">No explanation available for this option.</span>;
                    })()}
                  </div>
                </div>
              )}

              {/* Show answer explanation for written questions */}
              {question.type === 'WRITTEN' && 'answer_explanation' in question && question.answer_explanation && (
                <div className="mb-3">
                  <h5 className="font-medium text-gray-800 mb-2">Answer Explanation:</h5>
                  <div className="text-sm text-gray-700 bg-white p-3 rounded border">
                    <div className="prose prose-sm max-w-none [&_p]:mb-1 [&_p:last-child]:mb-0 [&_code]:bg-gray-100 [&_code]:px-1 [&_code]:py-0.5 [&_code]:rounded [&_code]:text-sm">
                      <ReactMarkdown remarkPlugins={[remarkGfm]}>{question.answer_explanation}</ReactMarkdown>
                    </div>
                  </div>
                </div>
              )}

              <Button onClick={handleContinue} className="w-full">
                Continue
              </Button>
            </div>
          )}
        </div>

        <div className="flex justify-end gap-2">
          <Button
            variant="ghost"
            onClick={handleSkip}
            disabled={showExplanation}
          >
            Skip
          </Button>
          <Button
            onClick={handleSubmit}
            disabled={!canSubmit || showExplanation}
            className="flex items-center gap-2"
          >
            Submit Answer
            <ArrowRight className="h-4 w-4" />
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}