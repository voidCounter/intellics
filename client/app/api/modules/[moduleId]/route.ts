import { NextRequest, NextResponse } from 'next/server';

const API_BASE_URL = process.env.API_BASE_URL || 'http://localhost:8080/api/v1';

export async function DELETE(
  request: NextRequest,
  { params }: { params: Promise<{ moduleId: string }> }
) {
  try {
    // Get the auth token from the request headers
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return NextResponse.json(
        { error: 'Authorization header is required' },
        { status: 401 }
      );
    }

    const { moduleId } = await params;

    if (!moduleId) {
      return NextResponse.json(
        { error: 'Module ID is required for deletion' },
        { status: 400 }
      );
    }

    const response = await fetch(`${API_BASE_URL}/modules/${moduleId}`, {
      method: 'DELETE',
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      return NextResponse.json(errorData, { status: response.status });
    }

    // Handle empty response from backend (common for DELETE operations)
    if (response.status === 204 || response.status === 200) {
      return NextResponse.json(
        { status: 'SUCCESS', message: 'Module deleted successfully' },
        { status: 200 }
      );
    }

    // Try to parse response if there is content
    try {
      const data = await response.json();
      return NextResponse.json(data);
    } catch {
      // If no JSON content, return success response
      return NextResponse.json(
        { status: 'SUCCESS', message: 'Module deleted successfully' },
        { status: 200 }
      );
    }
  } catch (error) {
    console.error('Error deleting module:', error);
    return NextResponse.json(
      { error: 'Failed to delete module' },
      { status: 500 }
    );
  }
}
