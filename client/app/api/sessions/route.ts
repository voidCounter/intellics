import { NextRequest, NextResponse } from 'next/server';
import { getDeviceTypeForBackend } from '@/lib/utils/server-device-detection';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { userId, lessonId, moduleId } = body;

    const backendUrl = process.env.BACKEND_API_URL || 'http://localhost:8080';
    const backendResponse = await fetch(`${backendUrl}/api/v1/sessions`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        userId,
        lessonId,
        moduleId,
        startTime: new Date().toISOString(),
      }),
    });

    if (!backendResponse.ok) {
      const errorData = await backendResponse.json().catch(() => ({}));
      return NextResponse.json(errorData, { status: backendResponse.status });
    }

    const sessionData = await backendResponse.json();
    return NextResponse.json(sessionData);
  } catch (error) {
    console.error('Error creating session:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
