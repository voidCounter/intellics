import { useQuery } from '@tanstack/react-query';
import { KCMastery } from '@/types/api';

export function useUserKCMastery() {
  return useQuery({
    queryKey: ['user-kc-mastery'],
    queryFn: async (): Promise<KCMastery[]> => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('No auth token found');
      }

      const response = await fetch('/api/users/me/kc-mastery', {
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch user KC mastery');
      }

      const data = await response.json();
      return data;
    },
    staleTime: 5 * 60 * 1000, // 5 minutes
    refetchOnWindowFocus: false,
  });
}
