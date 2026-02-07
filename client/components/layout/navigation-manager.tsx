'use client';

import { usePathname } from 'next/navigation';
import { useAuth } from '@/hooks/useAuth';
import LandingNavbar from '@/components/landing/Navbar';
import { Navbar as AppNavbar } from '@/components/layout/navbar';

export function NavigationManager() {
  const pathname = usePathname();
  const { isAuthenticated, isLoadingAuth } = useAuth();

  // Don't show any navbar on auth page
  if (pathname === '/auth') {
    return null;
  }

  // On the root page, if not authenticated, show the landing navbar
  if (pathname === '/' && !isAuthenticated) {
    return <LandingNavbar />;
  }

  // If authenticated, or if we're on any other page, show the app navbar
  // We check isLoadingAuth to avoid flickering if possible, 
  // but useAuthStore handles the initial state.
  return <AppNavbar />;
}
