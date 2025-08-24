import { create } from 'zustand';
import { Session } from '@/types/api';

type SessionStatus = 'initializing' | 'active' | 'inactive' | 'ended';

export interface SessionState {
  sessionId: string | null;
  status: SessionStatus;
  sessionDetails: Session | null;
  setSession: (sessionId: string, details?: Session) => void;
  setInactive: () => void;
  setActive: () => void;
  setInitializing: () => void;
  clearSession: () => void;
  updateSessionDetails: (details: Session) => void;
}

export const useSessionStore = create<SessionState>((set) => ({
  sessionId: null,
  status: 'initializing',
  sessionDetails: null,
  setSession: (sessionId, details) => set({ 
    sessionId, 
    status: 'active',
    sessionDetails: details || null
  }),
  setInactive: () => set((state) => (state.sessionId ? { status: 'inactive' } : state)),
  setActive: () => set((state) => (state.sessionId ? { status: 'active' } : state)),
  setInitializing: () => set({ status: 'initializing' }),
  clearSession: () => set({ sessionId: null, status: 'ended', sessionDetails: null }),
  updateSessionDetails: (details) => set((state) => {
    // Only update if the details are actually different to prevent unnecessary re-renders
    if (JSON.stringify(state.sessionDetails) === JSON.stringify(details)) {
      return state; // No change needed
    }
    return { sessionDetails: details };
  }),
}));
