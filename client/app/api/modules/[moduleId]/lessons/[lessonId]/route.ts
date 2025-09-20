import { NextRequest, NextResponse } from 'next/server';

import { logger } from '@/lib/utils';
export async function DELETE(
  request: NextRequest,
  { params }: { params: { moduleId: string; lessonId: string } }
) {
  try {
    const { moduleId, lessonId } = params;
    
    // Get the auth token from the request headers
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header required' },
        { status: 401 }
      );
    }

    // Proxy the request to the backend
    const backendUrl =  process.env.BACKEND_API || 'http://localhost:8080';
    const response = await fetch(`${backendUrl}/api/v1/modules/${moduleId}/lessons/${lessonId}`, {
      method: 'DELETE',
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      return NextResponse.json(
        { error: errorData.message || 'Failed to remove lesson from module' },
        { status: response.status }
      );
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    logger.error('Error removing lesson from module:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
