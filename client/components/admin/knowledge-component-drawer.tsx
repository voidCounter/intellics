"use client"

import { useState, useEffect, useCallback } from "react"
import { useRouter } from "next/navigation"
import { Sheet, SheetContent, SheetHeader, SheetTitle, SheetTrigger } from "@/components/ui/sheet"
import { BookOpen } from "lucide-react"
import { KnowledgeComponentWithRelationships } from "@/types/api"
import { logger } from '@/lib/utils';
import { 
  BasicInformation,
  LinkedModulesWrapper,
  LinkedLessonsWrapper,
  LinkedQuestionsWrapper
} from "./knowledge-component"

interface KnowledgeComponentDrawerProps {
  kc: KnowledgeComponentWithRelationships
  trigger: React.ReactNode
  onUpdate?: (updatedKc: KnowledgeComponentWithRelationships) => void
  isOpen?: boolean
  onOpenChange?: (open: boolean) => void
}

export function KnowledgeComponentDrawer({ kc, trigger, onUpdate, isOpen: controlledIsOpen, onOpenChange }: KnowledgeComponentDrawerProps) {
  const router = useRouter()
  const [internalIsOpen, setInternalIsOpen] = useState(false)
  const [editName, setEditName] = useState(kc.kc_name)
  const [editDescription, setEditDescription] = useState(kc.description || '')
  const [isSaving, setIsSaving] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [localLessons, setLocalLessons] = useState(kc.linkedLessons || [])
  const [saveTimeout, setSaveTimeout] = useState<NodeJS.Timeout | null>(null)
  
  // Use controlled state if provided, otherwise use internal state
  const isOpen = controlledIsOpen !== undefined ? controlledIsOpen : internalIsOpen
  const setIsOpen = onOpenChange || setInternalIsOpen

  // Update local lessons and form fields when kc prop changes
  useEffect(() => {
    logger.log('Drawer received new KC data:', kc)
    setLocalLessons(kc.linkedLessons || [])
    setEditName(kc.kc_name)
    setEditDescription(kc.description || '')
  }, [kc.linkedLessons, kc.kc_name, kc.description])

  const saveChanges = useCallback(async (name: string, description: string) => {
    try {
      setIsSaving(true)
      setError(null)
      
      // Validate inputs
      if (!name.trim()) {
        setError('Knowledge Component name is required')
        return
      }

      const token = localStorage.getItem('authToken')
      if (!token) {
        setError('Authentication required')
        return
      }

      // Prepare patch data
      const patchData = {
        kc_id: kc.kc_id,
        kc_name: name.trim(),
        description: description.trim() || ''
      }

      // Call the PATCH API
      const response = await fetch('/api/knowledge-components', {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(patchData),
      })

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}))
        throw new Error(errorData.error || `HTTP error! status: ${response.status}`)
      }

      const result = await response.json()
      
      if (result.status === 'SUCCESS') {
        // Create updated KC object
        const updatedKc = {
          ...kc,
          kc_name: name.trim(),
          description: description.trim() || ''
        }
        
        // Update the local KC data
        kc.kc_name = name.trim()
        kc.description = description.trim() || ''
        
        // Notify parent component about the update
        if (onUpdate) {
          onUpdate(updatedKc)
        }
        
        // Show success message (you can add toast notification here)
        logger.log('KC updated successfully:', result.data)
      } else {
        throw new Error(result.message || 'Failed to update KC')
      }
    } catch (error) {
      logger.error('Error saving KC:', error)
      setError(error instanceof Error ? error.message : 'An error occurred while saving')
    } finally {
      setIsSaving(false)
    }
  }, [kc, onUpdate])

  // Debounced save function
  const debouncedSave = useCallback((name: string, description: string) => {
    // Clear existing timeout
    if (saveTimeout) {
      clearTimeout(saveTimeout)
    }
    
    // Set new timeout for 1 second after user stops typing
    const timeout = setTimeout(() => {
      saveChanges(name, description)
    }, 1000)
    
    setSaveTimeout(timeout)
  }, [saveChanges, saveTimeout])

  // Handle name change with auto-save
  const handleNameChange = (name: string) => {
    setEditName(name)
    debouncedSave(name, editDescription)
  }

  // Handle description change with auto-save
  const handleDescriptionChange = (description: string) => {
    setEditDescription(description)
    debouncedSave(editName, description)
  }

  // Cleanup timeout on unmount
  useEffect(() => {
    return () => {
      if (saveTimeout) {
        clearTimeout(saveTimeout)
      }
    }
  }, [saveTimeout])

  // Handle navigation to items
  const navigateToItem = (type: 'module' | 'lesson' | 'question', id: string) => {
    switch (type) {
      case 'module':
        router.push(`/admin/modules/${id}`);
        break;
      case 'lesson':
        router.push(`/admin/lessons/${id}`);
        break;
      case 'question':
        router.push(`/admin/questions/${id}`);
        break;
    }
  };

  // Reset form when drawer opens/closes
  const handleOpenChange = (open: boolean) => {
    if (open) {
      // Use current kc values (which should be fresh from the parent)
      setEditName(kc.kc_name)
      setEditDescription(kc.description || '')
      setError(null)
    }
    setIsOpen(open)
  }

  return (
    <Sheet open={isOpen} onOpenChange={handleOpenChange}>
      <SheetTrigger asChild>
        {trigger}
      </SheetTrigger>
      <SheetContent 
        side="right" 
        className="w-full sm:w-[500px] lg:w-[600px] !w-full sm:!w-[500px] lg:!w-[600px] max-w-full sm:max-w-[500px] lg:max-w-[600px]"
        style={{ width: '100vw', maxWidth: '600px' }}
      >
        <div className="h-full flex flex-col bg-white">
          {/* Header */}
          <SheetHeader className="border-b border-gray-100 bg-white px-6 py-6">
            <div className="flex items-center gap-4">
              <div className="p-3 bg-blue-50 rounded-xl">
                <BookOpen className="h-5 w-6 text-blue-600" />
              </div>
              <div className="flex-1">
                <SheetTitle className="text-2xl font-semibold text-gray-900 leading-tight">Knowledge Component</SheetTitle>
                <p className="text-gray-500 text-sm mt-1">View and edit KC details</p>
              </div>
              
              {/* Status Indicator */}
              <div className="flex items-center gap-2">
                {isSaving ? (
                  <>
                    <svg className="animate-spin h-4 w-4 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    <span className="text-blue-600 text-sm font-medium">Saving</span>
                  </>
                ) : error ? (
                  <span className="text-red-500 text-sm font-medium">Error</span>
                ) : (
                  <span className="text-green-600 text-sm font-medium">Saved</span>
                )}
              </div>
            </div>
          </SheetHeader>

          {/* Content */}
          <div className="flex-1 overflow-y-auto px-6 py-6">
            <BasicInformation
              name={editName}
              description={editDescription}
              onNameChange={handleNameChange}
              onDescriptionChange={handleDescriptionChange}
              error={error}
            />
            
            <LinkedModulesWrapper 
              modules={kc.linkedModules || []} 
              kcId={kc.kc_id} 
              onModulesChange={(modules) => {
                // Update local state if needed
                logger.log('Modules updated:', modules);
              }}
              navigateToItem={navigateToItem}
            />
            <LinkedLessonsWrapper 
              lessons={localLessons} 
              kcId={kc.kc_id} 
              onLessonsChange={setLocalLessons}
              navigateToItem={navigateToItem}
            />
            <LinkedQuestionsWrapper 
              questions={kc.linkedQuestions || []} 
              kcId={kc.kc_id} 
              navigateToItem={navigateToItem}
            />
          </div>


        </div>
      </SheetContent>
    </Sheet>
  )
}
