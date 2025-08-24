import { NextRequest, NextResponse } from 'next/server';

import { logger } from '@/lib/utils';
export async function GET(request: NextRequest) {
  try {
    const backendUrl = process.env.BACKEND_API_URL || 'http://localhost:8080';
    const oauthUrl = `${backendUrl}/oauth2/authorization/google`;
    
    // Redirect to the backend OAuth endpoint
    return NextResponse.redirect(oauthUrl);
  } catch (error) {
    logger.error('Error redirecting to OAuth:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
