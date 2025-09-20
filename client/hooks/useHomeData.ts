import { useQuery } from '@tanstack/react-query';
import { Module } from '@/types/api';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:8080';

export const useHomeData = () => {
  const {
    data: modules = [],
    isLoading,
    error,
    refetch: loadModules,
  } = useQuery({
    queryKey: ['home-modules'],
    queryFn: async (): Promise<Module[]> => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token found');
      }

      // Only load modules - no lessons, questions, or scaffolds
      const response = await fetch(`${API_BASE_URL}/api/v1/modules`, {
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
    refetchOnWindowFocus: false, // Don't refetch when window regains focus
  });

  return {
    modules,
    isLoading,
    error: error?.message || null,
    loadModules,
  };
};
