'use client';

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { ArrowRight, X } from 'lucide-react';
import { Scaffold } from '@/lib/store';

interface ScaffoldCardProps {
  scaffold: Scaffold;
  onSubmit: (answer: string, isCorrect: boolean) => void;
  onClose: () => void;
  scaffoldNumber: number;
  totalScaffolds: number;
}

export function ScaffoldCard({
  scaffold,
  onSubmit,
  onClose,
  scaffoldNumber,
  totalScaffolds
}: ScaffoldCardProps) {
  const [selectedAnswer, setSelectedAnswer] = useState('');
  const [writtenAnswer, setWrittenAnswer] = useState('');

  const handleSubmit = () => {
    const answer = scaffold.scaffold_type === 'multiple_choice' ? selectedAnswer : writtenAnswer;
    if (!answer.trim()) return;

    const isCorrect = answer.toLowerCase().trim() === scaffold.correct_answer.toLowerCase().trim();
    onSubmit(answer, isCorrect);
  };

  const canSubmit = scaffold.scaffold_type === 'multiple_choice'
    ? selectedAnswer !== ''
    : writtenAnswer.trim() !== '';

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
              {scaffold.scaffold_text}
            </CardTitle>
          </div>
        </div>
      </CardHeader>

      <CardContent className="space-y-6">
        {scaffold.scaffold_type === 'multiple_choice' ? (
          <RadioGroup value={selectedAnswer} onValueChange={setSelectedAnswer}>
            {scaffold.options?.map((option, index) => (
              <div key={index} className="flex items-center space-x-2">
                <RadioGroupItem value={option} id={`scaffold-option-${index}`} />
                <Label htmlFor={`scaffold-option-${index}`} className="flex-1 cursor-pointer">
                  {option}
                </Label>
              </div>
            ))}
          </RadioGroup>
        ) : (
          <div className="space-y-2">
            <Label htmlFor="scaffold-answer">Your Answer:</Label>
            <Textarea
              id="scaffold-answer"
              placeholder="Type your answer here..."
              value={writtenAnswer}
              onChange={(e) => setWrittenAnswer(e.target.value)}
              className="min-h-[100px]"
            />
          </div>
        )}

        <div className="flex justify-end">
          <Button
            onClick={handleSubmit}
            disabled={!canSubmit}
            className="flex items-center gap-2"
          >
            Submit Step
            <ArrowRight className="h-4 w-4" />
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}