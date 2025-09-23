'use client';

import {ReactNode, useEffect, useState} from 'react';
import { QueryClient, QueryClientProvider, useQuery } from '@tanstack/react-query';
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import { useAuthStore } from '@/lib/stores';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000,
      gcTime: 10 * 60 * 1000,
      retry: 1,
      refetchOnWindowFocus: false,
      refetchOnReconnect: false,
    },
  },
});

function useBackendReady() {
  return useQuery({
    queryKey: ['backendHealth'],
    queryFn: async () => {
      const res = await fetch('/api/health');
      if (!res.ok) throw new Error('Backend not ready');
      return true;
    },
    // avoid immediate multiple retry attempts — use polling instead
    retry: false,
    // poll every second until health succeeds, then stop
    refetchInterval: (data) => (data ? false : 1000),
    // keep polling even when tab in background (optional)
    refetchIntervalInBackground: true,
  });
}


export function BackendGate({ children }: { children: ReactNode }) {
  const { checkAuth, isAuthenticated, user } = useAuthStore();
  const { data } = useBackendReady();
  const backendReady = Boolean(data);

  const [seconds, setSeconds] = useState(0);
  const [message, setMessage] = useState("Waiting for backend...");

  // Count elapsed seconds
  useEffect(() => {
    if (backendReady) return;
    const interval = setInterval(() => setSeconds((s) => s + 1), 1000);
    return () => clearInterval(interval);
  }, [backendReady]);

  // Update message based on elapsed time
  useEffect(() => {
    if (backendReady) return;
    if (seconds > 15) {
      setMessage("This is taking longer than usual, still trying to connect…");
    } else if (seconds > 5) {
      setMessage("Server may be starting up, please wait…");
    } else {
      setMessage("Waiting for backend...");
    }
  }, [seconds, backendReady]);

  // Run auth check only once when backend becomes ready
  useEffect(() => {
    if (backendReady && !isAuthenticated && !user) {
      checkAuth();
    }
  }, [backendReady, isAuthenticated, user, checkAuth]);

  if (!backendReady) {
    return (
      <div className="flex flex-col items-center justify-center h-screen text-center">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-4"></div>
        <p className="mb-2">{message}</p>
        <p className="text-sm text-gray-500">Elapsed time: {seconds}s</p>
      </div>
    );
  }

  return <>{children}</>;
}

export function AppProvider({ children }: { children: ReactNode }) {
  return (
    <QueryClientProvider client={queryClient}>
      <BackendGate>{children}</BackendGate>
      <ReactQueryDevtools initialIsOpen={false} />
    </QueryClientProvider>
  );
}
