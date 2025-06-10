'use client';

import { useEffect, useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Progress } from '@/components/ui/progress';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';
import { User, Brain, Target, Clock, TrendingUp } from 'lucide-react';
import { useAppStore } from '@/lib/store';
import { Table, TableHeader, TableBody, TableRow, TableCell, TableHead } from '@/components/ui/table';
import { formatTimestamp } from '@/lib/utils';

export default function ProfilePage() {
  const {
    user,
    kcMasteries,
    kcs,
    interactions,
    loadData
  } = useAppStore();

  const [showInteractions, setShowInteractions] = useState(false);

  useEffect(() => {
    loadData();
  }, [loadData]);

  if (!user) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center">
          <p className="text-gray-600">Loading profile...</p>
        </div>
      </div>
    );
  }

  const totalInteractions = interactions.length;

  // Calculate accuracy only from question submissions
  const questionSubmissions = interactions.filter(i => i.interaction_type === 'question_submit');
  const correctAnswers = questionSubmissions.filter(i => i.is_correct === true).length;
  const accuracy = questionSubmissions.length > 0 ? Math.round((correctAnswers / questionSubmissions.length) * 100) : 0;

  // Count hints and scaffolds used
  const hintsUsed = interactions.filter(i => i.interaction_type === 'hint_request').length;
  const scaffoldsUsed = interactions.filter(i => i.interaction_type === 'scaffold_request').length;

  return (
    <div className="container mx-auto px-4 py-8">
      {/* Header */}
      <div className="mb-8">
        <div className="flex items-center gap-3 mb-4">
          <div className="bg-blue-600 p-3 rounded-lg">
            <User className="h-6 w-6 text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold text-gray-900">Learning Profile</h1>
            <p className="text-gray-600">Track your progress and mastery levels</p>
          </div>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-5 gap-6 mb-8">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Interactions</CardTitle>
            <Brain className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{totalInteractions}</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Accuracy</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{accuracy}%</div>
            <p className="text-xs text-muted-foreground mt-1">
              {correctAnswers} correct out of {questionSubmissions.length} submissions
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Hints Used</CardTitle>
            <Clock className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{hintsUsed}</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Scaffolds Used</CardTitle>
            <Clock className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{scaffoldsUsed}</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Avg Mastery</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {kcMasteries.length > 0
                ? Math.round((kcMasteries.reduce((sum, kc) => sum + kc.p_mastery, 0) / kcMasteries.length) * 100)
                : 0}%
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              Average across {kcMasteries.length} knowledge components
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Interactions Button */}
      <div className="mb-8">
        <button
          className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition"
          onClick={() => setShowInteractions((v) => !v)}
        >
          {showInteractions ? 'Hide' : 'Show'} Interactions
        </button>
      </div>

      {/* Interactions Table */}
      {showInteractions && (
        <Card className="mb-8">
          <CardHeader>
            <CardTitle>Interactions</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="overflow-x-auto">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Type</TableHead>
                    <TableHead>Lesson</TableHead>
                    <TableHead>Question</TableHead>
                    <TableHead>Hint Level</TableHead>
                    <TableHead>Scaffold</TableHead>
                    <TableHead>Correct</TableHead>
                    <TableHead>Answer</TableHead>
                    <TableHead>Time</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {interactions.map((i, idx) => (
                    <TableRow key={idx}>
                      <TableCell>{i.interaction_type}</TableCell>
                      <TableCell>{i.lesson_id ?? '-'}</TableCell>
                      <TableCell>{i.question_id ?? '-'}</TableCell>
                      <TableCell>{i.hint_level ?? '-'}</TableCell>
                      <TableCell>{i.scaffold_id ?? '-'}</TableCell>
                      <TableCell>{i.is_correct === true ? '✔️' : i.is_correct === false ? '❌' : '-'}</TableCell>
                      <TableCell>{i.student_answer ?? '-'}</TableCell>
                      <TableCell>{formatTimestamp(i.timestamp) ?? '-'}</TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Knowledge Component Mastery */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Brain className="h-5 w-5" />
            Knowledge Component Mastery
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          {kcMasteries.map((mastery) => {
            const kc = kcs.find(k => k.kc_id === mastery.kc_id);
            if (!kc) return null;

            const masteryPercentage = Math.round(mastery.p_mastery * 100);
            const guessPercentage = Math.round(mastery.p_guess * 100);
            const slipPercentage = Math.round(mastery.p_slip * 100);
            const transitPercentage = Math.round(mastery.p_transit * 100);

            return (
              <div key={mastery.kc_id} className="space-y-3">
                <div className="flex items-center justify-between">
                  <div>
                    <h3 className="font-medium">{kc.kc_name}</h3>
                    <p className="text-sm text-gray-600">{kc.description}</p>
                  </div>
                  <Badge variant={masteryPercentage >= 70 ? "default" : "secondary"}>
                    {masteryPercentage}% Mastery
                  </Badge>
                </div>

                <div className="space-y-2">
                  <div className="flex justify-between text-sm">
                    <span>Mastery Level</span>
                    <span className="font-medium">{masteryPercentage}%</span>
                  </div>
                  <Progress value={masteryPercentage} className="h-2" />
                </div>

                <div className="grid grid-cols-3 gap-4 text-sm">
                  <div className="text-center">
                    <div className="font-medium text-orange-600">{guessPercentage}%</div>
                    <div className="text-gray-500">Guess Rate</div>
                  </div>
                  <div className="text-center">
                    <div className="font-medium text-red-600">{slipPercentage}%</div>
                    <div className="text-gray-500">Slip Rate</div>
                  </div>
                  <div className="text-center">
                    <div className="font-medium text-green-600">{transitPercentage}%</div>
                    <div className="text-gray-500">Learn Rate</div>
                  </div>
                </div>

                <Separator />
              </div>
            );
          })}
        </CardContent>
      </Card>
    </div>
  );
}