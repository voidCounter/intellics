import { NextRequest, NextResponse } from 'next/server';

import { logger } from '@/lib/utils';
export async function GET(request: NextRequest) {
  try {
    const authHeader = request.headers.get('authorization');
    
    if (!authHeader) {
      return NextResponse.json({ error: 'Authorization header required' }, { status: 401 });
    }

    const backendUrl = process.env.BACKEND_API_URL || 'http://localhost:8080';
    const backendResponse = await fetch(`${backendUrl}/api/v1/users/me`, {
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
    });

    if (!backendResponse.ok) {
      const errorData = await backendResponse.json().catch(() => ({}));
      return NextResponse.json(errorData, { status: backendResponse.status });
    }

    const userData = await backendResponse.json();
    return NextResponse.json(userData);
  } catch (error) {
    logger.error('Error fetching user:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
