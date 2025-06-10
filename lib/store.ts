import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { formatTimestamp } from '@/lib/utils';

export interface Session {
  session_id: string;
  user_id: number;
  user_agent: string;
  device_type: string;
  start_time: string;
  end_time: string | null;
}

export interface User {
  user_id: number;
  username: string;
  created_at: string;
}

export interface Interaction {
  interaction_id: string;
  user_id: number;
  session_id: string;
  interaction_type: 'lesson_start' | 'lesson_exit' | 'start_test' | 'test_exit' | 'question_submit' | 'hint_request' | 'scaffold_answer' | 'scaffold_request' | 'skip_question';
  lesson_id?: number;
  question_id?: number;
  scaffold_id?: number;
  kc_id?: number;
  student_answer?: string;
  is_correct?: boolean;
  hint_level?: number;
  timestamp: string;
  p_mastery?: number;
}

export interface KCMastery {
  user_id: number;
  kc_id: number;
  p_mastery: number;
  p_guess: number;
  p_slip: number;
  p_transit: number;
  last_updated: string;
}

export interface Module {
  module_id: number;
  module_name: string;
  description: string;
}

export interface Lesson {
  lesson_id: number;
  module_id: number;
  lesson_name: string;
  description: string;
  content: string;
}

export interface Question {
  question_id: number;
  lesson_id: number;
  kc_id: number;
  question_text: string;
  question_type: 'multiple_choice' | 'written_answer';
  options?: string[];
  correct_answer: string;
  hint_level_1?: string;
  hint_level_2?: string;
  scaffolds?: Scaffold[];
}

export interface Scaffold {
  scaffold_id: number;
  question_id: number;
  scaffold_text: string;
  scaffold_type: 'multiple_choice' | 'written_answer';
  options?: string[];
  correct_answer: string;
}

export interface KC {
  kc_id: number;
  kc_name: string;
  description: string;
}

interface AppState {
  // User data
  user: User | null;
  currentSession: Session | null;

  // Data
  modules: Module[];
  lessons: Lesson[];
  questions: Question[];
  scaffolds: Scaffold[];
  kcs: KC[];

  // User state
  interactions: Interaction[];
  kcMasteries: KCMastery[];

  // Current session
  currentLesson: Lesson | null;
  currentQuestionIndex: number;
  showQuiz: boolean;
  usedHints: Set<string>;
  startTime: number | null;

  // Actions
  setUser: (user: User) => void;
  createSession: () => void;
  endSession: () => void;
  loadData: () => void;
  addInteraction: (interaction: Omit<Interaction, 'interaction_id' | 'user_id' | 'timestamp' | 'session_id'>) => void;
  updateKCMastery: (kc_id: number, response_type: 'correct_final_answer' | 'incorrect_final_answer' | 'hint_used' | 'scaffold_used' | 'scaffold_answer_correct' | 'scaffold_answer_incorrect' | 'skipped') => void;
  setCurrentLesson: (lesson: Lesson | null) => void;
  setShowQuiz: (show: boolean) => void;
  setCurrentQuestionIndex: (index: number) => void;
  requestHint: (question_id: number, hint_level: number) => void;
  startTimer: () => void;
  getTimeSpent: () => number;
  resetQuizState: () => void;
  resetStore: () => void;
  shouldRecordLessonExit: (lesson_id: number) => boolean;
}

