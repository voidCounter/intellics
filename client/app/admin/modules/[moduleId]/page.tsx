"use client"

import { useParams } from 'next/navigation'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { ArrowLeft } from 'lucide-react'
import Link from 'next/link'

export default function ModuleDetailPage() {
  const params = useParams()
  const moduleId = params.moduleId as string

  return (
    <div className="container mx-auto py-6 space-y-6">
      <div className="flex items-center gap-4">
        <Link href="/admin/modules">
          <Button variant="outline" size="sm">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Modules
          </Button>
        </Link>
        <div>
          <h1 className="text-3xl font-bold">Module Detail</h1>
          <p className="text-muted-foreground">Viewing module: {moduleId}</p>
        </div>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Module Information</CardTitle>
          <CardDescription>Details about this module</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            <div>
              <label className="text-sm font-medium text-muted-foreground">Module ID</label>
              <p className="text-sm">{moduleId}</p>
            </div>
            <div>
              <label className="text-sm font-medium text-muted-foreground">Status</label>
              <Badge variant="secondary">Coming Soon</Badge>
            </div>
          </div>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Knowledge Components</CardTitle>
          <CardDescription>KCs linked to this module</CardDescription>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">Knowledge component management will be implemented here.</p>
        </CardContent>
      </Card>
    </div>
  )
}
