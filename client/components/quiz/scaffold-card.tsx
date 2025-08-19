'use client';

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { ArrowRight } from 'lucide-react';
import { Scaffold } from '@/types/api';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';

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
  const [writtenAnswer, setWrittenAnswer] = useState('');

  const handleSubmit = () => {
    if (!writtenAnswer.trim()) return;

    const isCorrect = writtenAnswer.toLowerCase().trim() === scaffold.scaffoldCorrectAnswer.toLowerCase().trim();
    onSubmit(writtenAnswer, isCorrect);
  };

  const canSubmit = writtenAnswer.trim() !== '';

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