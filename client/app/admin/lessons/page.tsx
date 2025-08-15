"use client"

import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Plus } from 'lucide-react'

export default function LessonsPage() {
  return (
    <div className="container mx-auto py-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Lessons</h1>
          <p className="text-muted-foreground">Manage lessons and their knowledge components</p>
        </div>
        <Button>
          <Plus className="h-4 w-4 mr-2" />
          Create Lesson
        </Button>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Lessons Overview</CardTitle>
          <CardDescription>All lessons in the system</CardDescription>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">Lesson management will be implemented here.</p>
        </CardContent>
      </Card>
    </div>
  )
}
