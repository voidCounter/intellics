'use client';

import { useEffect } from 'react';
import { useAuthStore } from '@/lib/stores/auth-store';
import { useSessionStore } from '@/lib/stores/session-store';
import { useRouter } from 'next/navigation';
import { useSessionManager } from '@/hooks/useSessionManager';

interface ProtectedRouteProps {
  children: React.ReactNode;
}

export function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const { isAuthenticated, isLoadingAuth } = useAuthStore();
  const { sessionId, status } = useSessionStore();
  const router = useRouter();

  // Initialize session management for protected routes
  useSessionManager();

  useEffect(() => {
    if (!isLoadingAuth && !isAuthenticated) {
      router.push('/auth');
    }
  }, [isAuthenticated, isLoadingAuth, router]);

  // Show loading while checking authentication
  if (isLoadingAuth) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p>Checking authentication...</p>
        </div>
      </div>
    );
  }

  // Don't render children if not authenticated
  if (!isAuthenticated) {
    return null;
  }

  // Show loading while waiting for active session
  if (!sessionId || status !== 'active') {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p>Initializing session...</p>
        </div>
      </div>
    );
  }

  // Only show content when we have an active session
  return <>{children}</>;
} 