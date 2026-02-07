'use client';

import Link from 'next/link';
import Image from 'next/image';
import { Home, User, LogOut, Settings, ChevronDown, Network, Menu, X } from 'lucide-react';
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
import { useEffect, useState } from 'react';

export function Navbar() {
  const { isAuthenticated, user, logout } = useAuth();
  const { isAdminMode, setAdminMode } = useAuthStore();
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const router = useRouter();
  const pathname = usePathname();

  const isAdmin = user?.roles?.some(role => role.name === 'ROLE_ADMIN');
  
  // Determine if we're actually in admin mode based on current route
  const isActuallyInAdminMode = pathname.startsWith('/admin');

  const handleAdminToggle = (checked: boolean) => {
    if (checked) {
      if (isAdmin) {
        setAdminMode(true);
        if (!pathname.startsWith('/admin')) {
          router.push('/admin');
        }
      }
    } else {
      setAdminMode(false);
      router.push('/');
    }
  };

  useEffect(() => {
    if (isAdmin) {
      setAdminMode(isActuallyInAdminMode);
    }
  }, [pathname, isAdmin, setAdminMode]);

  // Close menu when route changes
  useEffect(() => {
    setIsMenuOpen(false);
  }, [pathname]);

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

          {/* Desktop Navigation */}
          <div className="hidden md:flex items-center space-x-4">
            {isAuthenticated && user ? (
              <>
                <Button variant="ghost" size="sm" asChild>
                  <Link href="/" className="flex items-center space-x-2">
                    <Home className="h-4 w-4" />
                    <span>Home</span>
                  </Link>
                </Button>

                <Button variant="ghost" size="sm" asChild>
                  <Link href="/knowledge-map" className="flex items-center space-x-2">
                    <Network className="h-4 w-4" />
                    <span>Knowledge Map</span>
                  </Link>
                </Button>
                
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
                    
                    <DropdownMenuItem asChild>
                      <Link href="/profile" className="flex items-center">
                        <User className="h-4 w-4 mr-2" />
                        View Profile
                      </Link>
                    </DropdownMenuItem>

                    <DropdownMenuItem asChild>
                      <Link href="/settings/api-keys" className="flex items-center">
                        <Settings className="h-4 w-4 mr-2" />
                        Settings
                      </Link>
                    </DropdownMenuItem>
                    
                    <DropdownMenuSeparator />
                    
                    <DropdownMenuItem onClick={logout} className="text-red-600 focus:text-red-600">
                      <LogOut className="h-4 w-4 mr-2" />
                      Logout
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </>
            ) : null}
          </div>

          {/* Mobile Menu Toggle */}
          <div className="md:hidden flex items-center">
            {isAuthenticated && (
              <Button 
                variant="ghost" 
                size="icon" 
                onClick={() => setIsMenuOpen(!isMenuOpen)}
                className="text-slate-600"
              >
                {isMenuOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
              </Button>
            )}
          </div>
        </div>
      </div>

      {/* Mobile Menu Container */}
      {isMenuOpen && isAuthenticated && user && (
        <div className="md:hidden border-t border-slate-100 bg-white animate-in slide-in-from-top-4 duration-200">
          <div className="px-4 pt-4 pb-6 space-y-2">
            <Link 
              href="/" 
              className="flex items-center space-x-3 p-3 rounded-lg hover:bg-slate-50 text-slate-700 font-medium"
            >
              <Home className="h-5 w-5 text-blue-500" />
              <span>Home</span>
            </Link>
            
            <Link 
              href="/knowledge-map" 
              className="flex items-center space-x-3 p-3 rounded-lg hover:bg-slate-50 text-slate-700 font-medium"
            >
              <Network className="h-5 w-5 text-blue-500" />
              <span>Knowledge Map</span>
            </Link>
            
            <Link 
              href="/profile" 
              className="flex items-center space-x-3 p-3 rounded-lg hover:bg-slate-50 text-slate-700 font-medium"
            >
              <User className="h-5 w-5 text-blue-500" />
              <span>Profile</span>
            </Link>

            <Link 
              href="/settings/api-keys" 
              className="flex items-center space-x-3 p-3 rounded-lg hover:bg-slate-50 text-slate-700 font-medium"
            >
              <Settings className="h-5 w-5 text-blue-500" />
              <span>Settings</span>
            </Link>

            {isAdmin && (
              <div className="flex items-center justify-between p-3 border-t border-slate-50 mt-2">
                <span className="text-sm font-medium text-slate-700">Admin Mode</span>
                <Switch
                  checked={isActuallyInAdminMode}
                  onCheckedChange={handleAdminToggle}
                />
              </div>
            )}

            <button 
              onClick={logout}
              className="w-full flex items-center space-x-3 p-3 rounded-lg hover:bg-red-50 text-red-600 font-medium border-t border-slate-50 mt-2"
            >
              <LogOut className="h-5 w-5" />
              <span>Logout</span>
            </button>
          </div>
        </div>
      )}
    </nav>
  );
}