import { NextRequest, NextResponse } from 'next/server';

import { logger } from '@/lib/utils';
const BACKEND_URL =  process.env.BACKEND_API || 'http://localhost:8080';

export async function GET(
  request: NextRequest,
  { params }: { params: { lessonId: string } }
) {
  try {
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header required' },
        { status: 401 }
      );
    }

    // Forward the request to the backend
    const response = await fetch(`${BACKEND_URL}/api/v1/lessons/${params.lessonId}/with-kcs`, {
      headers: {
        'Authorization': authHeader,
      },
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      return NextResponse.json(
        { error: errorData.message || 'Backend request failed' },
        { status: response.status }
      );
    }

    const data = await response.json();
    return NextResponse.json(data);
  } catch (error) {
    logger.error('Error fetching lesson with KCs:', error);
    return NextResponse.json(
      { error: 'Failed to fetch lesson with KCs' },
      { status: 500 }
    );
  }
}
