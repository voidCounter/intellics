import { NextRequest, NextResponse } from 'next/server';

import { logger } from '@/lib/utils';
export async function PUT(
  request: NextRequest,
  { params }: { params: Promise<{ sessionId: string }> }
) {
  try {
    const { sessionId } = await params;
    
    // Get the auth token from the request headers
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header is required' },
        { status: 401 }
      );
    }

    // Forward the request to the backend (no request body needed)
    const backendResponse = await fetch(`http://localhost:8080/api/v1/sessions/${sessionId}/end`, {
      method: 'PUT',
      headers: {
        'Authorization': authHeader,
      },
    });

    // Just return the backend response as-is
    const responseData = await backendResponse.json();
    return NextResponse.json(responseData, { status: backendResponse.status });

  } catch (error) {
    logger.error('Session end error:', error);
    return NextResponse.json(
      { error: 'Failed to end session' },
      { status: 500 }
    );
  }
}
