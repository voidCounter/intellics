'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { HelpCircle, Lightbulb, ArrowRight } from 'lucide-react';
import { Question, Scaffold } from '@/lib/store';
import { ScaffoldCard } from './scaffold-card';
import { toast } from 'sonner';
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import { useAppStore } from '@/lib/store';

interface QuestionCardProps {
  question: Question;
  onSubmit: (answer: string, isCorrect: boolean) => void;
  onHint: (level: number) => void;
  onScaffold: () => void;
  usedHints: Set<string>;
  questionNumber: number;
  totalQuestions: number;
}

export function QuestionCard({
  question,
  onSubmit,
  onHint,
  onScaffold,
  usedHints,
  questionNumber,
  totalQuestions
}: QuestionCardProps) {
  const {
    addInteraction,
    currentLesson
  } = useAppStore();

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

  const [selectedAnswer, setSelectedAnswer] = useState('');
  const [writtenAnswer, setWrittenAnswer] = useState('');
  const [showHint1, setShowHint1] = useState(false);
  const [showHint2, setShowHint2] = useState(false);

  // State for scaffolding accordion
  const [showScaffoldContainer, setShowScaffoldContainer] = useState(false);
  const [activeScaffoldValue, setActiveScaffoldValue] = useState<string | undefined>(undefined);
  const [unlockedScaffoldIndex, setUnlockedScaffoldIndex] = useState(0);

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
  }, [question.question_id]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const answer = question.question_type === 'multiple_choice' ? selectedAnswer : writtenAnswer;
    if (!answer.trim()) return;
    const isCorrect = answer.toLowerCase().trim() === question.correct_answer.toLowerCase().trim();

    if (isCorrect) {
      toast.success("Correct! Great job! Moving to the next question.");
    } else {
      toast.error("Incorrect. That's not quite right. Try again!");
    }
    // Call onSubmit for both correct and incorrect answers
    onSubmit(answer, isCorrect);
  };

  const handleHint = (level: number) => {
    onHint(level);
    if (level === 1) setShowHint1(true);
    if (level === 2) setShowHint2(true);
  };

  const handleStartScaffold = () => {
    setShowHint1(false);
    setShowHint2(false);
    setShowScaffoldContainer(true);
    setActiveScaffoldValue(undefined);
    setUnlockedScaffoldIndex(0);
  };

  const handleScaffoldSubmit = (scaffoldData: Scaffold, answer: string, isCorrect: boolean, scaffoldIndex: number) => {
    // Log scaffold answer
    addInteraction({
      interaction_type: 'scaffold_answer',
      scaffold_id: scaffoldData.scaffold_id,
      question_id: scaffoldData.question_id,
      lesson_id: currentLesson?.lesson_id,
      student_answer: answer,
      is_correct: isCorrect
    });

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

  const handleScaffoldView = (scaffoldId: number) => {
    // Log scaffold view
    addInteraction({
      interaction_type: 'scaffold_request',
      scaffold_id: scaffoldId,
      question_id: question.question_id,
      lesson_id: currentLesson?.lesson_id
    });
  };

  const canSubmit = question.question_type === 'multiple_choice'
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
              {question.question_text}
            </CardTitle>
          </div>
        </div>
      </CardHeader>

      <CardContent className="space-y-6">
        {question.question_type === 'multiple_choice' ? (
          <RadioGroup value={selectedAnswer} onValueChange={setSelectedAnswer}>
            {question.options?.map((option, index) => (
              <div key={index} className="flex items-center space-x-2">
                <RadioGroupItem value={option} id={`option-${index}-${question.question_id}`} />
                <Label htmlFor={`option-${index}-${question.question_id}`} className="flex-1 cursor-pointer">
                  {option}
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
                className="flex items-center gap-1"
              >
                <Lightbulb className="h-4 w-4" />
                Need Help?
              </Button>
            )}
          </div>

          {showHint1 && question.hint_level_1 && (
            <div className="p-3 bg-blue-50 border border-blue-200 rounded-md mt-2">
              <p className="text-sm text-blue-800">
                <strong>Hint 1:</strong> {question.hint_level_1}
              </p>
            </div>
          )}
          {showHint2 && question.hint_level_2 && (
            <div className="p-3 bg-blue-50 border border-blue-200 rounded-md mt-2">
              <p className="text-sm text-blue-800">
                <strong>Hint 2:</strong> {question.hint_level_2}
              </p>
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
                  handleScaffoldView(scaffolds[scaffoldIndex].scaffold_id);
                }
              }}
            >
              {scaffolds.map((scaffold, idx) => (
                <AccordionItem
                  value={`scaffold-${idx}`}
                  key={scaffold.scaffold_id}
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
        </div>

        <div className="flex justify-end">
          <Button
            onClick={handleSubmit}
            disabled={!canSubmit}
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