"use client";

import { Button } from "@/components/ui/button";
import { useRouter, useSearchParams } from "next/navigation";
import { Suspense, useEffect } from "react";
import { useAuth } from "@/hooks/useAuth";
import { authApi } from "@/services/api";

import { logger } from '@/lib/utils';
function AuthComponent() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { setUser, isAuthenticated, user } = useAuth();

  useEffect(() => {
    // Check if user is already authenticated
    if (isAuthenticated) {
      router.push('/');
      return;
    }

    // Handle OAuth callback with token
    const token = searchParams.get('token');
    if (token) {
      // Store the token in localStorage
      localStorage.setItem('authToken', token);
      
      // Fetch user info using the token
      fetchUserInfo(token);
    }
  }, [searchParams, isAuthenticated, router]);

  // Redirect to home when user is set
  useEffect(() => {
    if (user && isAuthenticated) {
      router.push('/');
    }
  }, [user, isAuthenticated, router]);

  const fetchUserInfo = async (token: string) => {
    try {
      const response = await authApi.getCurrentUser(token);
      const userData = response.data;
      // Set user state - the useEffect above will handle the redirect
      setUser(userData);
    } catch (error) {
      logger.error('❌ Error fetching user info:', error);
      localStorage.removeItem('authToken');
    }
  };

  const handleLogin = () => {
    // Redirect to our Next.js API route which will then redirect to the backend
    router.push("/api/auth/oauth");
  };

  return (
    <div className="flex items-center justify-center h-screen">
      <div className="text-center">
        <h1 className="text-3xl font-bold mb-4">Welcome to IntelliCS</h1>
        <p className="mb-8">Please sign in to continue</p>
        <Button onClick={handleLogin}>
          Sign in with Google
        </Button>
      </div>
    </div>
  );
}

export default function AuthPage() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <AuthComponent />
    </Suspense>
  );
}
