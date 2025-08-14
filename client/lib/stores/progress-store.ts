import { create } from 'zustand';
import { KCMastery, UserInteraction, ApiResponse } from '@/types/api';

export interface ProgressState {
  // Progress data
  kcMasteries: KCMastery[];
  userInteractions: UserInteraction[];

  // Actions
  setKCMasteries: (kcMasteries: KCMastery[]) => void;
  setUserInteractions: (userInteractions: UserInteraction[]) => void;
  
  // Interaction tracking
  addInteraction: (interaction: Omit<UserInteraction, 'interaction_id' | 'timestamp'>) => Promise<void>;
  
  // Utility getters
  getKCMasteryByKCId: (kcId: string) => KCMastery | undefined;
  getUserInteractionsByKCId: (kcId: string) => UserInteraction[];
  getUserInteractionsByLessonId: (lessonId: string) => UserInteraction[];
  
  resetProgress: () => void;
}

export const useProgressStore = create<ProgressState>()(
  (set, get) => ({
    // Initial state
    kcMasteries: [],
    userInteractions: [],

    // Actions
    setKCMasteries: (kcMasteries) => set({ kcMasteries }),
    setUserInteractions: (userInteractions) => set({ userInteractions }),

    // Interaction tracking
    addInteraction: async (interaction: Omit<UserInteraction, 'interaction_id' | 'timestamp'>) => {
      try {
        // Get current session from learning store
        const token = localStorage.getItem('authToken');
        if (!token) return;

        const response = await fetch('/api/interactions', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(interaction),
        });

        if (response.ok) {
          const responseData: ApiResponse<UserInteraction> = await response.json();
          const newInteraction = responseData.data;
          
          // Add to local state
          const currentInteractions = get().userInteractions;
          set({ userInteractions: [newInteraction, ...currentInteractions] });
        }
      } catch (error) {
        console.error('Failed to add interaction:', error);
      }
    },

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
  })
);
