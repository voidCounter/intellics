"use client"

import { useState } from "react"
import { useRouter } from "next/navigation"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { Combobox } from "@/components/ui/combobox"
import { Plus, X, ExternalLink, Check, Trash2, BookOpen, GraduationCap, HelpCircle, Edit, MoveRight } from "lucide-react"
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog"
import { InteractiveProgressBar, ValueDisplay, LevelBadge, getLevelColor, getLevelLabel } from "./progress-slider"

import { logger } from '@/lib/utils';
// Generic interfaces
interface BaseLinkedItem {
  id: string
  name: string
}

interface LinkedModule extends BaseLinkedItem {
  module_id: string
  module_name: string
}

interface LinkedLesson extends BaseLinkedItem {
  lesson_id: string
  lesson_name: string
  target_mastery: number
}

interface LinkedQuestion extends BaseLinkedItem {
  question_id: string
  question_text: string
  weight: number
}

interface NewModule {
  module_id: string
  module_name: string
}

interface NewLesson {
  lesson_id: string
  lesson_name: string
  target: number
}

interface NewQuestion {
  question_id: string
  question_text: string
  weight: number
}

type LinkedItemType = 'module' | 'lesson' | 'question'

interface LinkedItemsProps<T> {
  items: T[]
  kcId: string
  type: LinkedItemType
  onItemsChange?: (items: T[]) => void
  availableItems: Array<{ id: string; name: string }>
  isLoading: boolean
  error: any
  onAdd: (item: any) => Promise<void>
  onRemove: (itemId: string) => Promise<void>
  onEdit?: (item: T, newValue: number) => Promise<void>
  getNewItem: () => any
  getItemId: (item: T) => string
  getItemName: (item: T) => string
  getExtraField?: (item: T) => { label: string; value: number; onChange: (value: number) => void }
  getExtraFieldForNew?: (newItem: any) => { label: string; value: number; fieldName: string }
  navigateToItem: (itemId: string) => void
  icon: React.ReactNode
  title: string
  description: string
}

// Utility function for truncating text safely
const truncateText = (text: string | undefined, maxLength: number): string => {
  if (!text || text.length <= maxLength) return text || '';
  return text.substring(0, maxLength) + "...";
};





