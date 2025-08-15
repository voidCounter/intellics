"use client"

import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Plus } from 'lucide-react'

export default function QuestionsPage() {
  return (
    <div className="container mx-auto py-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Questions</h1>
          <p className="text-muted-foreground">Manage questions and their knowledge components</p>
        </div>
        <Button>
          <Plus className="h-4 w-4 mr-2" />
          Create Question
        </Button>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Questions Overview</CardTitle>
          <CardDescription>All questions in the system</CardDescription>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">Question management will be implemented here.</p>
        </CardContent>
      </Card>
    </div>
  )
}
