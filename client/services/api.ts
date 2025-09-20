import { logger } from '@/lib/utils';

// API service functions - handles all backend communication

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:8080';

export interface ApiResponse<T> {
  status: 'SUCCESS' | 'ERROR';
  data: T;
  message: string;
}

// Auth API
export const authApi = {
  getCurrentUser: async (token: string): Promise<ApiResponse<any>> => {
    const response = await fetch(`${API_BASE_URL}/api/v1/users/me`, {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    });
    
    if (!response.ok) {
      throw new Error('Failed to fetch user');
    }
    
    return response.json();
  },
};

// Data API (for when we replace static files with real backend calls)
export const dataApi = {
  getModules: async (): Promise<any[]> => {
    try {
      // Get auth token from localStorage
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token available');
      }

      // Try to get from Next.js API route first
      const response = await fetch('/api/modules', {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });
      
      if (response.ok) {
        const apiResponse = await response.json();
        // Extract modules from the API response structure
        return apiResponse.data || [];
      }
    } catch (error) {
      logger.warn('Failed to fetch modules from API route, falling back to static data:', error);
    }
    
    // Fallback to static data
    const response = await fetch('/data/modules.json');
    return response.json();
  },
  
  getLessons: async (): Promise<any[]> => {
    try {
      // Get auth token from localStorage
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token available');
      }

      // Try to get from Next.js API route first
      const response = await fetch('/api/lessons', {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });
      
      if (response.ok) {
        const apiResponse = await response.json();
        // Extract lessons from the API response structure
        return apiResponse.data || [];
      }
    } catch (error) {
      logger.warn('Failed to fetch lessons from API route, falling back to static data:', error);
    }
    
    // Fallback to static data
    const response = await fetch('/data/lessons.json');
    return response.json();
  },
  
  getQuestions: async (): Promise<any[]> => {
    try {
      // Get auth token from localStorage
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token available');
      }

      // Try to get from Next.js API route first
      const response = await fetch('/api/questions', {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });
      
      if (response.ok) {
        const apiResponse = await response.json();
        // Extract questions from the API response structure
        return apiResponse.data || [];
      }
    } catch (error) {
      logger.warn('Failed to fetch questions from API route, falling back to static data:', error);
    }
    
    // Fallback to static data
    const response = await fetch('/data/questions.json');
    return response.json();
  },
  
  getKnowledgeComponents: async (): Promise<any[]> => {
    try {
      // Get auth token from localStorage
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token available');
      }

      // Try to get from Next.js API route first
      const response = await fetch('/api/knowledge-components', {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });
      
      if (response.ok) {
        const apiResponse = await response.json();
        // Extract KCs from the API response structure
        return apiResponse.data || [];
      }
    } catch (error) {
      logger.warn('Failed to fetch knowledge components from API route, falling back to static data:', error);
    }
    
    // Fallback to static data (if available) or empty array
    return [];
  },
  
  getScaffolds: async (): Promise<any[]> => {
    const response = await fetch('/data/scaffolds.json');
    return response.json();
  },
};

export async function evaluateAnswerWithLLM(
  questionText: string,
  correctAnswer: string,
  userAnswer: string,
  questionContext?: string
): Promise<{
  correctnessScore: number;
  isCorrect: boolean;
  feedback: string;
  detailedAnalysis: string;
}> {
  try {
    // Get auth token from localStorage
    const token = localStorage.getItem('authToken');
    if (!token) {
      throw new Error('No auth token available');
    }

    const response = await fetch('/api/llm/evaluate-answer', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`,
      },
      body: JSON.stringify({
        questionText,
        correctAnswer,
        userAnswer,
        questionContext,
      }),
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    return result;
  } catch (error) {
    logger.error('Error evaluating answer with LLM:', error);
    // Fallback to exact matching if LLM fails
    const isCorrect = userAnswer.toLowerCase().trim() === correctAnswer.toLowerCase().trim();
    return {
      correctnessScore: isCorrect ? 1.0 : 0.0,
      isCorrect,
      feedback: isCorrect ? 'Correct!' : 'Incorrect. Please try again.',
      detailedAnalysis: 'LLM evaluation failed - using exact matching fallback',
    };
  }
}
