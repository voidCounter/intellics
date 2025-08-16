import { NextRequest, NextResponse } from 'next/server'

const BACKEND_URL = process.env.NEXT_PUBLIC_BACKEND_URL || 'http://localhost:8080'

export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ lessonId: string }> }
) {
  try {
    const { lessonId } = await params
    const token = request.headers.get('authorization')

    if (!token) {
      return NextResponse.json(
        { message: 'Authorization header required' },
        { status: 401 }
      )
    }

    const response = await fetch(`${BACKEND_URL}/api/v1/lessons/${lessonId}`, {
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    })

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}))
      return NextResponse.json(
        { message: errorData.message || 'Failed to fetch lesson' },
        { status: response.status }
      )
    }

    const data = await response.json()
    return NextResponse.json(data)
  } catch (error) {
    console.error('Error fetching lesson:', error)
    return NextResponse.json(
      { message: 'Internal server error' },
      { status: 500 }
    )
  }
}

export async function PUT(
  request: NextRequest,
  { params }: { params: Promise<{ lessonId: string }> }
) {
  try {
    const { lessonId } = await params
    const token = request.headers.get('authorization')
    const body = await request.json()

    if (!token) {
      return NextResponse.json(
        { message: 'Authorization header required' },
        { status: 401 }
      )
    }

    const response = await fetch(`${BACKEND_URL}/api/v1/lessons/${lessonId}`, {
      method: 'PUT',
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    })

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}))
      return NextResponse.json(
        { message: errorData.message || 'Failed to update lesson' },
        { status: response.status }
      )
    }

    const data = await response.json()
    return NextResponse.json(data)
  } catch (error) {
    console.error('Error updating lesson:', error)
    return NextResponse.json(
      { message: 'Internal server error' },
      { status: 500 }
    )
  }
}
