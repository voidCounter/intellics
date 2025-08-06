'use client';

import Link from 'next/link';
import Image from 'next/image';
import { Home, User, LogOut } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { useAppStore } from '@/lib/store';

export function Navbar() {
  const { isAuthenticated, user, logout } = useAppStore();

  return (
    <nav className="border-b bg-white/80 backdrop-blur-md sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          <Link href="/" className="flex items-center space-x-2">
            <Image
              src="/logo.svg"
              alt="IntelliCS Logo"
              width={32}
              height={32}
              className="text-[#2463eb]"
            />
            <span className="text-xl font-bold text-[#2463eb]">IntelliCS</span>
          </Link>

          <div className="flex items-center space-x-4">
            {isAuthenticated && user ? (
              <>
                <Button variant="ghost" size="sm" asChild>
                  <Link href="/" className="flex items-center space-x-2">
                    <Home className="h-4 w-4" />
                    <span>Home</span>
                  </Link>
                </Button>
                <Button variant="ghost" size="sm" asChild>
                  <Link href="/profile" className="flex items-center space-x-2">
                    <User className="h-4 w-4" />
                    <span>{user.username}</span>
                  </Link>
                </Button>
                <Button variant="ghost" size="sm" onClick={logout}>
                  <LogOut className="h-4 w-4 mr-2" />
                  Logout
                </Button>
              </>
            ) : (
              // Optionally, show a login button if not authenticated and not on the auth page
              // For now, we'll just show nothing as per the plan
              null
            )}
          </div>
        </div>
      </div>
    </nav>
  );
}