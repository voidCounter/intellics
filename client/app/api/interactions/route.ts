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

    // For now, just log the interaction since backend doesn't support creation yet
    console.log('Interaction received:', interactionData);

    // Return a simple success response
    return NextResponse.json({
      status: 'SUCCESS',
      message: 'Interaction logged successfully',
      data: {
        interaction_id: `local_${Date.now()}`,
        timestamp: new Date().toISOString(),
        ...interactionData
      }
    }, { status: 201 });

  } catch (error) {
    console.error('Interaction logging error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
