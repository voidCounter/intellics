import { useAuthStore } from './auth-store';
import { useContentStore } from './content-store';
import { useLearningStore } from './learning-store';
import { useSessionStore } from './session-store';

// Main store hook that provides access to all domain stores
// This maintains backward compatibility while using the new domain structure
export const useMainStore = () => {
  const auth = useAuthStore();
  const content = useContentStore();
  const learning = useLearningStore();
  const session = useSessionStore();

  // Combined reset function for all stores
  const resetAllStores = () => {
    auth.resetAuth();
    content.resetContent();
    learning.resetLearning();
    session.clearSession();
  };

  // Enhanced logout that clears all stores and localStorage
  const logout = async () => {
    try {
      // End the current session on the backend first
      if (session.sessionId) {
        const token = localStorage.getItem('authToken');
        if (token) {
          try {
            await fetch(`/api/sessions/${session.sessionId}/end`, {
              method: 'PUT',
              headers: {
                'Authorization': `Bearer ${token}`,
              },
            });
            console.log('✅ Session ended successfully on logout');
          } catch (error) {
            console.warn('⚠️ Failed to end session on logout:', error);
            // Continue with logout even if session ending fails
          }
        }
      }
      
      // Clear local state
      session.clearSession();
    } catch (error) {
      console.warn('⚠️ Error during session cleanup on logout:', error);
    }
    
    await auth.logout(resetAllStores);
  };

  return {
    // Auth state and actions
    ...auth,
    
    // Content state and actions
    ...content,
    
    // Learning state and actions
    ...learning,
    
    // Session state and actions
    ...session,
    
    // Combined actions
    resetAllStores,
    logout,
  };
};

// Export individual store hooks for direct access
export { useAuthStore, useContentStore, useLearningStore, useSessionStore };
