'use client';

import { useEffect } from 'react';
import { useAppStore } from '@/lib/store';

export function AppProvider({ children }: { children: React.ReactNode }) {
	const { createSession, endSession, checkAuth } = useAppStore();

	useEffect(() => {
		// Check authentication status when app loads
		checkAuth();

		// Create session when app loads
		createSession();

		// End session when user leaves
		const handleBeforeUnload = () => {
			endSession();
		};

		window.addEventListener('beforeunload', handleBeforeUnload);

		return () => {
			window.removeEventListener('beforeunload', handleBeforeUnload);
			endSession();
		};
	}, [checkAuth, createSession, endSession]);

	return <>{children}</>;
}