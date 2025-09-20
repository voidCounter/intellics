'use client';

import { ProtectedRoute } from '@/components/auth/protected-route';
import { useAuthStore } from '@/lib/stores/auth-store';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { ActiveSessionsList } from '@/components/sessions/active-sessions-list';
import { KCMasteryChart } from '@/components/profile/kc-mastery-chart';
import { useUserKCMastery } from '@/hooks/useUserKCMastery';
import { AlertCircle, Loader2 } from 'lucide-react';

export default function ProfilePage() {
  const { user } = useAuthStore();
  const { data: kcMasteryData, isLoading: kcLoading, error: kcError } = useUserKCMastery();

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-8">
        <div className="max-w-4xl mx-auto space-y-6">
          <div className="text-center">
            <h1 className="text-3xl font-bold text-gray-900 mb-4">Profile</h1>
          </div>

          {/* User Info */}
          {user && (
            <Card>
              <CardHeader>
                <CardTitle>User Information</CardTitle>
              </CardHeader>
              <CardContent className="space-y-2">
                <div><strong>Username:</strong> {user.username}</div>
                <div><strong>Roles:</strong> {user.roles.map(r => r.name).join(', ')}</div>
              </CardContent>
            </Card>
          )}

          {/* KC Mastery Chart */}
          {kcLoading && (
            <Card>
              <CardHeader>
                <CardTitle>Knowledge Component Mastery</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex items-center justify-center py-8">
                  <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
                  <span className="ml-2 text-gray-600">Loading mastery data...</span>
                </div>
              </CardContent>
            </Card>
          )}

          {kcError && (
            <Card>
              <CardHeader>
                <CardTitle>Knowledge Component Mastery</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex items-center justify-center py-8 text-red-600">
                  <AlertCircle className="h-8 w-8 mr-2" />
                  <span>Failed to load mastery data. Please try again later.</span>
                </div>
              </CardContent>
            </Card>
          )}

          {!kcLoading && !kcError && (
            <KCMasteryChart kcMasteryData={kcMasteryData || []} />
          )}

          {/* Active Sessions */}
          <ActiveSessionsList />
        </div>
      </div>
    </ProtectedRoute>
  );
}