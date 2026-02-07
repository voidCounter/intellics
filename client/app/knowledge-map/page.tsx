'use client';

import { ProtectedRoute } from '@/components/auth/protected-route';
import { KCDependencyGraph } from '@/components/profile/kc-dependency-graph';

export default function KnowledgeMapPage() {
  return (
    <ProtectedRoute>
      <div className="w-screen h-[calc(100vh-64px)] overflow-hidden">
        <KCDependencyGraph fullscreen={true} />
      </div>
    </ProtectedRoute>
  );
}
