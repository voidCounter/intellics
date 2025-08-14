// DEPRECATED: This store is now replaced by domain-specific stores
// Use the new stores from './stores/' instead:
// - useAuthStore for authentication
// - useContentStore for content data
// - useLearningStore for learning state
// - useProgressStore for progress tracking
// - useMainStore for backward compatibility

import { useMainStore } from './stores/main-store';

// Re-export the main store for backward compatibility
export const useAppStore = useMainStore;

// Legacy interface for backward compatibility
export interface AppState {
  // This interface is deprecated - use the individual store interfaces instead
  [key: string]: any;
}
