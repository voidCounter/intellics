"use client"

import { useParams } from 'next/navigation'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { ArrowLeft, Edit } from 'lucide-react'
import Link from 'next/link'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { ModuleLessonsTab } from './lessons-tab'
import { ModuleKCsTab } from './kcs-tab'
import { Module } from '@/types/api'
import { useQuery, useQueryClient } from '@tanstack/react-query'
import { useState } from 'react'
import { CreateModuleDialog } from '@/components/admin/create-module-dialog'

export default function ModuleDetailPage() {
  const params = useParams()
  const moduleId = params.moduleId as string
  const queryClient = useQueryClient()
  
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false)

  const { data: module, isLoading, error } = useQuery({
    queryKey: ['module', moduleId],
    queryFn: async (): Promise<Module> => {
      const token = localStorage.getItem('authToken')
      if (!token) {
        throw new Error('Authentication required')
      }

      const response = await fetch(`/api/modules/${moduleId}`, {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      })
      
      if (!response.ok) {
        if (response.status === 401) {
          throw new Error('Authentication failed')
        } else {
          throw new Error(`HTTP error! status: ${response.status}`)
        }
      }
      
      const data = await response.json()
      if (data.status === 'SUCCESS') {
        return data.data
      } else {
        throw new Error('Failed to fetch module')
      }
    },
    enabled: !!moduleId,
  })



  if (isLoading) {
    return (
      <div className="container mx-auto space-y-6">
        <Card>
          <CardHeader>
            <CardTitle>Module Information</CardTitle>
            <CardDescription>Loading module details...</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div className="h-4 bg-muted rounded animate-pulse"></div>
              <div className="h-4 bg-muted rounded w-3/4 animate-pulse"></div>
            </div>
          </CardContent>
        </Card>
      </div>
    )
  }

  if (error) {
    return (
      <div className="container mx-auto space-y-6">
        <Card>
          <CardHeader>
            <CardTitle>Module Information</CardTitle>
            <CardDescription>Error loading module</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="text-red-600">Error: {error.message}</div>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="container mx-auto space-y-6">
      <Card>
        <CardHeader>
          <div className="flex items-start justify-between gap-4">
            <div className='flex flex-col gap-2'>
              <CardTitle>{module?.module_name || 'Module Detail'}</CardTitle>
              <CardDescription>{module?.description || 'No description available'}</CardDescription>
            </div>
            <Button
              variant="outline"
              size="sm"
              onClick={() => setIsEditDialogOpen(true)}
            >
              <Edit className="h-4 w-4 mr-2" />
              Edit
            </Button>
          </div>
        </CardHeader>
        <CardContent>
          <div className='flex flex-row gap-2 items-center'>
            <label className="text-sm font-medium text-muted-foreground">MODULE ID:</label>
            <p className="text-sm border-secondary border p-1 rounded-md">{moduleId}</p>
          </div>
        </CardContent>
      </Card>

      <Tabs defaultValue="lessons" className="space-y-6">
        <TabsList className="grid w-fit grid-cols-2">
          <TabsTrigger value="lessons">Lessons</TabsTrigger>
          <TabsTrigger value="kcs">Knowledge Components</TabsTrigger>
        </TabsList>
        
        <TabsContent value="lessons" className="space-y-6">
          <ModuleLessonsTab moduleId={moduleId} />
        </TabsContent>
        
        <TabsContent value="kcs" className="space-y-6">
          <ModuleKCsTab moduleId={moduleId} />
        </TabsContent>
      </Tabs>

      {/* Edit Module Dialog */}
      {isEditDialogOpen && (
        <CreateModuleDialog
          module={module}
          mode="edit"
          open={isEditDialogOpen}
          onOpenChange={setIsEditDialogOpen}
          onClose={() => setIsEditDialogOpen(false)}
          onModuleCreated={() => {}}
          onModuleUpdated={() => {
            setIsEditDialogOpen(false)
            // Invalidate and refetch the module data
            queryClient.invalidateQueries({ queryKey: ['module', moduleId] })
          }}
        />
      )}
    </div>
  )
}
