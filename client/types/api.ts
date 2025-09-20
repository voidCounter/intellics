// Backend API Response Types - exactly matching what the backend returns

export type ApiResponseStatus = 'SUCCESS' | 'ERROR';

export interface ApiResponse<T> {
  status: ApiResponseStatus;
  data: T;
  message: string;
}

// User types matching backend UserDto
export interface User {
  username: string;
  email: string;
  imageUrl: string;
  roles: Role[];
  created_at: string;
}

export interface Role {
  name: 'ROLE_USER' | 'ROLE_ADMIN';
}

// Module types matching backend ModuleDto
export interface Module {
  module_id: string; // UUID from backend
  module_name: string;
  description: string;
}

// Lesson types matching backend LessonDto
export interface Lesson {
  lesson_id: string; // UUID from backend
  lesson_name: string;
  lesson_content: string;
  short_description?: string; // Optional for backward compatibility
}

// Lesson title only (for dropdowns)
export interface LessonTitle {
  lesson_id: string;
  lesson_name: string;
}

// Question types matching backend QuestionDto hierarchy
export interface QuestionOption {
  option_key: string; // Single uppercase letter (A-Z)
  option_text: string;
  option_explanation?: string;
}

// Question title only (for dropdowns)
export interface QuestionTitle {
  question_id: string;
  question_text: string;
}

export interface ModuleTitle {
  module_id: string;
  module_name: string;
}

// These are now defined above with BaseQuestion

// Base Question interface with common properties
export interface BaseQuestion {
  question_id: string;
  question_text: string;
  hint_level_1?: string;
  hint_level_2?: string;
  scaffolds?: Scaffold[];
}

export interface MultipleChoiceQuestion extends BaseQuestion {
  type: 'MULTIPLE_CHOICE';
  options: QuestionOption[];
  correct_option_key: string;
}

export interface WrittenQuestion extends BaseQuestion {
  type: 'WRITTEN';
  correct_answer_text: string;
  answer_explanation?: string;
}

export type Question = MultipleChoiceQuestion | WrittenQuestion;

// Scaffold types matching backend ScaffoldDto
export interface Scaffold {
  scaffoldId: string; // UUID from backend
  scaffoldText: string;
  scaffoldCorrectAnswer: string;
  orderIndex: number;
}

// Knowledge Component types matching backend KnowledgeComponentSimpleDto
export interface KnowledgeComponent {
  kc_id: string;
  kc_name: string;
  description: string;
}

// Module Lesson Mapping types matching backend ModuleLessonMappingDto
export interface ModuleLessonMapping {
  moduleId: string;
  lessonId: string;
  moduleName: string;
  lessonName: string;
  shortDescription: string;
  orderIndex: number;
}

// Lesson Order Update types matching backend ModuleLessonOrderUpdateDto
export interface LessonOrderItem {
  lessonId: string;
  orderIndex: number;
}

export interface ModuleLessonOrderUpdate {
  lessonOrders: LessonOrderItem[];
}

// Knowledge Component with relationships for data table
export interface KnowledgeComponentWithRelationships {
  kc_id: string;
  kc_name: string;
  description: string;
  linkedModules: Array<{
    module_id: string;
    module_name: string;
  }>;
  linkedLessons: Array<{
    lesson_id: string;
    lesson_name: string;
    target_mastery: number;
  }>;
  linkedQuestions: Array<{
    question_id: string;
    question_text: string;
    weight: number;
  }>;
}

// KC Mastery types matching backend StudentKCMastery entity
export interface KCMastery {
  kcId: string;
  kcName: string;
  kcDescription: string;
  pmastery: number;
  pguess: number;
  pslip: number;
  ptransit: number;
  updatedAt: string;
}

// User Interaction types matching backend UserInteractionDto
export interface UserInteraction {
  interaction_id: string;
  session_id?: string;
  user_id?: string;
  module_id?: string;
  lesson_id?: string;
  question_id?: string;
  scaffold_id?: string;
  interaction_type: InteractionType;
  student_answer?: string;
  is_correct?: boolean;
  hint_level?: number;
  time_spent_seconds?: number;
  timestamp: string;
  answer_correctness?: number; // AI-evaluated correctness score (0.0 to 1.0)
  answer_analysis?: string; // Detailed AI feedback and analysis
  kc_mappings?: InteractionKCMapping[];
}

export interface InteractionKCMapping {
  kc_id: string;
  weight: number;
  kc_mastery_before?: number;
  kc_mastery_after?: number;
}

export enum InteractionType {
  LESSON_START = 'LESSON_START',
  LESSON_EXIT = 'LESSON_EXIT',
  HINT_REQUESTED = 'HINT_REQUESTED',
  SCAFFOLD_REQUESTED = 'SCAFFOLD_REQUESTED',
  SCAFFOLD_ATTEMPTED = 'SCAFFOLD_ATTEMPTED',
  SCAFFOLD_ANSWER = 'SCAFFOLD_ANSWER',
  QUESTION_PRESENTED = 'QUESTION_PRESENTED',
  QUESTION_ATTEMPTED = 'QUESTION_ATTEMPTED',
  QUESTION_SKIPPED = 'QUESTION_SKIPPED'
}

// Session types matching backend SessionDto
export interface Session {
  sessionId: string;
  userId: string;
  startTime: string;
  endTime?: string;
  lastActiveAt: string;
  deviceType?: string;
  userAgent?: string;
  createdAt: string;
  updatedAt: string;
}

// UserSession types matching backend UserSessionDto
export interface UserSession {
  sessionId: string;
  username: string;
  userAgent: string;
  deviceType: string;
  startTime: string;
  endTime?: string;
  lastActiveAt?: string;
  createdAt: string;
  updatedAt: string;
  interactionCount: number;
}

// Question Recommendation types
export interface QuestionRecommendationDto {
  question_id: string;
  question_text: string;
  primary_kc: string;
  priority_score: number;
  mastery_gap: number;
  recency_factor: number;
  last_correct_answer?: string;
  kc_name?: string;
  question_type?: string;
  difficulty_level?: number;
}

export interface QuestionRecommendationRequestDto {
  context: 'lesson' | 'global';
  lesson_id?: string;
  module_id?: string;
  limit?: number;
  include_prerequisites?: boolean;
  max_recency_days?: number;
  per_kc_limit?: number;
}
