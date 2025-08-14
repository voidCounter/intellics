import { create } from 'zustand';
import { Module, Lesson, Question, Scaffold, KnowledgeComponent } from '@/types/api';

export interface ContentState {
  // Content data
  modules: Module[];
  lessons: Lesson[];
  questions: Question[];
  scaffolds: Scaffold[];
  knowledgeComponents: KnowledgeComponent[];

  // Actions
  setModules: (modules: Module[]) => void;
  setLessons: (lessons: Lesson[]) => void;
  setQuestions: (questions: Question[]) => void;
  setScaffolds: (scaffolds: Scaffold[]) => void;
  setKnowledgeComponents: (knowledgeComponents: KnowledgeComponent[]) => void;
  
  // Utility getters
  getModuleById: (moduleId: string) => Module | undefined;
  getLessonById: (lessonId: string) => Lesson | undefined;
  getQuestionById: (questionId: string) => Question | undefined;
  getScaffoldsByQuestionId: (questionId: string) => Scaffold[];
  getKnowledgeComponentById: (kcId: string) => KnowledgeComponent | undefined;
  
  resetContent: () => void;
}

export const useContentStore = create<ContentState>()(
  (set, get) => ({
    // Initial state
    modules: [],
    lessons: [],
    questions: [],
    scaffolds: [],
    knowledgeComponents: [],

    // Actions
    setModules: (modules) => set({ modules }),
    setLessons: (lessons) => set({ lessons }),
    setQuestions: (questions) => set({ questions }),
    setScaffolds: (scaffolds) => set({ scaffolds }),
    setKnowledgeComponents: (knowledgeComponents) => set({ knowledgeComponents }),

    // Utility getters
    getModuleById: (moduleId: string) => {
      return get().modules.find(module => module.module_id === moduleId);
    },

    getLessonById: (lessonId: string) => {
      return get().lessons.find(lesson => lesson.lesson_id === lessonId);
    },

    getQuestionById: (questionId: string) => {
      return get().questions.find(question => question.question_id === questionId);
    },

    getScaffoldsByQuestionId: (questionId: string) => {
      // Note: This will need to be updated once we fix the Scaffold type
      // to include the question_id relationship
      return get().scaffolds
        .filter(scaffold => (scaffold as any).question_id === questionId)
        .sort((a, b) => a.orderIndex - b.orderIndex);
    },

    getKnowledgeComponentById: (kcId: string) => {
      return get().knowledgeComponents.find(kc => kc.kc_id === kcId);
    },

    resetContent: () => {
      set({
        modules: [],
        lessons: [],
        questions: [],
        scaffolds: [],
        knowledgeComponents: [],
      });
    }
  })
);
