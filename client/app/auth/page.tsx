"use client";

import { Button } from "@/components/ui/button";
import { useRouter, useSearchParams } from "next/navigation";
import { Suspense, useEffect } from "react";
import { useAppStore } from "@/lib/store";

function AuthComponent() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { setUser, isAuthenticated } = useAppStore();

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

  const fetchUserInfo = async (token: string) => {
    try {
      const response = await fetch('http://localhost:8080/api/v1/users/me', {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });

      if (response.ok) {
        const user = await response.json();
        setUser(user);
        router.push('/');
      } else {
        console.error('Failed to fetch user info');
        localStorage.removeItem('authToken');
      }
    } catch (error) {
      console.error('Error fetching user info:', error);
      localStorage.removeItem('authToken');
    }
  };

  const handleLogin = () => {
    // Redirect to the Spring Boot backend's Google OAuth2 endpoint
    router.push("http://localhost:8080/oauth2/authorization/google");
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
