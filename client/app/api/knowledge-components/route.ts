import { NextRequest, NextResponse } from 'next/server';

import { logger } from '@/lib/utils';
const BACKEND_URL = process.env.BACKEND_API || 'http://localhost:8080';

export async function GET(request: NextRequest) {
  try {
    // Get the auth token from the Authorization header
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header required' },
        { status: 401 }
      );
    }

    // Get query parameters
    const { searchParams } = new URL(request.url);
    const include = searchParams.get('include') === 'relationships';
    
    // Build the backend URL
    const backendUrl = new URL(`${BACKEND_URL}/api/v1/kcs`);
    
    // Add include parameter if requested
    if (include) {
      backendUrl.searchParams.set('include', 'true');
    }
    
    // Forward pagination parameters
    const page = searchParams.get('page');
    const size = searchParams.get('size');
    const sort = searchParams.get('sort');
    
    if (page) backendUrl.searchParams.set('page', page);
    if (size) backendUrl.searchParams.set('size', size);
    if (sort) backendUrl.searchParams.set('sort', sort);

    // Forward the request to the backend
    const response = await fetch(backendUrl.toString(), {
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
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
    logger.error('Error in knowledge-components API route:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

export async function PATCH(request: NextRequest) {
  try {
    // Get the auth token from the Authorization header
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header required' },
        { status: 401 }
      );
    }

    const body = await request.json();
    const { kc_id, ...patchData } = body;

    if (!kc_id) {
      return NextResponse.json(
        { error: 'Knowledge Component ID is required for updates' },
        { status: 400 }
      );
    }

    // Forward the PATCH request to the backend
    const response = await fetch(`${BACKEND_URL}/api/v1/kcs/${kc_id}`, {
      method: 'PATCH',
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(patchData),
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
    logger.error('Error updating knowledge component:', error);
    return NextResponse.json(
      { error: 'Failed to update knowledge component' },
      { status: 500 }
    );
  }
}
