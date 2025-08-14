import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { User, ApiResponse } from '@/types/api';

export interface AuthState {
  // User data
  user: User | null;
  isAuthenticated: boolean;
  isLoadingAuth: boolean;
  isAdminMode: boolean;

  // Actions
  setUser: (user: User | null) => void;
  setAuthenticated: (isAuthenticated: boolean) => void;
  setLoadingAuth: (isLoading: boolean) => void;
  setAdminMode: (isAdmin: boolean) => void;
  checkAuth: () => Promise<void>;
  logout: (resetOtherStores?: () => void) => Promise<void>;
  resetAuth: () => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set, get) => ({
      // Initial state
      user: null,
      isAuthenticated: false,
      isLoadingAuth: true,
      isAdminMode: false,

      // Actions
      checkAuth: async () => {
        try {
          // Check if we have a token in localStorage
          const token = localStorage.getItem('authToken');
          if (!token) {
            set({ user: null, isAuthenticated: false, isLoadingAuth: false });
            return;
          }

          const response = await fetch('/api/users/me', {
            headers: {
              'Authorization': `Bearer ${token}`,
              'Content-Type': 'application/json',
            },
          });

          if (response.ok) {
            const responseData: ApiResponse<User> = await response.json();
            // Extract user data from ApiResponse wrapper
            const user = responseData.data;
            const isAdmin = user.roles.some(role => role.name === 'ROLE_ADMIN');
            set({ user, isAuthenticated: true, isLoadingAuth: false, isAdminMode: isAdmin });
          } else {
            // Token is invalid, remove it
            localStorage.removeItem('authToken');
            set({ user: null, isAuthenticated: false, isLoadingAuth: false, isAdminMode: false });
          }
        } catch (error) {
          console.error('Auth check error:', error);
          localStorage.removeItem('authToken');
          set({ user: null, isAuthenticated: false, isLoadingAuth: false, isAdminMode: false });
        }
      },

      logout: async (resetOtherStores?: () => void) => {
        try {
          // Clear the token from localStorage
          localStorage.removeItem('authToken');
          
          // Clear all other localStorage data
          localStorage.removeItem('intellics-auth-storage');
          localStorage.removeItem('intellics-content-storage');
          localStorage.removeItem('intellics-learning-storage');
          localStorage.removeItem('intellics-progress-storage');
          
          // Clear any other potential localStorage items
          Object.keys(localStorage).forEach(key => {
            if (key.startsWith('intellics-') || key.startsWith('auth') || key.includes('Token') || key.includes('session')) {
              localStorage.removeItem(key);
            }
          });
          
          // Also clear sessionStorage if it exists
          if (typeof sessionStorage !== 'undefined') {
            Object.keys(sessionStorage).forEach(key => {
              if (key.startsWith('intellics-') || key.startsWith('auth') || key.includes('Token') || key.includes('session')) {
                sessionStorage.removeItem(key);
              }
            });
          }
          
          // Clear any cookies that might be related to the app
          if (typeof document !== 'undefined') {
            document.cookie.split(';').forEach(cookie => {
              const eqPos = cookie.indexOf('=');
              const name = eqPos > -1 ? cookie.substr(0, eqPos).trim() : cookie.trim();
              if (name.startsWith('intellics') || name.startsWith('auth') || name.includes('token') || name.includes('session')) {
                document.cookie = `${name}=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/`;
              }
            });
          }
          
        } catch (error) {
          console.error('Failed to logout:', error);
        } finally {
          // Reset auth store
          get().resetAuth();
          
          // Reset other stores if callback provided
          if (resetOtherStores) {
            resetOtherStores();
          }
        }
      },

      setUser: (user) => {
        const isAdmin = user?.roles.some(role => role.name === 'ROLE_ADMIN') ?? false;
        set({ user, isAuthenticated: user !== null, isAdminMode: isAdmin });
      },
      setAuthenticated: (isAuthenticated) => set({ isAuthenticated }),
      setLoadingAuth: (isLoading) => set({ isLoadingAuth: isLoading }),
      setAdminMode: (isAdmin) => set({ isAdminMode: isAdmin }),

      resetAuth: () => {
        set({
          user: null,
          isAuthenticated: false,
          isLoadingAuth: false,
          isAdminMode: false,
        });
      }
    }),
    {
      name: 'intellics-auth-storage',
      partialize: (state) => ({
        user: state.user,
        isAuthenticated: state.isAuthenticated,
        isAdminMode: state.isAdminMode,
      })
    }
  )
);
