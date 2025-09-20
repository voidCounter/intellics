import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Question, QuestionRecommendationDto } from '@/types/api';

interface UseNextQuestionOptions {
  enabled?: boolean;
  staleTime?: number;
  refetchOnWindowFocus?: boolean;
  refetchOnMount?: boolean;
  refetchOnReconnect?: boolean;
}

export function useNextQuestion(
  lessonId?: string,
  moduleId?: string,
  options: UseNextQuestionOptions = {}
) {
  return useQuery({
    queryKey: ['next-question', lessonId, moduleId],
    queryFn: async (): Promise<Question | null> => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token found');
      }

      // Point to Spring Boot backend
      const url = new URL('/api/v1/recommendations/next-question', process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:8080');
      if (lessonId) url.searchParams.set('lessonId', lessonId);
      if (moduleId) url.searchParams.set('moduleId', moduleId);

      const response = await fetch(url.toString(), {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (response.status === 204) {
        return null; // No more questions
      }

      if (!response.ok) {
        throw new Error('Failed to fetch next question');
      }

      const data = await response.json();
      return data.data;
    },
    enabled: options.enabled ?? true,
    staleTime: options.staleTime ?? 5 * 60 * 1000, // 5 minutes - prevent unnecessary refetches
    refetchOnWindowFocus: options.refetchOnWindowFocus ?? false,
    refetchOnMount: options.refetchOnMount ?? false,
    refetchOnReconnect: options.refetchOnReconnect ?? false,
  });
}

export function useNextQuestionWithScaffolds(
  lessonId?: string,
  moduleId?: string,
  options: UseNextQuestionOptions = {}
) {
  return useQuery({
    queryKey: ['next-question-with-scaffolds', lessonId, moduleId],
    queryFn: async (): Promise<Question | null> => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token found');
      }

      // Point to Spring Boot backend
      const url = new URL('/api/v1/recommendations/next-question-with-scaffolds', process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:8080');
      if (lessonId) url.searchParams.set('lessonId', lessonId);
      if (moduleId) url.searchParams.set('moduleId', moduleId);
      
      // For module practice, use "all" scope to get questions from all KCs
      if (moduleId && !lessonId) {
        url.searchParams.set('scope', 'all');
      }

      const response = await fetch(url.toString(), {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (response.status === 204) {
        return null; // No more questions
      }

      if (!response.ok) {
        throw new Error('Failed to fetch next question with scaffolds');
      }

      const data = await response.json();
      return data.data;
    },
    enabled: options.enabled ?? true,
    staleTime: options.staleTime ?? 5 * 60 * 1000, // 5 minutes - prevent unnecessary refetches
    refetchOnWindowFocus: options.refetchOnWindowFocus ?? false,
    refetchOnMount: options.refetchOnMount ?? false,
    refetchOnReconnect: options.refetchOnReconnect ?? false,
  });
}

export function usePracticeSession(
  lessonId?: string,
  moduleId?: string,
  count: number = 5,
  options: UseNextQuestionOptions = {}
) {
  return useQuery({
    queryKey: ['practice-session', lessonId, moduleId, count],
    queryFn: async (): Promise<QuestionRecommendationDto[]> => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token found');
      }

      // Point to Spring Boot backend
      const url = new URL('/api/v1/recommendations/practice-session', process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:8080');
      url.searchParams.set('count', count.toString());
      if (lessonId) url.searchParams.set('lessonId', lessonId);
      if (moduleId) url.searchParams.set('moduleId', moduleId);

      const response = await fetch(url.toString(), {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch practice session');
      }

      const data = await response.json();
      return data.data;
    },
    enabled: options.enabled ?? true,
    staleTime: options.staleTime ?? 5 * 60 * 1000, // 5 minutes
    refetchOnWindowFocus: options.refetchOnWindowFocus ?? false,
  });
}

// Hook for getting the next question after answering
export function useGetNextQuestion() {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: async ({ lessonId, moduleId }: { lessonId?: string; moduleId?: string }): Promise<Question | null> => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token found');
      }

      // Point to Spring Boot backend
      const url = new URL('/api/v1/recommendations/next-question-with-scaffolds', process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:8080');
      if (lessonId) url.searchParams.set('lessonId', lessonId);
      if (moduleId) url.searchParams.set('moduleId', moduleId);
      
      // For module practice, use "all" scope to get questions from all KCs
      if (moduleId && !lessonId) {
        url.searchParams.set('scope', 'all');
      }
      
      // Add timestamp to avoid caching issues
      url.searchParams.set('_t', Date.now().toString());

      const response = await fetch(url.toString(), {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (response.status === 204) {
        return null; // No more questions
      }

      if (!response.ok) {
        throw new Error('Failed to fetch next question with scaffolds');
      }

      const data = await response.json();
      return data.data;
    },
    onSuccess: (data, variables) => {
      // Invalidate the query to refresh the data
      queryClient.invalidateQueries({ queryKey: ['next-question-with-scaffolds', variables.lessonId, variables.moduleId] });
      
      // Also invalidate the regular next-question query if it exists
      queryClient.invalidateQueries({ queryKey: ['next-question', variables.lessonId, variables.moduleId] });
      
      // Invalidate practice session queries to ensure fresh recommendations
      queryClient.invalidateQueries({ queryKey: ['practice-session', variables.lessonId, variables.moduleId] });
    },
  });
}