export const useAppStore = create<AppState>()(
  persist(
    (set, get) => ({
      // Initial state
      user: null,
      currentSession: null,
      modules: [],
      lessons: [],
      questions: [],
      scaffolds: [],
      kcs: [],
      interactions: [],
      kcMasteries: [],
      currentLesson: null,
      currentQuestionIndex: 0,
      showQuiz: false,
      usedHints: new Set(),
      startTime: null,

      // Actions
      setUser: (user) => set({ user }),

      createSession: () => {
        const state = get();
        if (!state.user) {
          console.log('No user found, creating anonymous session');
          // Create an anonymous session if no user
          const session: Session = {
            session_id: crypto.randomUUID(),
            user_id: 0, // Anonymous user
            user_agent: navigator.userAgent,
            device_type: /Mobile|Android|iPhone/i.test(navigator.userAgent) ? 'mobile' : 'desktop',
            start_time: new Date().toISOString(),
            end_time: null
          };
          set({ currentSession: session });
          return;
        }

        console.log('Creating session for user:', state.user.user_id);
        const session: Session = {
          session_id: crypto.randomUUID(),
          user_id: state.user.user_id,
          user_agent: navigator.userAgent,
          device_type: /Mobile|Android|iPhone/i.test(navigator.userAgent) ? 'mobile' : 'desktop',
          start_time: new Date().toISOString(),
          end_time: null
        };

        set({ currentSession: session });
      },

      endSession: () => {
        const state = get();
        if (state.currentSession) {
          set({
            currentSession: {
              ...state.currentSession,
              end_time: new Date().toISOString()
            }
          });
        }
      },

      addInteraction: (interactionData) => {
        const state = get();
        if (!state.currentSession) {
          console.log('No session found, creating one before adding interaction');
          get().createSession();
        }

        // Check if this is a lesson_exit and if it should be recorded
        if (interactionData.interaction_type === 'lesson_exit' &&
          !get().shouldRecordLessonExit(interactionData.lesson_id!)) {
          console.log('Skipping lesson_exit - less than 10 seconds');
          return;
        }

        const timestamp = new Date().toISOString();
        const interaction: Interaction = {
          ...interactionData,
          interaction_id: `int_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
          user_id: state.user?.user_id || 0,
          session_id: state.currentSession?.session_id || 'anonymous',
          timestamp
        };

        console.log('Adding interaction:', {
          ...interaction,
          formatted_time: formatTimestamp(timestamp)
        });
        set({ interactions: [...state.interactions, interaction] });

        // Update KC mastery based on interaction type
        if (interactionData.question_id) {
          const question = state.questions.find(q => q.question_id === interactionData.question_id);
          if (question?.kc_id) {
            switch (interactionData.interaction_type) {
              case 'question_submit':
                get().updateKCMastery(question.kc_id, interactionData.is_correct ? 'correct_final_answer' : 'incorrect_final_answer');
                break;
              case 'hint_request':
                get().updateKCMastery(question.kc_id, 'hint_used');
                break;
              case 'scaffold_request':
                get().updateKCMastery(question.kc_id, 'scaffold_used');
                break;
              case 'scaffold_answer':
                get().updateKCMastery(question.kc_id, interactionData.is_correct ? 'scaffold_answer_correct' : 'scaffold_answer_incorrect');
                break;
              case 'skip_question':
                get().updateKCMastery(question.kc_id, 'skipped');
                break;
            }
          }
        }
      },

      shouldRecordLessonExit: (lesson_id: number) => {
        const state = get();
        const lessonStart = state.interactions.find(
          i => i.interaction_type === 'lesson_start' && i.lesson_id === lesson_id
        );

        if (!lessonStart) return false;

        const startTime = new Date(lessonStart.timestamp).getTime();
        const currentTime = Date.now();
        const timeDiff = (currentTime - startTime) / 1000; // Convert to seconds

        return timeDiff >= 10;
      },

      loadData: async () => {
        try {
          // Keep fetching scaffolds.json for now, in case it's used elsewhere or for the main list
          const [modulesRes, lessonsRes, questionsRes, scaffoldsRes, kcsRes, userRes] = await Promise.all([
            fetch('/data/modules.json'),
            fetch('/data/lessons.json'),
            fetch('/data/questions.json'), // This will now contain embedded scaffolds
            fetch('/data/scaffolds.json'), // Keep for the main list, though individual questions will have them
            fetch('/data/kcs.json'),
            fetch('/data/user.json')
          ]);

          const [modules, lessons, rawQuestions, allScaffolds, kcs, user] = await Promise.all([
            modulesRes.json(),
            lessonsRes.json(),
            questionsRes.json(), // rawQuestions might not have scaffolds embedded yet if this runs before the file is updated
            scaffoldsRes.json(),
            kcsRes.json(),
            userRes.json()
          ]);

          set({ modules, lessons, questions: rawQuestions, scaffolds: allScaffolds, kcs, user });

          // Initialize KC masteries if they don't exist
          const state = get();
          if (state.kcMasteries.length === 0 && user) {
            const initialMasteries: KCMastery[] = kcs.map((kc: KC) => ({
              user_id: user.user_id,
              kc_id: kc.kc_id,
              p_mastery: 0.2,
              p_guess: 0.25,
              p_slip: 0.1,
              p_transit: 0.1,
              last_updated: new Date().toISOString()
            }));
            set({ kcMasteries: initialMasteries });
          }
        } catch (error) {
          console.error('Error loading data:', error);
        }
      },

      updateKCMastery: (kc_id: number, response_type: 'correct_final_answer' | 'incorrect_final_answer' | 'hint_used' | 'scaffold_used' | 'scaffold_answer_correct' | 'scaffold_answer_incorrect' | 'skipped') => {
        const state = get();
        const masteries = [...state.kcMasteries];
        const masteryIndex = masteries.findIndex(m => m.kc_id === kc_id);

        if (masteryIndex >= 0) {
          const mastery = masteries[masteryIndex];
          let current_P_L = mastery.p_mastery;

          const p_transit = mastery.p_transit;
          const p_guess = mastery.p_guess;
          const p_slip = mastery.p_slip;

          const EPSILON = 1e-9;
          const P_T = Math.max(EPSILON, Math.min(1 - EPSILON, p_transit));
          const P_G = Math.max(EPSILON, Math.min(1 - EPSILON, p_guess));
          const P_S = Math.max(EPSILON, Math.min(1 - EPSILON, p_slip));

          let new_P_L = current_P_L;

          switch (response_type) {
            case 'correct_final_answer': {
              const prob_E_given_L_correct = (1 - P_S);
              const prob_E_given_notL_correct = P_G;
              const numerator_correct = current_P_L * prob_E_given_L_correct;
              const denominator_correct = numerator_correct + (1 - current_P_L) * prob_E_given_notL_correct;

              let P_L_after_observation_correct = denominator_correct === 0 ?
                current_P_L : numerator_correct / denominator_correct;

              new_P_L = P_L_after_observation_correct + (1 - P_L_after_observation_correct) * P_T;
              break;
            }

            case 'incorrect_final_answer': {
              const prob_E_given_L_incorrect = P_S;
              const prob_E_given_notL_incorrect = (1 - P_G);
              const numerator_incorrect = current_P_L * prob_E_given_L_incorrect;
              const denominator_incorrect = numerator_incorrect + (1 - current_P_L) * prob_E_given_notL_incorrect;

              let P_L_after_observation_incorrect = denominator_incorrect === 0 ?
                current_P_L : numerator_incorrect / denominator_incorrect;

              new_P_L = P_L_after_observation_incorrect;
              break;
            }

            case 'hint_used':
            case 'scaffold_used':
              new_P_L = current_P_L * 0.95;
              break;

            case 'scaffold_answer_correct': {
              const prob_E_given_L_scaffold_correct = (1 - P_S);
              const prob_E_given_notL_scaffold_correct = P_G;
              const num_scaffold_correct = current_P_L * prob_E_given_L_scaffold_correct;
              const den_scaffold_correct = num_scaffold_correct + (1 - current_P_L) * prob_E_given_notL_scaffold_correct;

              let P_L_after_scaffold_correct = den_scaffold_correct === 0 ?
                current_P_L : num_scaffold_correct / den_scaffold_correct;

              const P_T_scaffold_gain_factor = 0.5;
              new_P_L = P_L_after_scaffold_correct + (1 - P_L_after_scaffold_correct) * (P_T * P_T_scaffold_gain_factor);
              break;
            }

            case 'scaffold_answer_incorrect': {
              const prob_E_given_L_scaffold_incorrect = P_S;
              const prob_E_given_notL_scaffold_incorrect = (1 - P_G);
              const num_scaffold_incorrect = current_P_L * prob_E_given_L_scaffold_incorrect;
              const den_scaffold_incorrect = num_scaffold_incorrect + (1 - current_P_L) * prob_E_given_notL_scaffold_incorrect;

              let P_L_after_scaffold_incorrect = den_scaffold_incorrect === 0 ?
                current_P_L : num_scaffold_incorrect / den_scaffold_incorrect;

              new_P_L = P_L_after_scaffold_incorrect;
              break;
            }

            case 'skipped':
              new_P_L = current_P_L;
              break;

            default:
              console.warn("Unknown response_type for BKT update:", response_type);
              return;
          }

          mastery.p_mastery = Math.max(EPSILON, Math.min(1 - EPSILON, new_P_L));
          mastery.last_updated = new Date().toISOString();
          masteries[masteryIndex] = mastery;
          console.log("New mastery for ", kc_id, " ", mastery.p_mastery);
          set({ kcMasteries: masteries });
        }
      },

      setCurrentLesson: (lesson) => set({ currentLesson: lesson }),
      setShowQuiz: (show) => set({ showQuiz: show }),
      setCurrentQuestionIndex: (index) => set({ currentQuestionIndex: index }),

      requestHint: (question_id, hint_level) => {
        const state = get();
        const hintKey = `${question_id}-${hint_level}`;
        const newUsedHints = new Set(state.usedHints);
        newUsedHints.add(hintKey);
        set({ usedHints: newUsedHints });

        get().addInteraction({
          interaction_type: 'hint_request',
          question_id,
          hint_level
        });
      },

      startTimer: () => set({ startTime: Date.now() }),

      getTimeSpent: () => {
        const state = get();
        return state.startTime ? Math.floor((Date.now() - state.startTime) / 1000) : 0;
      },

      resetQuizState: () => set({
        currentQuestionIndex: 0,
        showQuiz: false,
        usedHints: new Set(),
        startTime: null
      }),

      resetStore: () => {
        set({
          user: null,
          currentSession: null,
          modules: [],
          lessons: [],
          questions: [],
          scaffolds: [],
          kcs: [],
          interactions: [],
          kcMasteries: [],
          currentLesson: null,
          currentQuestionIndex: 0,
          showQuiz: false,
          usedHints: new Set(),
          startTime: null
        });
      }
    }),
    {
      name: 'intellics-storage',
      partialize: (state) => ({
        interactions: state.interactions,
        kcMasteries: state.kcMasteries,
        user: state.user,
        currentSession: state.currentSession
      })
    }
  )
);