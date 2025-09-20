import { NextRequest, NextResponse } from 'next/server';
import { logger } from '@/lib/utils';

const BACKEND_URL =  process.env.BACKEND_API || 'http://localhost:8080';

export async function GET(request: NextRequest) {
  try {
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header required' },
        { status: 401 }
      );
    }

    // Forward the request to the backend
    const response = await fetch(`${BACKEND_URL}/api/v1/users/me/kc-mastery`, {
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
    
    console.log('Backend response:', JSON.stringify(data, null, 2));
    
    if (Array.isArray(data)) {
      console.log('Data is an array with', data.length, 'items');
    } else {
      console.log('Data is not an array:', typeof data, data);
    }
    
    return NextResponse.json(data);
  } catch (error) {
    logger.error('Error fetching user KC mastery:', error);
    return NextResponse.json(
      { error: 'Failed to fetch user KC mastery' },
      { status: 500 }
    );
  }
}
