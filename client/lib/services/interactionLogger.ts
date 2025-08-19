import React, { useEffect } from 'react';
import { InteractionType } from '@/types/api';
import { useSessionStore } from '@/lib/stores/session-store';

interface InteractionData {
  interaction_type: InteractionType;
  lesson_id?: string;
  module_id?: string;
  question_id?: string;
  scaffold_id?: string;
  student_answer?: string;
  is_correct?: boolean;
  hint_level?: number;
  time_spent_seconds?: number;
  session_id?: string;
}

export class InteractionLogger {
  // No client-side deduplication needed - backend handles it properly
  
  private async sendInteraction(data: InteractionData): Promise<void> {
    try {
      const token = localStorage.getItem('authToken');
      if (!token) {
        console.error('No auth token found for interaction logging');
        return;
      }

      console.log('Sending interaction to /api/interactions:', data);

      const response = await fetch('/api/interactions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify(data),
      });

      console.log('Response status:', response.status, response.statusText);

      if (!response.ok) {
        const errorText = await response.text();
        console.error('Response error text:', errorText);
        throw new Error(`Failed to log interaction: ${response.statusText} - ${errorText}`);
      }

      const responseData = await response.json();
      console.log('Interaction logged successfully:', data.interaction_type, responseData);
    } catch (error) {
      console.error('Failed to log interaction:', error);
    }
  }

  // Question interactions
  public async logQuestionPresented(sessionId: string, questionId: string, lessonId?: string, moduleId?: string): Promise<void> {
    if (!sessionId) {
      console.warn('No session ID provided for question presented logging');
      return;
    }

    await this.sendInteraction({
      interaction_type: InteractionType.QUESTION_PRESENTED,
      question_id: questionId,
      lesson_id: lessonId,
      module_id: moduleId,
      session_id: sessionId,
      time_spent_seconds: 0
    });
  }

  public async logQuestionAttempted(
    sessionId: string,
    questionId: string, 
    answer: string, 
    isCorrect: boolean, 
    lessonId?: string, 
    moduleId?: string,
    timeSpentSeconds?: number
  ): Promise<void> {
    if (!sessionId) {
      console.warn('No session ID provided for question attempted logging');
      return;
    }

    await this.sendInteraction({
      interaction_type: InteractionType.QUESTION_ATTEMPTED,
      question_id: questionId,
      lesson_id: lessonId,
      module_id: moduleId,
      session_id: sessionId,
      student_answer: answer,
      is_correct: isCorrect,
      time_spent_seconds: timeSpentSeconds || 0
    });
  }

  public async logQuestionSkipped(
    sessionId: string,
    questionId: string, 
    lessonId?: string, 
    moduleId?: string,
    timeSpentSeconds?: number
  ): Promise<void> {
    if (!sessionId) {
      console.warn('No session ID provided for question skipped logging');
      return;
    }

    await this.sendInteraction({
      interaction_type: InteractionType.QUESTION_SKIPPED,
      question_id: questionId,
      lesson_id: lessonId,
      module_id: moduleId,
      session_id: sessionId,
      time_spent_seconds: timeSpentSeconds || 0
    });
  }

  // Hint interactions
  public async logHintRequested(
    sessionId: string,
    questionId: string, 
    hintLevel: number, 
    lessonId?: string, 
    moduleId?: string
  ): Promise<void> {
    if (!sessionId) {
      console.warn('No session ID provided for hint requested logging');
      return;
    }

    await this.sendInteraction({
      interaction_type: InteractionType.HINT_REQUESTED,
      question_id: questionId,
      lesson_id: lessonId,
      module_id: moduleId,
      session_id: sessionId,
      hint_level: hintLevel,
      time_spent_seconds: 0
    });
  }

  // Scaffold interactions
  public async logScaffoldRequested(
    sessionId: string,
    questionId: string, 
    scaffoldId: string, 
    lessonId?: string, 
    moduleId?: string
  ): Promise<void> {
    if (!sessionId) {
      console.warn('No session ID provided for scaffold requested logging');
      return;
    }

    await this.sendInteraction({
      interaction_type: InteractionType.SCAFFOLD_REQUESTED,
      question_id: questionId,
      scaffold_id: scaffoldId,
      lesson_id: lessonId,
      module_id: moduleId,
      session_id: sessionId,
      time_spent_seconds: 0
    });
  }

  public async logScaffoldAttempted(
    sessionId: string,
    questionId: string, 
    scaffoldId: string, 
    answer: string, 
    isCorrect: boolean, 
    lessonId?: string, 
    moduleId?: string,
    timeSpentSeconds?: number
  ): Promise<void> {
    if (!sessionId) {
      console.warn('No session ID provided for scaffold attempted logging');
      return;
    }

    await this.sendInteraction({
      interaction_type: InteractionType.SCAFFOLD_ATTEMPTED,
      question_id: questionId,
      scaffold_id: scaffoldId,
      lesson_id: lessonId,
      module_id: moduleId,
      session_id: sessionId,
      student_answer: answer,
      is_correct: isCorrect,
      time_spent_seconds: timeSpentSeconds || 0
    });
  }

  // Lesson interactions
  public async logLessonStart(sessionId: string, lessonId: string, moduleId?: string): Promise<void> {
    if (!sessionId) {
      console.warn('No session ID provided for lesson start logging');
      return;
    }

    await this.sendInteraction({
      interaction_type: InteractionType.LESSON_START,
      lesson_id: lessonId,
      module_id: moduleId,
      session_id: sessionId,
      time_spent_seconds: 0
    });
  }

  public async logLessonExit(
    sessionId: string,
    lessonId: string, 
    moduleId?: string, 
    timeSpentSeconds?: number
  ): Promise<void> {
    if (!sessionId) {
      console.warn('No session ID provided for lesson exit logging');
      return;
    }

    await this.sendInteraction({
      interaction_type: InteractionType.LESSON_EXIT,
      lesson_id: lessonId,
      module_id: moduleId,
      session_id: sessionId,
      time_spent_seconds: timeSpentSeconds || 0
    });
  }

  // Scaffold answer interaction
  public async logScaffoldAnswer(
    sessionId: string,
    questionId: string, 
    scaffoldId: string, 
    answer: string, 
    isCorrect: boolean, 
    lessonId?: string, 
    moduleId?: string,
    timeSpentSeconds?: number
  ): Promise<void> {
    if (!sessionId) {
      console.warn('No session ID provided for scaffold answer logging');
      return;
    }

    await this.sendInteraction({
      interaction_type: InteractionType.SCAFFOLD_ANSWER,
      question_id: questionId,
      scaffold_id: scaffoldId,
      lesson_id: lessonId,
      module_id: moduleId,
      session_id: sessionId,
      student_answer: answer,
      is_correct: isCorrect,
      time_spent_seconds: timeSpentSeconds || 0
    });
  }
}

// Export singleton instance
export const interactionLogger = new InteractionLogger();

// Hook to get the interaction logger
export function useInteractionLogger() {
  return interactionLogger;
}
