import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { Lesson } from '@/types/api';

export interface LearningState {
  // Current lesson state
  currentLesson: Lesson | null;
  showQuiz: boolean;
  
  // Actions
  setCurrentLesson: (lesson: Lesson | null) => void;
  setShowQuiz: (show: boolean) => void;
  
  resetLearning: () => void;
}

export const useLearningStore = create<LearningState>()(
  persist(
    (set) => ({
      // Initial state
      currentLesson: null,
      showQuiz: false,

      // Actions
      setCurrentLesson: (lesson: Lesson | null) => set({ currentLesson: lesson }),
      setShowQuiz: (show: boolean) => set({ showQuiz: show }),

      resetLearning: () => {
        set({
          currentLesson: null,
          showQuiz: false,
        });
      }
    }),
    {
      name: 'intellics-learning-storage',
      partialize: (state) => ({
        currentLesson: state.currentLesson,
        showQuiz: state.showQuiz,
      })
    }
  )
);
