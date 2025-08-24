import { NextRequest, NextResponse } from 'next/server';

import { logger } from '@/lib/utils';
export async function GET(request: NextRequest) {
  try {
    // Get the auth token from the request headers
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header is required' },
        { status: 401 }
      );
    }

    // Get query parameters
    const { searchParams } = new URL(request.url);
    const isActive = searchParams.get('isActive');
    const deviceType = searchParams.get('deviceType');
    const page = searchParams.get('page') || '0';
    const size = searchParams.get('size') || '20';

    // Build query string
    const queryParams = new URLSearchParams();
    if (isActive !== null) queryParams.append('isActive', isActive);
    if (deviceType !== null) queryParams.append('deviceType', deviceType);
    queryParams.append('page', page);
    queryParams.append('size', size);

    // Forward the request to the backend
    const backendResponse = await fetch(`http://localhost:8080/api/v1/sessions/my?${queryParams.toString()}`, {
      method: 'GET',
      headers: {
        'Authorization': authHeader,
      },
    });

    // Return the backend response as-is
    const responseData = await backendResponse.json();
    return NextResponse.json(responseData, { status: backendResponse.status });

  } catch (error) {
    logger.error('Get my sessions error:', error);
    return NextResponse.json(
      { error: 'Failed to get sessions' },
      { status: 500 }
    );
  }
}
