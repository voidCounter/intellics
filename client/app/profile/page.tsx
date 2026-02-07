'use client';

import { ProtectedRoute } from '@/components/auth/protected-route';
import { useAuthStore } from '@/lib/stores/auth-store';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { ActiveSessionsList } from '@/components/sessions/active-sessions-list';
import { ProfileStats } from '@/components/profile/profile-stats';
import { Button } from '@/components/ui/button';
import { User, Mail, Shield, LogOut, Settings, Bell, ExternalLink } from 'lucide-react';

export default function ProfilePage() {
  const { user, logout } = useAuthStore();

  const getInitials = (name?: string) => {
    if (!name) return 'U';
    return name.charAt(0).toUpperCase();
  };

  return (
    <ProtectedRoute>
      <div className="min-h-screen bg-slate-50">
        <div className="container mx-auto px-4 py-12">
          <div className="max-w-4xl mx-auto space-y-12">
            
            {/* Minimalist Profile Header */}
            <div className="flex flex-col md:flex-row items-center justify-between gap-8 pb-12 border-b border-slate-200">
              <div className="flex flex-col md:flex-row items-center gap-6">
                <div className="w-24 h-24 rounded-xl border border-slate-200 bg-white flex items-center justify-center text-3xl font-bold text-slate-900">
                  {getInitials(user?.username)}
                </div>
                <div className="text-center md:text-left">
                  <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
                    {user?.username}
                  </h1>
                  <p className="text-slate-500 text-sm font-medium flex items-center gap-1.5 justify-center md:justify-start mt-1">
                    <User className="h-4 w-4" />
                    Student Account
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-2">
                <Button 
                  variant="ghost" 
                  className="rounded-lg text-red-600 hover:text-red-700 hover:bg-red-50 px-4 h-9 text-xs font-bold"
                  onClick={() => logout()}
                >
                  <LogOut className="h-3.5 w-3.5 mr-2" /> 
                  Sign Out
                </Button>
              </div>
            </div>

            {/* Quick Stats Grid */}
            <ProfileStats />

            {/* Main Activity */}
            <ActiveSessionsList className="border border-slate-200 bg-white" />

          </div>
        </div>
      </div>
    </ProtectedRoute>
  );
}
          