'use client';

import { useUserSessions } from '@/hooks/useUserSessions';
import { useSessionStore } from '@/lib/stores/session-store';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { RefreshCw, Monitor, Smartphone, Tablet, Clock, User } from 'lucide-react';

import { logger } from '@/lib/utils';
interface ActiveSessionsListProps {
  title?: string;
  showRefreshButton?: boolean;
  className?: string;
}

// Utility function to safely parse dates
const formatDate = (dateString: string | null | undefined): string => {
  if (!dateString) return 'Unknown';
  
  try {
    const date = new Date(dateString);
    
    // Check if the date is valid
    if (isNaN(date.getTime())) {
      logger.warn('Invalid date string:', dateString);
      return 'Invalid Date';
    }
    
    return date.toLocaleString(undefined, {
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
      hour12: true
    });
  } catch (error) {
    logger.error('Error parsing date:', dateString, error);
    return 'Invalid Date';
  }
};

// Get device icon based on device type
const getDeviceIcon = (deviceType: string | null | undefined) => {
  switch (deviceType?.toLowerCase()) {
    case 'mobile':
      return <Smartphone className="h-4 w-4" />;
    case 'tablet':
      return <Tablet className="h-4 w-4" />;
    case 'desktop':
    default:
      return <Monitor className="h-4 w-4" />;
  }
};

export function ActiveSessionsList({ 
  title = "Active Sessions", 
  showRefreshButton = true,
  className = ""
}: ActiveSessionsListProps) {
  const { sessionId } = useSessionStore();
  const { sessions: allSessions, isLoading: sessionsLoading, error: sessionsError, refetch } = useUserSessions({ isActive: true });

  // Separate current session from other sessions
  const currentSession = allSessions.find(s => s.sessionId === sessionId);
  const otherSessions = allSessions.filter(s => s.sessionId !== sessionId);

  return (
    <Card className={`border border-slate-200 rounded-lg overflow-hidden bg-white ${className}`}>
      <CardHeader className="border-b border-slate-100 bg-slate-50/50 px-6 py-4">
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="text-lg font-bold text-slate-900 flex items-center gap-2">
              <User className="h-5 w-5 text-slate-900" />
              {title}
            </CardTitle>
            <CardDescription className="text-slate-500 mt-0.5 text-xs">Manage your active login sessions</CardDescription>
          </div>
          {showRefreshButton && (
            <Button
              variant="outline"
              size="sm"
              onClick={refetch}
              disabled={sessionsLoading}
              className="rounded-xl border-slate-200 shadow-sm font-bold text-slate-600 px-4"
            >
              <RefreshCw className={`h-4 w-4 mr-2 ${sessionsLoading ? 'animate-spin' : ''}`} />
              Refresh
            </Button>
          )}
        </div>
      </CardHeader>
      <CardContent className="px-6 py-6 space-y-6">
        {sessionsLoading ? (
          <div className="text-center py-12">
            <div className="flex items-center justify-center space-x-2">
              <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-primary"></div>
              <span className="text-muted-foreground">Loading sessions...</span>
            </div>
          </div>
        ) : sessionsError ? (
          <div className="text-center py-12">
            <div className="text-destructive">Error loading sessions: {sessionsError}</div>
          </div>
        ) : allSessions.length === 0 ? (
          <div className="text-center py-12">
            <div className="text-muted-foreground">No active sessions found</div>
          </div>
        ) : (
          <>
            {currentSession && (
              <div className="space-y-4">
                <div className="flex items-center space-x-2">
                  <div className="w-1.5 h-1.5 bg-blue-600 rounded-full"></div>
                  <h3 className="text-xs font-bold text-slate-900 uppercase tracking-wider">Current Session</h3>
                </div>
                
                <div className="border border-slate-200 rounded-lg p-4 bg-slate-50/50">
                  <div className="flex items-center justify-between mb-4">
                    <div className="flex items-center space-x-2">
                      <div className="p-2 bg-white border border-slate-200 rounded-md">
                        {getDeviceIcon(currentSession.deviceType)}
                      </div>
                      <Badge className="bg-blue-600 hover:bg-blue-700 text-white border-0 font-bold px-1.5 py-0 text-[9px]">
                        ACTIVE NOW
                      </Badge>
                    </div>
                    <div className="text-[9px] text-slate-400 font-mono">
                      ID: {currentSession.sessionId.substring(0, 6)}
                    </div>
                  </div>
                  
                  <div className="grid grid-cols-2 gap-4 text-[10px]">
                    <div>
                      <div className="text-[9px] text-slate-400 font-bold uppercase mb-0.5">Started</div>
                      <div className="font-semibold text-slate-900">
                        {formatDate(currentSession.startTime)}
                      </div>
                    </div>
                    <div>
                      <div className="text-[9px] text-slate-400 font-bold uppercase mb-0.5">Last Sync</div>
                      <div className="font-semibold text-slate-900">
                        {currentSession.lastActiveAt ? formatDate(currentSession.lastActiveAt) : 'Just now'}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {otherSessions.length > 0 && (
              <div className="space-y-4 pt-4 border-t border-slate-100">
                <div className="flex items-center space-x-2">
                  <div className="w-1.5 h-1.5 bg-slate-300 rounded-full"></div>
                  <h3 className="text-xs font-bold text-slate-400 uppercase tracking-wider">
                    Other Active Devices ({otherSessions.length})
                  </h3>
                </div>
                
                <div className="grid grid-cols-1 gap-2">
                  {otherSessions.map((session) => (
                    <div
                      key={session.sessionId}
                      className="bg-white border border-slate-100 rounded-lg p-3 flex items-center justify-between"
                    >
                      <div className="flex items-center space-x-3">
                        <div className="p-2 bg-slate-50 border border-slate-100 rounded-md">
                          {getDeviceIcon(session.deviceType)}
                        </div>
                        <div className="space-y-0.5">
                          <div className="text-[10px] font-bold text-slate-900 uppercase tracking-tight">
                            {session.deviceType || 'Unknown Device'}
                          </div>
                          <div className="text-[10px] text-slate-400 font-medium">
                            {formatDate(session.startTime)}
                          </div>
                        </div>
                      </div>
                      <div className="text-[8px] text-slate-200 font-mono">
                        {session.sessionId.substring(0, 6)}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </>
        )}
      </CardContent>
    </Card>
  );
}
