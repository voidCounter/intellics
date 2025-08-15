"use client"

import { useRouter } from "next/navigation"
import { BookOpen } from "lucide-react"
import { ModuleTitle } from "@/types/api"
import { useAllModules } from "@/hooks/useModules"
import { useAddKCToModule, useRemoveKCFromModule } from "@/hooks/useKnowledgeComponent"
import { LinkedItems } from "./linked-items"

interface LinkedModule {
  module_id: string
  module_name: string
}

interface LinkedModulesWrapperProps {
  modules: LinkedModule[]
  kcId: string
  onModulesChange?: (modules: LinkedModule[]) => void
  navigateToItem?: (type: 'module' | 'lesson' | 'question', id: string) => void
}

export function LinkedModulesWrapper({ modules, kcId, onModulesChange, navigateToItem }: LinkedModulesWrapperProps) {
  const router = useRouter()
  const { data: availableModules = [], isLoading, error } = useAllModules()
  const addKCToModuleMutation = useAddKCToModule()
  const removeKCFromModuleMutation = useRemoveKCFromModule()

  const navigateToModule = (moduleId: string) => {
    if (navigateToItem) {
      navigateToItem('module', moduleId)
    } else {
      router.push(`/admin/modules/${moduleId}`)
    }
  }

  const handleAddModule = async (newModule: any) => {
    const moduleData = {
      moduleId: newModule.id,
      kcId: kcId,
    }

    await addKCToModuleMutation.mutateAsync(moduleData)
    
    // Create the new module object for optimistic update
    const newLinkedModule: LinkedModule = {
      module_id: newModule.id,
      module_name: newModule.name,
    }

    // Optimistically add the module to the UI immediately
    const updatedModules = [...modules, newLinkedModule]
    if (onModulesChange) {
      onModulesChange(updatedModules)
    }
  }

  const handleRemoveModule = async (moduleId: string) => {
    const moduleData = {
      moduleId: moduleId,
      kcId: kcId,
    }

    await removeKCFromModuleMutation.mutateAsync(moduleData)
    
    // Optimistically remove the module from the UI immediately
    const updatedModules = modules.filter(module => module.module_id !== moduleId)
    if (onModulesChange) {
      onModulesChange(updatedModules)
    }
  }

  const getNewModule = () => ({ id: '', name: '' })

  const getModuleId = (module: LinkedModule) => module.module_id
  const getModuleName = (module: LinkedModule) => module.module_name

  // Transform available modules to match the generic interface
  const transformedAvailableModules = availableModules.map((module: ModuleTitle) => ({
    id: module.module_id,
    name: module.module_name
  }))

  return (
    <LinkedItems
      items={modules}
      kcId={kcId}
      type="module"
      onItemsChange={onModulesChange}
      availableItems={transformedAvailableModules}
      isLoading={isLoading}
      error={error}
      onAdd={handleAddModule}
      onRemove={handleRemoveModule}
      getNewItem={getNewModule}
      getItemId={getModuleId}
      getItemName={getModuleName}
      navigateToItem={navigateToModule}
      icon={<BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />}
      title="Linked Modules"
      description="Connect this knowledge component to specific modules"
    />
  )
}
