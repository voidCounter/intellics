import { NextRequest, NextResponse } from 'next/server';

export async function POST(request: NextRequest) {
  try {
    // Get the auth token from the request headers
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header is required' },
        { status: 401 }
      );
    }

    // Parse the interaction data from the request body
    const interactionData = await request.json();
    
    // Log what we're sending to debug the issue
    console.log('Frontend sending interaction data:', JSON.stringify(interactionData, null, 2));

    // Call the backend API to create the interaction
    const backendResponse = await fetch(`${process.env.BACKEND_URL || 'http://localhost:8080'}/api/v1/interactions/track`, {
      method: 'POST',
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(interactionData),
    });

    if (backendResponse.ok) {
      const backendData = await backendResponse.json();
      return NextResponse.json(backendData, { status: 201 });
    } else {
      const errorText = await backendResponse.text();
      console.error('Backend interaction creation failed:', errorText);
      return NextResponse.json(
        { error: 'Failed to create interaction on backend' },
        { status: backendResponse.status }
      );
    }

  } catch (error) {
    console.error('Interaction logging error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
