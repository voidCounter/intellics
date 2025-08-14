'use client';

import { useEffect } from 'react';
import { useAuthStore } from '@/lib/stores';

export function AppProvider({ children }: { children: React.ReactNode }) {
	const { checkAuth, isAuthenticated, user } = useAuthStore();
	
	useEffect(() => {
		// Check authentication status when app loads, but only if not already authenticated
		if (!isAuthenticated && !user) {
			checkAuth();
		}
	}, [checkAuth, isAuthenticated, user]);

	return <>{children}</>;
}