export function LinkedItems<T>({
  items,
  kcId,
  type,
  onItemsChange,
  availableItems,
  isLoading,
  error,
  onAdd,
  onRemove,
  onEdit,
  getNewItem,
  getItemId,
  getItemName,
  getExtraField,
  getExtraFieldForNew,
  navigateToItem,
  icon,
  title,
  description
}: LinkedItemsProps<T>) {
  const router = useRouter()
  const [newItems, setNewItems] = useState<any[]>([])
  const [itemToDelete, setItemToDelete] = useState<string | null>(null)
  const [editingItem, setEditingItem] = useState<number | null>(null)
  const [editingItemId, setEditingItemId] = useState<string | null>(null)
  const [editingValues, setEditingValues] = useState<{ [key: string]: number }>({})

  // Filter available items and exclude already linked ones
  const filteredItems = (availableItems || [])
    .filter((item) => 
      !items.find((linked) => getItemId(linked) === item.id) &&
      !newItems.find((newItem) => 
        newItem.id === item.id && 
        newItem.id !== '' && 
        newItem.id !== item.id
      )
    )
    .slice(0, 20)

  // Helper functions
  const addNewItem = () => {
    setNewItems(prev => [...prev, getNewItem()])
  }

  const updateNewItem = (index: number, field: string, value: string | number) => {
    setNewItems(prev => prev.map((item, i) => 
      i === index ? { ...item, [field]: value } : item
    ))
  }

  const removeNewItem = (index: number) => {
    setNewItems(prev => prev.filter((_, i) => i !== index))
  }

  const saveNewItem = async (index: number) => {
    const item = newItems[index]
    if (!item.id || !item.name) return

    try {
      await onAdd(item)
      // Remove from new items after successful save
      setNewItems(prev => prev.filter((_, i) => i !== index))
    } catch (error) {
      logger.error(`Failed to add ${type}:`, error)
    }
  }

  const handleRemoveItem = async (itemId: string) => {
    try {
      await onRemove(itemId)
      setItemToDelete(null)
    } catch (error) {
      logger.error(`Failed to remove ${type}:`, error)
    }
  }

  if (error) {
    return (
      <div className="mb-12">
        <div className="text-center py-8">
          <div className="text-destructive mb-2">
            {icon}
          </div>
          <p className="text-destructive">Failed to load {type}s</p>
          <p className="text-sm text-muted-foreground mt-1">Please try refreshing the page</p>
        </div>
      </div>
    )
  }

  return (
    <div className="mb-12">
      <div className="space-y-6">
        {/* Header */}
        <div className="flex items-center gap-8">
          <div className="flex-1">
            <h3 className="text-xl font-bold text-foreground">{title}</h3>
            <p className="text-sm text-muted-foreground">{description}</p>
          </div>
          <Button
            onClick={addNewItem}
            variant="outline"
            size="icon"
            className="border-border hover:bg-accent h-8 w-8 p-0 flex-shrink-0"
          >
            <Plus className="h-4 w-4" />
          </Button>
        </div>

        {/* Loading State */}
        {isLoading && (
          <div className="text-center py-6">
            <p className="text-muted-foreground">Loading {type}s...</p>
          </div>
        )}

        {/* Existing Linked Items */}
        {items.length > 0 && (
          <div className="space-y-4">
            {items.map((item, index) => (
              <div key={index} className="p-4 border border-border rounded-lg bg-card hover:bg-accent/50 transition-colors relative">
                {/* Header Row - Title and Level Badge */}
                <div className="mb-3">
                  <h4 className="text-lg font-semibold text-foreground break-words pr-20">
                    {truncateText(getItemName(item), type === 'question' ? 80 : 50)}
                  </h4>
                </div>
                
                {/* Level Badge positioned at top-right */}
                {getExtraField && editingItem !== index && (
                  <div className="absolute top-3 right-3">
                    <LevelBadge 
                      value={getExtraField(item).value}
                      type={type === 'lesson' ? 'mastery' : 'weight'}
                      showLabel={false}
                    />
                  </div>
                )}

                {/* Content Row - Progress Bar */}
                <div className="mb-3">
                  {getExtraField && (
                    <div className="space-y-2">
                                              {editingItem === index ? (
                          <div className="space-y-2">
                            <span className="text-sm font-medium text-muted-foreground uppercase tracking-wide">
                              {getExtraField(item).label}
                            </span>
                            <InteractiveProgressBar
                              value={editingValues[getItemId(item)] ?? getExtraField(item).value}
                              onChange={(value) => {
                                setEditingValues(prev => ({
                                  ...prev,
                                  [getItemId(item)]: value
                                }))
                              }}
                              type={type === 'lesson' ? 'mastery' : 'weight'}
                            />
                            <div className="flex items-center gap-2">
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={async () => {
                                if (onEdit) {
                                  const editingValue = editingValues[getItemId(item)] ?? getExtraField(item).value
                                  setEditingItemId(getItemId(item))
                                  try {
                                    await onEdit(item, editingValue)
                                    setEditingItem(null)
                                    // Clear the editing value
                                    setEditingValues(prev => {
                                      const newValues = { ...prev }
                                      delete newValues[getItemId(item)]
                                      return newValues
                                    })
                                  } finally {
                                    setEditingItemId(null)
                                  }
                                }
                              }}
                              disabled={editingItemId === getItemId(item)}
                              className="hover:bg-accent"
                            >
                              {editingItemId === getItemId(item) ? (
                                <svg className="animate-spin h-3 w-3" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c12.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                </svg>
                              ) : (
                                <Check className="h-3 w-3" />
                              )}
                            </Button>
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={() => {
                                setEditingItem(null)
                                // Clear the editing value
                                setEditingValues(prev => {
                                  const newValues = { ...prev }
                                  delete newValues[getItemId(item)]
                                  return newValues
                                })
                              }}
                              className="hover:bg-accent"
                            >
                              <X className="h-3 w-3" />
                            </Button>
                          </div>
                        </div>
                                              ) : (
                          <div className="space-y-2">
                            <div className="flex items-center justify-between">
                                                           <span className="text-sm font-medium text-muted-foreground uppercase tracking-wide">
                               {getExtraField(item).label}
                             </span>
                              <span className="text-sm font-semibold text-foreground">
                                {Math.round(getExtraField(item).value * 100)}%
                              </span>
                            </div>
                            <div className="w-full">
                              <div className="w-full h-3 bg-gray-200 rounded-full overflow-hidden border border-gray-300">
                                <div 
                                  className={`h-full ${
                                    type === 'lesson' 
                                      ? (() => {
                                          const val = getExtraField(item).value;
                                          if (val >= 0.8) return 'bg-green-500';
                                          if (val >= 0.6) return 'bg-blue-500';
                                          if (val >= 0.4) return 'bg-yellow-500';
                                          return 'bg-red-500';
                                        })()
                                      : (() => {
                                          const val = getExtraField(item).value;
                                          if (val >= 0.8) return 'bg-indigo-500';
                                          if (val >= 0.6) return 'bg-blue-500';
                                          if (val >= 0.4) return 'bg-blue-500';
                                          return 'bg-gray-500';
                                        })()
                                  } transition-all duration-300 ease-out`}
                                  style={{ width: `${Math.round(getExtraField(item).value * 100)}%` }}
                                />
                              </div>
                            </div>
                          </div>
                        )}
                    </div>
                  )}
                </div>
                
                {/* Bottom Row - Edit, Delete, and Navigation Buttons */}
                <div className="flex items-center justify-between">
                  {/* Left Side - Edit and Delete Buttons */}
                  <div className="flex items-center gap-2">
                    {getExtraField && (
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => {
                          setEditingItem(index)
                          // Initialize the editing value with current value
                          setEditingValues(prev => ({
                            ...prev,
                            [getItemId(item)]: getExtraField(item).value
                          }))
                        }}
                        disabled={editingItemId === getItemId(item)}
                        className="hover:bg-accent h-8 w-8 p-0"
                      >
                        {editingItemId === getItemId(item) ? (
                          <svg className="animate-spin h-4 w-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                            <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c12.042 1.135 5.824 3 7.938l3-2.647z"></path>
                          </svg>
                        ) : (
                          <Edit className="h-4 w-4" />
                        )}
                      </Button>
                    )}
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={() => setItemToDelete(getItemId(item))}
                      className="hover:bg-accent text-destructive hover:text-destructive h-8 w-8 p-0"
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                  
                  {/* Right Side - Move Right Icon */}
                  <div className="flex-shrink-0">
                    <Button
                      variant="ghost"
                      size="lg"
                      onClick={() => navigateToItem(getItemId(item))}
                      className="hover:bg-accent h-12 w-12 p-0"
                    >
                      <MoveRight className="h-6 w-6" />
                    </Button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}

        {/* New Item Rows */}
        {newItems.map((newItem, index) => (
          <div key={index} className="p-6 border border-border rounded-lg bg-card">
            <div className="space-y-4">
              {/* Item Selection */}
              <div className="flex-1">
                <Combobox
                  options={(() => {
                    const currentItem = newItem.id ? availableItems.find((item) => item.id === newItem.id) : null
                    const availableOptions = filteredItems.filter((item) => item.id !== newItem.id)
                    
                    const options = currentItem ? [currentItem, ...availableOptions] : availableOptions
                    
                    return options.map((item) => ({
                      value: item.id,
                      label: truncateText(item.name, 30)
                    }))
                  })()}
                  value={newItem.id}
                  onValueChange={(itemId) => {
                    const selectedItem = availableItems.find((item) => item.id === itemId)
                    if (selectedItem) {
                      updateNewItem(index, 'id', itemId)
                      updateNewItem(index, 'name', selectedItem.name)
                    }
                  }}
                  placeholder={`Select a ${type}...`}
                />
              </div>

              {/* Extra Field (weight/target) with Interactive Slider */}
              {getExtraFieldForNew && (
                <div className="space-y-3">
                  <span className="text-sm font-medium text-muted-foreground uppercase tracking-wide">
                    {getExtraFieldForNew(newItem).label}
                  </span>
                  <InteractiveProgressBar
                    value={newItem[getExtraFieldForNew(newItem).fieldName] || 0.1}
                    onChange={(value) => {
                      const fieldName = getExtraFieldForNew(newItem).fieldName
                      updateNewItem(index, fieldName, value)
                    }}
                    type={type === 'lesson' ? 'mastery' : 'weight'}
                  />
                </div>
              )}

              {/* Action Buttons */}
              <div className="flex items-center gap-2">
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => saveNewItem(index)}
                  disabled={!newItem.id || !newItem.name}
                  className="hover:bg-accent disabled:opacity-50"
                >
                  <Check className="h-4 w-4" />
                </Button>

                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => removeNewItem(index)}
                  className="hover:bg-accent text-destructive hover:text-destructive"
                >
                  <X className="h-4 w-4" />
                </Button>
              </div>
            </div>
          </div>
        ))}

        {/* Empty State */}
        {items.length === 0 && newItems.length === 0 && !isLoading && (
          <div className="text-center py-8">
            <div className="text-muted-foreground mb-4">
              {icon}
            </div>
            <p className="text-muted-foreground">No {type}s linked yet</p>
            <p className="text-sm text-muted-foreground">Click "Add {type.charAt(0).toUpperCase() + type.slice(1)}" to get started</p>
          </div>
        )}
      </div>

      {/* Delete Confirmation Dialog */}
      <AlertDialog open={!!itemToDelete} onOpenChange={() => setItemToDelete(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Remove {type.charAt(0).toUpperCase() + type.slice(1)}</AlertDialogTitle>
            <AlertDialogDescription>
              Are you sure you want to remove this {type} from the knowledge component? This action cannot be undone.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction
              onClick={() => itemToDelete && handleRemoveItem(itemToDelete)}
              className="bg-destructive hover:bg-destructive/90"
            >
              Remove
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  )
}
