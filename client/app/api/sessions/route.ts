import { NextRequest, NextResponse } from 'next/server';
import { getDeviceTypeForBackend } from '@/lib/utils/server-device-detection';

import { logger } from '@/lib/utils';
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { userAgent, deviceType } = body;

    // Get the auth token from the request headers
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header is required' },
        { status: 401 }
      );
    }

    const backendUrl =  process.env.BACKEND_API || 'http://localhost:8080';
    const backendResponse = await fetch(`${backendUrl}/api/v1/sessions`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': authHeader,
      },
      body: JSON.stringify({
        userAgent,
        deviceType,
      }),
    });

    if (!backendResponse.ok) {
      const errorData = await backendResponse.json().catch(() => ({}));
      return NextResponse.json(errorData, { status: backendResponse.status });
    }

    const sessionData = await backendResponse.json();
    return NextResponse.json(sessionData);
  } catch (error) {
    logger.error('Error creating session:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
