import { useState, useEffect } from 'react';
import { UserSession } from '@/types/api';
import { useAuthStore } from '@/lib/stores/auth-store';

import { logger } from '@/lib/utils';
interface UseUserSessionsOptions {
  isActive?: boolean;
  deviceType?: string;
}

export const useUserSessions = (options: UseUserSessionsOptions = {}) => {
  const [sessions, setSessions] = useState<UserSession[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const { isAuthenticated } = useAuthStore();

  const fetchSessions = async () => {
    if (!isAuthenticated) return;

    setIsLoading(true);
    setError(null);

    try {
      const token = localStorage.getItem('authToken');
      if (!token) return;

      // Build query parameters
      const queryParams = new URLSearchParams();
      if (options.isActive !== undefined) queryParams.append('isActive', options.isActive.toString());
      if (options.deviceType) queryParams.append('deviceType', options.deviceType);
      queryParams.append('page', '0');
      queryParams.append('size', '50'); // Get more sessions

      const response = await fetch(`/api/sessions/my?${queryParams.toString()}`, {
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (response.ok) {
        const data = await response.json();
        if (data.data && data.data.content) {
          setSessions(data.data.content);
        } else {
          setSessions([]);
        }
      } else {
        setError('Failed to fetch sessions');
      }
    } catch (err) {
      setError('Error fetching sessions');
      logger.error('Error fetching sessions:', err);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchSessions();
  }, [isAuthenticated, options.isActive, options.deviceType]);

  return {
    sessions,
    isLoading,
    error,
    refetch: fetchSessions,
  };
};
