import { useQuery } from '@tanstack/react-query';
import { Module, ModuleLessonMapping } from '@/types/api';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:8080/api/v1';

export const useModuleData = (moduleId?: string) => {
  const {
    data: modules = [],
    isLoading: modulesLoading,
    error: modulesError,
    refetch: loadModules,
  } = useQuery({
    queryKey: ['modules'],
    queryFn: async (): Promise<Module[]> => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token found');
      }

      const response = await fetch(`${API_BASE_URL}/modules`, {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch modules');
      }

      const data = await response.json();
      return data.data;
    },
    staleTime: 5 * 60 * 1000, // 5 minutes - modules don't change often
    refetchOnWindowFocus: false,
  });

  const {
    data: lessons = [],
    isLoading: lessonsLoading,
    error: lessonsError,
    refetch: loadLessons,
  } = useQuery({
    queryKey: ['module-lessons', moduleId],
    queryFn: async (): Promise<ModuleLessonMapping[]> => {
      if (!moduleId) {
        throw new Error('Module ID is required');
      }

      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token found');
      }

      // Get lessons for the specific module, not all lessons globally
      const response = await fetch(`${API_BASE_URL}/modules/${moduleId}/lessons`, {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch module lessons');
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!moduleId, // Only run query when moduleId is provided
    staleTime: 2 * 60 * 1000, // 2 minutes - lessons might change
    refetchOnWindowFocus: false,
  });

  return {
    modules,
    lessons,
    isLoading: modulesLoading || lessonsLoading,
    error: modulesError?.message || lessonsError?.message || null,
    loadModules,
    loadLessons,
  };
};
