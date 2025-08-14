# Domain-Based Store Architecture

This directory contains the new domain-based store architecture that replaces the monolithic `store.ts` file. The stores are organized by domain to improve maintainability, separation of concerns, and code organization.

## Store Structure

### 1. **Auth Store** (`auth-store.ts`)
Handles user authentication, authorization, and user management.

**State:**
- `user`: Current authenticated user
- `isAuthenticated`: Authentication status
- `isLoadingAuth`: Loading state for auth operations
- `isAdminMode`: Admin role status

**Actions:**
- `checkAuth()`: Verify authentication token
- `logout()`: Clear authentication
- `setUser()`, `setAuthenticated()`, etc.

### 2. **Content Store** (`content-store.ts`)
Manages all static content data loaded from the backend.

**State:**
- `modules`: Course modules
- `lessons`: Individual lessons
- `questions`: Assessment questions
- `scaffolds`: Learning scaffolds
- `knowledgeComponents`: Knowledge components

**Actions:**
- `setModules()`, `setLessons()`, etc.
- Utility getters for finding content by ID

### 3. **Learning Store** (`learning-store.ts`)
Handles current learning session state and lesson progression.

**State:**
- `currentLesson`: Currently active lesson
- `showQuiz`: Quiz visibility state
- `currentSession`: Active learning session

**Actions:**
- `setCurrentLesson()`, `setShowQuiz()`
- `createSession()`

### 4. **Progress Store** (`progress-store.ts`)
Tracks learning progress and user interactions.

**State:**
- `kcMasteries`: Knowledge component mastery levels
- `userInteractions`: User learning interactions

**Actions:**
- `addInteraction()`: Record new interactions
- `setKCMasteries()`, `setUserInteractions()`
- Utility getters for progress analysis

## Usage

### Individual Store Usage
```typescript
import { useAuthStore, useContentStore, useLearningStore, useProgressStore } from '@/lib/stores';

// Use specific stores
const { user, isAuthenticated, checkAuth } = useAuthStore();
const { modules, lessons, getModuleById } = useContentStore();
const { currentLesson, setCurrentLesson } = useLearningStore();
const { kcMasteries, addInteraction } = useProgressStore();
```

### Combined Store Usage (Backward Compatibility)
```typescript
import { useMainStore } from '@/lib/stores';

// Access all stores combined
const { 
  user, 
  modules, 
  currentLesson, 
  addInteraction,
  resetAllStores 
} = useMainStore();
```

### Legacy Compatibility
```typescript
import { useAppStore } from '@/lib/store';

// Still works for existing code
const { user, modules, currentLesson } = useAppStore();
```

## Migration Guide

### From Old Store
Replace:
```typescript
import { useAppStore } from '@/lib/store';
const { user, modules } = useAppStore();
```

With:
```typescript
import { useAuthStore, useContentStore } from '@/lib/stores';
const { user } = useAuthStore();
const { modules } = useContentStore();
```

### Benefits of New Architecture

1. **Separation of Concerns**: Each store handles a specific domain
2. **Better Performance**: Components only re-render when relevant state changes
3. **Easier Testing**: Test individual stores in isolation
4. **Improved Maintainability**: Smaller, focused stores are easier to understand
5. **Type Safety**: Better TypeScript support with domain-specific interfaces
6. **Scalability**: Easy to add new domains without affecting existing stores

## Store Dependencies

- **Auth Store**: Independent, no dependencies
- **Content Store**: Independent, no dependencies  
- **Learning Store**: Independent, no dependencies
- **Progress Store**: Independent, no dependencies
- **Main Store**: Combines all domain stores

## Persistence

- **Auth Store**: Persists user data and auth state
- **Learning Store**: Persists current lesson and quiz state
- **Content Store**: No persistence (loaded fresh each session)
- **Progress Store**: No persistence (managed by backend)

## Future Enhancements

- Add middleware for cross-store communication
- Implement store subscriptions for complex state relationships
- Add dev tools integration for debugging
- Consider adding computed selectors for derived state
