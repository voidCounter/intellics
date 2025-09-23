'use client';

import {useEffect, useRef, useState} from 'react';
import {QueryClient, QueryClientProvider} from '@tanstack/react-query';
import {ReactQueryDevtools} from '@tanstack/react-query-devtools';
import {useAuthStore} from '@/lib/stores';

export function AppProvider({children}: { children: React.ReactNode }) {
    const {checkAuth, isAuthenticated, user} = useAuthStore();
    const [backendReady, setBackendReady] = useState(false);

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
        let cancelled = false;

        async function checkBackend() {
            while (!cancelled) {
                try {
                    const res = await fetch('/api/health');
                    if (res.ok) {
                        setBackendReady(true);
                        break;
                    }
                } catch (e) {
                }
                await new Promise(r => setTimeout(r, 1000));
            }
        }

        checkBackend();
        return () => {
            cancelled = true;
        };
    }, []);

    useEffect(() => {
        if (backendReady && !isAuthenticated && !user) {
            checkAuth();
        }
    }, [backendReady, isAuthenticated, user]);

    if (!backendReady) {
        return <div style={{display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh'}}>Waiting
            for backend...</div>;
    }

    return (
        <QueryClientProvider client={queryClientRef.current!}>
            {children}
            <ReactQueryDevtools initialIsOpen={false}/>
        </QueryClientProvider>
    );
}