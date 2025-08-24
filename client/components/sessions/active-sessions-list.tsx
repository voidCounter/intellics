'use client';

import { useUserSessions } from '@/hooks/useUserSessions';
import { useSessionStore } from '@/lib/stores/session-store';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
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
    
    return date.toLocaleString();
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
    <Card className={className}>
      <CardHeader>
        <div className="flex items-center justify-between">
          <CardTitle className="flex items-center space-x-2">
            <User className="h-5 w-5" />
            <span>{title}</span>
          </CardTitle>
          {showRefreshButton && (
            <Button
              variant="outline"
              size="sm"
              onClick={refetch}
              disabled={sessionsLoading}
              className="flex items-center space-x-2"
            >
              <RefreshCw className={`h-4 w-4 ${sessionsLoading ? 'animate-spin' : ''}`} />
              <span>Refresh</span>
            </Button>
          )}
        </div>
      </CardHeader>
      <CardContent className="space-y-6">
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
            {/* Current Session - Highlighted at top */}
            {currentSession && (
              <div className="space-y-4">
                <div className="flex items-center space-x-2">
                  <div className="w-2 h-2 bg-primary rounded-full animate-pulse"></div>
                  <h3 className="text-lg font-semibold text-foreground">Current Session</h3>
                </div>
                
                <div className="bg-gradient-to-r from-primary/5 to-primary/10 border-2 border-primary/20 rounded-xl p-6 shadow-sm">
                  <div className="flex items-start justify-between mb-4">
                    <div className="flex items-center space-x-3">
                      <div className="p-2 bg-primary/10 rounded-lg">
                        {getDeviceIcon(currentSession.deviceType)}
                      </div>
                      <div>
                        <div className="flex items-center space-x-2">
                          <Badge variant="default" className="bg-primary text-primary-foreground">
                            Active Now
                          </Badge>
                        </div>
                      </div>
                    </div>
                    <div className="text-xs text-muted-foreground font-mono bg-card px-2 py-1 rounded border border-border">
                      {currentSession.sessionId.substring(0, 8)}...
                    </div>
                  </div>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                    <div className="flex items-center space-x-2">
                      <Clock className="h-4 w-4 text-muted-foreground" />
                      <div>
                        <div className="text-xs text-muted-foreground uppercase tracking-wide">Started</div>
                        <div className="text-sm font-medium text-foreground">
                          {formatDate(currentSession.startTime)}
                        </div>
                      </div>
                    </div>
                    
                    <div className="flex items-center space-x-2">
                      <div className="w-2 h-2 bg-primary rounded-full"></div>
                      <div>
                        <div className="text-xs text-muted-foreground uppercase tracking-wide">Last Active</div>
                        <div className="text-sm font-medium text-foreground">
                          {currentSession.lastActiveAt ? formatDate(currentSession.lastActiveAt) : 'Just now'}
                        </div>
                      </div>
                    </div>
                  </div>
                  
                  <div>
                    <div className="text-xs text-muted-foreground uppercase tracking-wide mb-2">User Agent</div>
                    <div className="text-xs text-foreground font-mono bg-card p-3 rounded-lg border border-border break-all">
                      {currentSession.userAgent || 'Unknown'}
                    </div>
                  </div>
                </div>
              </div>
            )}

            {/* Other Sessions */}
            {otherSessions.length > 0 && (
              <div className="space-y-4">
                <div className="flex items-center space-x-2">
                  <div className="w-2 h-2 bg-muted-foreground rounded-full"></div>
                  <h3 className="text-lg font-semibold text-foreground">
                    Other Active Sessions ({otherSessions.length})
                  </h3>
                </div>
                
                <div className="grid gap-4">
                  {otherSessions.map((session) => (
                    <div
                      key={session.sessionId}
                      className="bg-muted/30 border border-border rounded-lg p-4 hover:shadow-md transition-shadow"
                    >
                      <div className="flex items-start justify-between mb-3">
                        <div className="flex items-center space-x-3">
                          <div className="p-2 bg-muted rounded-lg">
                            {getDeviceIcon(session.deviceType)}
                          </div>
                          <div>
                            <div className="flex items-center space-x-2">
                            </div>
                          </div>
                        </div>
                        <div className="text-xs text-muted-foreground font-mono bg-card px-2 py-1 rounded border border-border">
                          {session.sessionId.substring(0, 8)}...
                        </div>
                      </div>
                      
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                        <div className="flex items-center space-x-2">
                          <Clock className="h-4 w-4 text-muted-foreground" />
                          <div>
                            <div className="text-xs text-muted-foreground">Started</div>
                            <div className="text-foreground">
                              {formatDate(session.startTime)}
                            </div>
                          </div>
                        </div>
                        
                        <div className="flex items-center space-x-2">
                          <div className="w-2 h-2 bg-muted-foreground rounded-full"></div>
                          <div>
                            <div className="text-xs text-muted-foreground">Last Active</div>
                            <div className="text-foreground">
                              {session.lastActiveAt ? formatDate(session.lastActiveAt) : 'Not tracked yet'}
                            </div>
                          </div>
                        </div>
                      </div>
                      
                      <div className="mt-3">
                        <div className="text-xs text-muted-foreground mb-2">User Agent</div>
                        <div className="text-xs text-foreground font-mono bg-card p-2 rounded border border-border break-all">
                          {session.userAgent || 'Unknown'}
                        </div>
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
