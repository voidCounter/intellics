import { create } from 'zustand';
import { KCMastery, UserInteraction } from '@/types/api';

export interface ProgressState {
  kcMasteries: KCMastery[];
  userInteractions: UserInteraction[];
  
  // Actions
  setKCMasteries: (kcMasteries: KCMastery[]) => void;
  setUserInteractions: (userInteractions: UserInteraction[]) => void;

  // Utility getters
  getKCMasteryByKCId: (kcId: string) => KCMastery | undefined;
  getUserInteractionsByKCId: (kcId: string) => UserInteraction[];
  getUserInteractionsByLessonId: (lessonId: string) => UserInteraction[];
  
  resetProgress: () => void;
}

export const useProgressStore = create<ProgressState>()((set, get) => ({
  // Initial state
  kcMasteries: [],
  userInteractions: [],
  
  // Actions
  setKCMasteries: (kcMasteries) => set({ kcMasteries }),
  setUserInteractions: (userInteractions) => set({ userInteractions }),

  // Utility getters
  getKCMasteryByKCId: (kcId: string) => {
    return get().kcMasteries.find(mastery => mastery.kc_id === kcId);
  },

  getUserInteractionsByKCId: (kcId: string) => {
    return get().userInteractions.filter(interaction => 
      interaction.kc_mappings?.some(mapping => mapping.kc_id === kcId)
    );
  },

  getUserInteractionsByLessonId: (lessonId: string) => {
    return get().userInteractions.filter(interaction => 
      interaction.lesson_id === lessonId
    );
  },

  resetProgress: () => {
    set({
      kcMasteries: [],
      userInteractions: [],
    });
  }
}));
