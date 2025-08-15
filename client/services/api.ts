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
      console.warn('Failed to fetch modules from API route, falling back to static data:', error);
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
      console.warn('Failed to fetch lessons from API route, falling back to static data:', error);
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
      console.warn('Failed to fetch questions from API route, falling back to static data:', error);
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
      console.warn('Failed to fetch knowledge components from API route, falling back to static data:', error);
    }
    
    // Fallback to static data (if available) or empty array
    return [];
  },
  
  getScaffolds: async (): Promise<any[]> => {
    const response = await fetch('/data/scaffolds.json');
    return response.json();
  },
};
