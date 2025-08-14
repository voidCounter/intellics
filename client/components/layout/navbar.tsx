'use client';

import Link from 'next/link';
import Image from 'next/image';
import { Home, User, LogOut, Settings, ChevronDown } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Switch } from '@/components/ui/switch';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { useAuthStore } from '@/lib/stores';
import { useAuth } from '@/hooks/useAuth';
import { useRouter, usePathname } from 'next/navigation';
import { useEffect } from 'react';

export function Navbar() {
  const { isAuthenticated, user, logout } = useAuth();
  const { isAdminMode, setAdminMode } = useAuthStore();
  const router = useRouter();
  const pathname = usePathname();

  const isAdmin = user?.roles?.some(role => role.name === 'ROLE_ADMIN');
  
  // Determine if we're actually in admin mode based on current route
  const isActuallyInAdminMode = pathname.startsWith('/admin');

  const handleAdminToggle = (checked: boolean) => {
    if (checked) {
      // Switch to admin mode
      if (isAdmin) {
        setAdminMode(true);
        // Navigate to admin dashboard if not already there
        if (!pathname.startsWith('/admin')) {
          router.push('/admin');
        }
      }
    } else {
      // Switch to user mode
      setAdminMode(false);
      // Navigate to home page when switching to user mode
      router.push('/');
    }
  };

  // Sync the store state with the actual route when component mounts or route changes
  useEffect(() => {
    if (isAdmin) {
      setAdminMode(isActuallyInAdminMode);
    }
  }, [pathname, isAdmin, setAdminMode]);

  return (
    <nav className="border-b bg-white/80 backdrop-blur-md sticky top-0 z-50">
      <div className="mx-auto px-4 sm:px-6 lg:px-8">
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
                
                {/* User Dropdown Menu */}
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="sm" className="flex items-center gap-2">
                      <User className="h-4 w-4" />
                      <span>{user.username}</span>
                      <ChevronDown className="h-3 w-3" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent className="w-56" align="end">
                    <DropdownMenuLabel>Account</DropdownMenuLabel>
                    <DropdownMenuSeparator />
                    
                    {/* Admin Mode Toggle */}
                    {isAdmin && (
                      <>
                        <div className="flex items-center justify-between px-2 py-1.5">
                          <span className="text-sm">Admin Mode</span>
                          <Switch
                            checked={isActuallyInAdminMode}
                            onCheckedChange={handleAdminToggle}
                          />
                        </div>
                        <DropdownMenuSeparator />
                      </>
                    )}
                    
                    {/* Profile Link */}
                    <DropdownMenuItem asChild>
                      <Link href="/profile" className="flex items-center">
                        <User className="h-4 w-4 mr-2" />
                        View Profile
                      </Link>
                    </DropdownMenuItem>
                    
                    {/* Logout */}
                    <DropdownMenuItem onClick={logout} className="text-red-600 focus:text-red-600">
                      <LogOut className="h-4 w-4 mr-2" />
                      Logout
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
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