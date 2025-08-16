import { NextRequest, NextResponse } from 'next/server';

const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:8080';

export async function PATCH(
  request: NextRequest,
  { params }: { params: { lessonId: string; kcId: string } }
) {
  try {
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header required' },
        { status: 401 }
      );
    }

    const body = await request.json();
    const { targetMastery } = body;

    if (targetMastery === undefined) {
      return NextResponse.json(
        { error: 'Target mastery is required' },
        { status: 400 }
      );
    }

    // Forward the request to the backend
    const response = await fetch(`${BACKEND_URL}/api/v1/lessons/${params.lessonId}/kcs/${params.kcId}`, {
      method: 'PATCH',
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ targetMastery }),
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
    console.error('Error updating lesson-KC mapping:', error);
    return NextResponse.json(
      { error: 'Failed to update lesson-KC mapping' },
      { status: 500 }
    );
  }
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: { lessonId: string; kcId: string } }
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
    const response = await fetch(`${BACKEND_URL}/api/v1/lessons/${params.lessonId}/kcs/${params.kcId}`, {
      method: 'DELETE',
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

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error deleting lesson-KC mapping:', error);
    return NextResponse.json(
      { error: 'Failed to delete lesson-KC mapping' },
      { status: 500 }
    );
  }
}
