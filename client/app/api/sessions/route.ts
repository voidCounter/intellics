import { NextRequest, NextResponse } from 'next/server';
import { getDeviceTypeForBackend } from '@/lib/utils/server-device-detection';

export async function POST(request: NextRequest) {
  try {
    // Get the auth token from the request headers
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header is required' },
        { status: 401 }
      );
    }

    // Get user agent and device type from the request
    const userAgent = request.headers.get('user-agent') || 'Unknown';
    const deviceType = getDeviceTypeForBackend(userAgent);

    // Prepare the session creation payload
    const sessionPayload = {
      userAgent,
      deviceType,
    };

    // Forward the request to the backend
    const backendResponse = await fetch('http://localhost:8080/api/v1/sessions', {
      method: 'POST',
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(sessionPayload),
    });

    // Just return the backend response as-is
    const responseData = await backendResponse.json();
    return NextResponse.json(responseData, { status: backendResponse.status });

  } catch (error) {
    console.error('Session creation error:', error);
    return NextResponse.json(
      { error: 'Failed to create session' },
      { status: 500 }
    );
  }
}
