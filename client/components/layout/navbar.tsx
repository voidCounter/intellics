'use client';

import Link from 'next/link';
import Image from 'next/image';
import { Home, User, LogOut, Settings, ChevronDown } from 'lucide-react';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { useAuthStore } from '@/lib/stores';
import { useAuth } from '@/hooks/useAuth';

export function Navbar() {
  const { isAuthenticated, user, logout } = useAuth();
  const { isAdminMode, setAdminMode } = useAuthStore();

  const isAdmin = user?.roles?.some(role => role.name === 'ROLE_ADMIN');

  const handleAdminToggle = (value: string) => {
    if (value === 'admin') {
      // Double-check admin role for security
      if (isAdmin) {
        setAdminMode(true);
      }
    } else {
      setAdminMode(false);
    }
  };

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
                        <DropdownMenuLabel className="text-xs text-muted-foreground">
                          Admin Mode
                        </DropdownMenuLabel>
                        <DropdownMenuRadioGroup value={isAdminMode ? 'admin' : 'user'} onValueChange={handleAdminToggle}>
                          <DropdownMenuRadioItem value="user">
                            <User className="h-4 w-4 mr-2" />
                            User Mode
                          </DropdownMenuRadioItem>
                          <DropdownMenuRadioItem value="admin">
                            <Settings className="h-4 w-4 mr-2" />
                            Admin Mode
                          </DropdownMenuRadioItem>
                        </DropdownMenuRadioGroup>
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