import { NextRequest, NextResponse } from 'next/server';

import { logger } from '@/lib/utils';
const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:8080';

export async function POST(
  request: NextRequest,
  { params }: { params: { questionId: string } }
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
    const { kc_id, weight } = body;

    if (!kc_id || weight === undefined) {
      return NextResponse.json(
        { error: 'KC ID and weight are required' },
        { status: 400 }
      );
    }

    // Forward the request to the backend
    const response = await fetch(`${BACKEND_URL}/api/v1/questions/${params.questionId}/kcs`, {
      method: 'POST',
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        kc_id: kc_id,
        weight: weight
      }),
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
    logger.error('Error creating question-KC mapping:', error);
    return NextResponse.json(
      { error: 'Failed to create question-KC mapping' },
      { status: 500 }
    );
  }
}
