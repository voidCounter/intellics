import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  try {
    const backendUrl = process.env.BACKEND_API_URL || 'http://localhost:8080';
    const oauthUrl = `${backendUrl}/oauth2/authorization/google`;
    
    // Redirect to the backend OAuth endpoint
    return NextResponse.redirect(oauthUrl);
  } catch (error) {
    console.error('Error redirecting to OAuth:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
