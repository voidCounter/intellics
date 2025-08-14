import { useEffect, useRef } from 'react';
import { useSessionStore } from '@/lib/stores/session-store';
import { useAuthStore } from '@/lib/stores/auth-store';
import { detectDeviceInfoFromUserAgent } from '@/lib/utils/server-device-detection';
import { Session } from '@/types/api';

export const useSessionManager = () => {
  const { isAuthenticated, user } = useAuthStore(); // Get the logged-in user
  const { sessionId, status, setSession, setInactive, setActive, clearSession, updateSessionDetails } = useSessionStore();
  const heartbeatIntervalRef = useRef<NodeJS.Timeout | null>(null);
  const isCreatingSessionRef = useRef(false); // Track if we're currently creating a session
  const HEARTBEAT_INTERVAL = 15 * 1000; // 15 seconds

  // Helper function to update session details from API response
  const updateSessionFromResponse = (responseData: any) => {
    if (responseData.data) {
      const updatedSession: Session = {
        sessionId: responseData.data.sessionId,
        userId: responseData.data.userId,
        startTime: responseData.data.startTime,
        endTime: responseData.data.endTime,
        lastActiveAt: responseData.data.lastActiveAt,
        deviceType: responseData.data.deviceType,
        userAgent: responseData.data.userAgent,
        createdAt: responseData.data.createdAt,
        updatedAt: responseData.data.updatedAt,
      };
      updateSessionDetails(updatedSession);
      return true;
    }
    return false;
  };

  // 1. Initialize session on app load
  useEffect(() => {
    if (!isAuthenticated || !user) return; // Don't run if user is not logged in
    if (sessionId) return; // Don't create if session already exists
    if (isCreatingSessionRef.current) return; // Don't create if we're already creating one

    const initializeSession = async () => {
      try {
        isCreatingSessionRef.current = true; // Mark that we're creating a session
        
        const token = localStorage.getItem('authToken');
        if (!token) return;

        console.log('Creating new session...');
        
        const response = await fetch('/api/sessions', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            userAgent: navigator.userAgent,
            deviceType: detectDeviceInfoFromUserAgent(navigator.userAgent).deviceType,
          }),
        });
        
        if (response.ok) {
          const sessionData = await response.json();
          console.log('Session created successfully:', sessionData.data.sessionId);
          
          // Extract session details from the response
          const sessionDetails: Session = {
            sessionId: sessionData.data.sessionId,
            userId: sessionData.data.userId,
            startTime: sessionData.data.startTime,
            endTime: sessionData.data.endTime,
            lastActiveAt: sessionData.data.lastActiveAt,
            deviceType: sessionData.data.deviceType,
            userAgent: sessionData.data.userAgent,
            createdAt: sessionData.data.createdAt,
            updatedAt: sessionData.data.updatedAt,
          };
          
          setSession(sessionData.data.sessionId, sessionDetails);
        } else {
          console.log('Session creation failed, will retry...');
        }
      } catch (error) {
        console.error('Failed to initialize session:', error);
      } finally {
        isCreatingSessionRef.current = false; // Reset the flag
      }
    };

    initializeSession();
  }, [isAuthenticated, user, sessionId, setSession]);

  // 2. Manage the heartbeat timer based on session status
  useEffect(() => {
    // Clear any existing interval
    if (heartbeatIntervalRef.current) {
      clearInterval(heartbeatIntervalRef.current);
    }

    if (status === 'active' && sessionId) {
      heartbeatIntervalRef.current = setInterval(async () => {
        try {
          const token = localStorage.getItem('authToken');
          if (!token) return;
          console.log('Sending heartbeat for session:', sessionId);

          const res = await fetch(`/api/sessions/${sessionId}/heartbeat`, {
            method: 'PUT',
            headers: {
              'Authorization': `Bearer ${token}`,
            },
          });
          
          if (res.status === 404) {
            // Session is not found (closed by bg job), stop heartbeats
            console.log('Session not found (ended by background job), clearing session');
            clearSession();
          } else if (res.ok) {
            // Update session details with the latest information from heartbeat response
            const updatedSessionData = await res.json();
            if (updateSessionFromResponse(updatedSessionData)) {
              console.log('Session details updated after heartbeat');
            }
          }
        } catch (error) {
          console.error('Heartbeat failed:', error);
        }
      }, HEARTBEAT_INTERVAL); // Every 10 seconds
    }

    // Cleanup function to clear interval on component unmount or status change
    return () => {
      if (heartbeatIntervalRef.current) {
        clearInterval(heartbeatIntervalRef.current);
      }
    };
  }, [status, sessionId, clearSession, updateSessionDetails]);

  // 3. Listen for tab visibility changes to pause/resume heartbeats and validate sessions
  useEffect(() => {
    const handleVisibilityChange = () => {
      if (document.visibilityState === 'hidden') {
        setInactive();
      } else {
        // When returning to tab, immediately validate the session
        setActive();
        if (sessionId) {
          validateSessionImmediately();
        }
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);
    return () => {
      document.removeEventListener('visibilitychange', handleVisibilityChange);
    };
  }, [setActive, setInactive, sessionId]);
    
  // 4. Handle user closing the tab
  useEffect(() => {
    const handleBeforeUnload = () => {
      if (!sessionId) return;
      
      const payload = { sessionId };
      const blob = new Blob([JSON.stringify(payload)], { type: 'application/json' });
      
      // Use sendBeacon for reliable data transmission on exit
      navigator.sendBeacon(`/api/sessions/${sessionId}/end`, blob);
    };

    window.addEventListener('beforeunload', handleBeforeUnload);
    return () => {
      window.removeEventListener('beforeunload', handleBeforeUnload);
    };
  }, [sessionId]);

  // Helper function to immediately validate session when returning to tab
  const validateSessionImmediately = async () => {
    if (!sessionId) return;
    
    try {
      const token = localStorage.getItem('authToken');
      if (!token) return;

      console.log('Immediately validating session when returning to tab:', sessionId);
      
      const res = await fetch(`/api/sessions/${sessionId}/heartbeat`, {
        method: 'PUT',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });
      
      if (res.status === 404) {
        // Session not found (ended by background job), clear it immediately
        console.log('Session validation failed - session ended by background job, clearing immediately');
        clearSession();
      } else if (res.ok) {
        // Update session details with the latest information from validation response
        const updatedSessionData = await res.json();
        if (updateSessionFromResponse(updatedSessionData)) {
          console.log('Session validation successful - session details updated');
        } else {
          console.log('Session validation successful - continuing with existing session');
        }
      }
    } catch (error) {
      console.error('Immediate session validation failed:', error);
      // On error, clear session to be safe
      clearSession();
    }
  };
};
