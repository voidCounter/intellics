'use client';

import { useEffect, useState } from 'react';
import { useAuthStore } from '@/lib/stores/auth-store';
import { useRouter } from 'next/navigation';

interface ProtectedAdminRouteProps {
  children: React.ReactNode;
}

export function ProtectedAdminRoute({ children }: ProtectedAdminRouteProps) {
  const { isAuthenticated, isLoadingAuth, user } = useAuthStore();
  const router = useRouter();
  const [isCheckingAdminRole, setIsCheckingAdminRole] = useState(true);

  useEffect(() => {
    const checkAdminAccess = async () => {
      // First check if user is authenticated
      if (!isLoadingAuth && !isAuthenticated) {
        router.push('/auth');
        return;
      }

      // If authenticated, verify admin role with backend
      if (isAuthenticated && user) {
        try {
          const token = localStorage.getItem('authToken');
          if (!token) {
            router.push('/auth');
            return;
          }

          // Double-check admin role with backend for security
          const response = await fetch('/api/users/me', {
            headers: {
              'Authorization': `Bearer ${token}`,
              'Content-Type': 'application/json',
            },
          });

          if (response.ok) {
            const responseData = await response.json();
            const currentUser = responseData.data;
            const isAdmin = currentUser.roles.some((role: any) => role.name === 'ROLE_ADMIN');
            
            if (!isAdmin) {
              console.warn('User does not have admin role, redirecting to home');
              router.push('/');
              return;
            }
            
            // User has admin role, allow access
            setIsCheckingAdminRole(false);
          } else {
            console.error('Failed to verify admin role');
            router.push('/');
            return;
          }
        } catch (error) {
          console.error('Error checking admin role:', error);
          router.push('/');
          return;
        }
      }
    };

    checkAdminAccess();
  }, [isAuthenticated, isLoadingAuth, user, router]);

  // Show loading while checking authentication and admin role
  if (isLoadingAuth || isCheckingAdminRole) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p>Verifying admin access...</p>
        </div>
      </div>
    );
  }

  // Don't render children if not authenticated or not admin
  if (!isAuthenticated) {
    return null;
  }

  // Render admin content
  return <>{children}</>;
}
