// API service functions - handles all backend communication

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:8080/api/v1';

export interface ApiResponse<T> {
  status: 'SUCCESS' | 'ERROR';
  data: T;
  message: string;
}

// Auth API
export const authApi = {
  getCurrentUser: async (token: string): Promise<ApiResponse<any>> => {
    const response = await fetch(`${API_BASE_URL}/users/me`, {
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
    const response = await fetch('/data/modules.json');
    return response.json();
  },
  
  getLessons: async (): Promise<any[]> => {
    const response = await fetch('/data/lessons.json');
    return response.json();
  },
  
  getQuestions: async (): Promise<any[]> => {
    const response = await fetch('/data/questions.json');
    return response.json();
  },
  
  getScaffolds: async (): Promise<any[]> => {
    const response = await fetch('/data/scaffolds.json');
    return response.json();
  },
};
