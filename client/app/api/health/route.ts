import { NextRequest, NextResponse } from 'next/server';

import { logger } from '@/lib/utils';
const API_BASE_URL =  process.env.BACKEND_API || 'http://localhost:8080';

export async function GET(request: NextRequest) {
    try {
        const response = await fetch(`${API_BASE_URL}/actuator/health`, {
            headers: {
                'Content-Type': 'application/json',
            },
        });

        if (!response.ok) {
            const errorData = await response.json().catch(() => ({}));
            return NextResponse.json(errorData, { status: response.status });
        }

        const data = await response.json();
        return NextResponse.json(data);
    } catch (error) {
        logger.error('Error fetching backend health info:', error);
        return NextResponse.json(
            { error: 'Failed to fetch backend health info' },
            { status: 500 }
        );
    }
}
