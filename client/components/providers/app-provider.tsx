'use client';

import { useEffect, useRef } from 'react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import { useAuthStore } from '@/lib/stores';

export function AppProvider({ children }: { children: React.ReactNode }) {
	const { checkAuth, isAuthenticated, user } = useAuthStore();
	
	// Create a singleton QueryClient that persists across re-renders
	const queryClientRef = useRef<QueryClient>();
	
	if (!queryClientRef.current) {
		queryClientRef.current = new QueryClient({
			defaultOptions: {
				queries: {
					staleTime: 5 * 60 * 1000, // 5 minutes
					gcTime: 10 * 60 * 1000, // 10 minutes (keep queries in memory longer)
					retry: 1,
					refetchOnWindowFocus: false, // Don't refetch when window regains focus
					refetchOnReconnect: false, // Don't refetch on network reconnect
				},
			},
		});
	}
	
	useEffect(() => {
		// Check authentication status when app loads, but only if not already authenticated
		if (!isAuthenticated && !user) {
			checkAuth();
		}
	}, [checkAuth, isAuthenticated, user]);

	return (
		<QueryClientProvider client={queryClientRef.current!}>
			{children}
			<ReactQueryDevtools initialIsOpen={false} />
		</QueryClientProvider>
	);
}