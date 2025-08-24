import { useCallback } from 'react';
import { useAuthStore, useMainStore } from '@/lib/stores';
import { authApi } from '@/services/api';
import { User } from '@/types/api';

import { logger } from '@/lib/utils';
export const useAuth = () => {
  const { user, isAuthenticated, isLoadingAuth, setUser, setAuthenticated, setLoadingAuth } = useAuthStore();
  const { logout: logoutAll } = useMainStore();

  const checkAuth = useCallback(async () => {
    try {
      setLoadingAuth(true);
      
      // Check if we have a token in localStorage
      const token = localStorage.getItem('authToken');
      if (!token) {
        setUser(null);
        setAuthenticated(false);
        setLoadingAuth(false);
        return;
      }

      // Fetch user from backend
      const response = await authApi.getCurrentUser(token);
      const userData = response.data;
      
      setUser(userData);
      setAuthenticated(true);
      setLoadingAuth(false);
    } catch (error) {
      logger.error('Auth check error:', error);
      localStorage.removeItem('authToken');
      setUser(null);
      setAuthenticated(false);
      setLoadingAuth(false);
    }
  }, [setUser, setAuthenticated, setLoadingAuth]);

  const logout = useCallback(async () => {
    try {
      await logoutAll();
    } catch (error) {
      logger.error('Failed to logout:', error);
    }
  }, [logoutAll]);

  return {
    user,
    isAuthenticated,
    isLoadingAuth,
    checkAuth,
    logout,
    setUser,
  };
};
