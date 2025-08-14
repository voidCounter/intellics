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
}

// Question types matching backend QuestionDto hierarchy
export interface QuestionOption {
  option_key: string; // Single uppercase letter (A-Z)
  option_text: string;
  option_explanation?: string;
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

// KC Mastery types matching backend StudentKCMastery entity
export interface KCMastery {
  kc_id: string;
  user_id: string;
  p_mastery: number;
  p_guess: number;
  p_slip: number;
  p_transit: number;
  updated_at: string;
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
  START_TEST = 'START_TEST',
  TEST_EXIT = 'TEST_EXIT',
  QUIZ_ANSWER = 'QUIZ_ANSWER',
  HINT_REQUEST = 'HINT_REQUEST',
  SCAFFOLD_ANSWER = 'SCAFFOLD_ANSWER'
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
