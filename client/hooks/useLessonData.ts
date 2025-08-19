import { useQuery } from '@tanstack/react-query';
import { Lesson } from '@/types/api';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:8080/api/v1';

export const useLessonData = (lessonId?: string) => {
  const {
    data: currentLesson,
    isLoading,
    error,
    refetch: loadLessonData,
  } = useQuery({
    queryKey: ['lesson', lessonId],
    queryFn: async (): Promise<Lesson> => {
      if (!lessonId) {
        throw new Error('Lesson ID is required');
      }

      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token found');
      }

      // Use the single lesson endpoint instead of loading all lessons
      const response = await fetch(`${API_BASE_URL}/lessons/${lessonId}`, {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch lesson');
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!lessonId, // Only run query when lessonId is provided
    staleTime: 2 * 60 * 1000, // 2 minutes - lesson content might change
    refetchOnWindowFocus: false, // Don't refetch when window regains focus
  });

  return {
    currentLesson,
    isLoading,
    error: error?.message || null,
    loadLessonData,
  };
};
