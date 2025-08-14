'use client';

import { ProtectedRoute } from '@/components/auth/protected-route';
import { useAuthStore } from '@/lib/stores/auth-store';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { ActiveSessionsList } from '@/components/sessions/active-sessions-list';

export default function ProfilePage() {
  const { user } = useAuthStore();

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

          {/* Active Sessions */}
          <ActiveSessionsList />
        </div>
      </div>
    </ProtectedRoute>
  );
}