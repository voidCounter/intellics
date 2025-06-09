'use client';

import { useEffect } from 'react';
import { useAppStore } from '@/lib/store';

export function SessionProvider({ children }: { children: React.ReactNode }) {
	const { createSession, endSession } = useAppStore();

	useEffect(() => {
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
	}, [createSession, endSession]);

	return <>{children}</>;
}