'use client';

import React, { useMemo, useState, useEffect } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { DragDropContext, Droppable, Draggable, DropResult } from '@hello-pangea/dnd';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Search, X, Edit, Eye, Trash2, GripVertical, Plus, PlusCircleIcon, PlusSquare } from 'lucide-react';
import { toast } from 'sonner';
import Link from 'next/link';
import { ModuleLessonMapping, ModuleLessonOrderUpdate, LessonOrderItem } from '@/types/api';

interface ModuleLessonsTabProps {
  moduleId: string;
}

// Draggable lesson item component
function DraggableLessonItem({ lesson, index, onRemove }: { 
  lesson: ModuleLessonMapping; 
  index: number;
  onRemove: (lessonId: string) => void;
}) {
  return (
    <Draggable draggableId={lesson.lessonId} index={index}>
      {(provided: any, snapshot: any) => (
        <div
          ref={provided.innerRef}
          {...provided.draggableProps}
          className={`flex items-center justify-between p-4 rounded-lg border bg-card transition-all duration-200 ${
            snapshot.isDragging ? 'shadow-lg scale-105' : 'hover:shadow-sm'
          }`}
        >
          <div className="flex items-center gap-3">
            <div
              {...provided.dragHandleProps}
              className="cursor-grab active:cursor-grabbing text-muted-foreground hover:text-foreground"
            >
              <GripVertical className="h-4 w-4" />
            </div>
            
            {/* Order Badge */}
            <div className="flex items-center justify-center w-6 h-6 rounded-full bg-primary/10 text-primary text-xs font-medium">
              {lesson.orderIndex}
            </div>
            
            {/* Lesson Title */}
            <h3 className="font-medium text-foreground">{lesson.lessonName}</h3>
          </div>
          
          {/* Action Buttons */}
          <div className="flex items-center gap-2">
            <Link href={`/admin/lessons/${lesson.lessonId}`}>
              <Button
                variant="outline"
                size="sm"
                className="h-8 px-3 text-muted-foreground hover:text-foreground"
              >
                View
              </Button>
            </Link>
            <Button
              variant="ghost"
              size="sm"
              onClick={() => onRemove(lesson.lessonId)}
              className="h-8 px-3 text-red-600 hover:text-red-700 hover:bg-red-50"
            >
              <Trash2 className="h-4 w-4 mr-2" />
              Delete
            </Button>
          </div>
        </div>
      )}
    </Draggable>
  );
}

export function ModuleLessonsTab({ moduleId }: ModuleLessonsTabProps) {
  const [searchQuery, setSearchQuery] = useState('');
  const [items, setItems] = useState<ModuleLessonMapping[]>([]);
  const [hasManualReordering, setHasManualReordering] = useState(false);
  const queryClient = useQueryClient();

  const { data: lessons = [], isLoading, error } = useQuery({
    queryKey: ['module-lessons', moduleId],
    queryFn: async (): Promise<ModuleLessonMapping[]> => {
      const token = localStorage.getItem('authToken')
      if (!token) {
        throw new Error('Authentication required')
      }

      const response = await fetch(`/api/modules/${moduleId}/lessons`, {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      })

      if (response.ok) {
        const data = await response.json()
        return data.data
      } else {
        throw new Error('Failed to fetch lessons')
      }
    },
    enabled: !!moduleId,
  });

  // Update local items when lessons data changes
  useEffect(() => {
    if (lessons.length > 0 && items.length === 0 && !hasManualReordering) {
      // Only set items if we don't have any yet (initial load)
      // AND if user hasn't manually reordered anything
      const sortedLessons = [...lessons].sort((a, b) => a.orderIndex - b.orderIndex);
      console.log('Setting initial sorted lessons:', sortedLessons);
      setItems(sortedLessons);
    }
  }, [lessons, items.length, hasManualReordering]);

  const removeLessonMutation = useMutation({
    mutationFn: async (lessonId: string) => {
      const token = localStorage.getItem('authToken')
      if (!token) {
        throw new Error('Authentication required')
      }

      const response = await fetch(`/api/modules/${moduleId}/lessons/${lessonId}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      })

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}))
        throw new Error(errorData.message || 'Failed to remove lesson from module')
      }

      return response
    },
    onSuccess: () => {
      // Invalidate and refetch the lessons query
      queryClient.invalidateQueries({ queryKey: ['module-lessons', moduleId] })
      toast.success('Lesson removed from module successfully')
    },
    onError: (error: Error) => {
      console.error('Error removing lesson from module:', error)
      toast.error(error.message || 'Failed to remove lesson from module')
    },
  });

  const updateLessonOrderMutation = useMutation({
    mutationFn: async (orderUpdate: ModuleLessonOrderUpdate) => {
      console.log('Sending order update to backend:', orderUpdate);
      const token = localStorage.getItem('authToken')
      if (!token) {
        throw new Error('Authentication required')
      }

      const response = await fetch(`/api/modules/${moduleId}/lessons`, {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(orderUpdate),
      })

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}))
        throw new Error(errorData.message || 'Failed to update lesson orders')
      }

      return response
    },
    onSuccess: () => {
      console.log('Order update successful - keeping UI smooth');
      // DON'T invalidate cache - keep the optimistic update
      toast.success('Lesson order updated successfully')
    },
    onError: (error: Error) => {
      console.error('Error updating lesson orders:', error)
      toast.error(error.message || 'Failed to update lesson orders')
      // Revert to original order on error by refetching
      queryClient.invalidateQueries({ queryKey: ['module-lessons', moduleId] })
    },
  });

  // Client-side search - filters lessons locally
  const filteredItems = useMemo(() => {
    if (!searchQuery.trim()) return items;
    
    const query = searchQuery.toLowerCase().trim();
    return items.filter(lesson => 
      lesson.lessonName.toLowerCase().includes(query)
    );
  }, [items, searchQuery]);

  const handleRemoveLesson = (lessonId: string) => {
    removeLessonMutation.mutate(lessonId);
  };

  const handleDragStart = (result: any) => {
    console.log('Drag started:', result);
  };

  const handleDragEnd = (result: DropResult) => {
    console.log('Drag ended:', result);
    console.log('Current items before reorder:', items);
    
    if (!result.destination) {
      console.log('No destination, no change');
      return;
    }

    if (result.destination.index === result.source.index) {
      console.log('Same position, no change');
      return;
    }

    // Reorder the items
    const newItems = Array.from(items);
    const [reorderedItem] = newItems.splice(result.source.index, 1);
    newItems.splice(result.destination.index, 0, reorderedItem);

    // Update orderIndex values to match new positions
    newItems.forEach((item, index) => {
      item.orderIndex = index + 1;
    });

    console.log('New items after reorder:', newItems);
    
    // Mark that user has manually reordered
    setHasManualReordering(true);
    
    // Update local state immediately for smooth UI
    setItems(newItems);

    // Create the order update payload
    const lessonOrders: LessonOrderItem[] = newItems.map((lesson, index) => ({
      lessonId: lesson.lessonId,
      orderIndex: index + 1, // Start from 1
    }));

    const orderUpdate: ModuleLessonOrderUpdate = {
      lessonOrders,
    };

    console.log('Sending order update:', orderUpdate);

    // Update the order on the backend WITHOUT invalidating cache
    updateLessonOrderMutation.mutate(orderUpdate);
  };

  const clearSearch = () => {
    setSearchQuery('');
  };

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-2xl font-bold">Module Lessons</h2>
            <p className="text-muted-foreground">
              Manage lessons assigned to this module.
            </p>
          </div>
          <Button disabled>
            <PlusSquare className="h-4 w-4 mr-2" />
            Add Lesson
          </Button>
        </div>
        
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="rounded-lg border bg-card p-6 animate-pulse">
              <div className="h-6 bg-muted rounded mb-4"></div>
              <div className="h-4 bg-muted rounded mb-2"></div>
              <div className="h-4 bg-muted rounded w-3/4"></div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-2xl font-bold">Module Lessons</h2>
            <p className="text-muted-foreground">
              Manage lessons assigned to this module.
            </p>
          </div>
          <Button disabled>
            <Plus className="h-4 w-4 mr-2" />
            Add Lesson
          </Button>
        </div>
        <div className="flex items-center justify-center py-12">
          <div className="text-red-600">Error: {error.message}</div>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold">Module Lessons</h2>
        <p className="text-muted-foreground">
          Manage lessons assigned to this module. Drag and drop to reorder.
        </p>
      </div>
      
      <div className="flex items-center justify-start gap-4">
        <div className="relative flex-1 max-w-md">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="Search lessons..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-10 pr-10"
          />
          {searchQuery && (
            <Button
              variant="ghost"
              size="sm"
              onClick={clearSearch}
              className="absolute right-1 top-1/2 transform -translate-y-1/2 h-6 w-6 p-0 hover:bg-muted"
            >
              <X className="h-3 w-3" />
            </Button>
          )}
        </div>
        
        <Button>
          <PlusSquare className="h-4 w-4 mr-2" />
          Add Lesson
        </Button>
      </div>

      {/* Search Results Summary */}
      {searchQuery.trim() && (
        <div className="text-sm text-muted-foreground">
          {filteredItems.length} result{filteredItems.length !== 1 ? 's' : ''} for "{searchQuery}"
        </div>
      )}

      {filteredItems.length === 0 ? (
        <div className="text-center py-12">
          {searchQuery.trim() ? (
            <div className="space-y-2">
              <p className="text-muted-foreground">No lessons found matching "{searchQuery}".</p>
              <Button variant="outline" onClick={clearSearch}>
                Clear search
              </Button>
            </div>
          ) : (
            <p className="text-muted-foreground">No lessons assigned to this module. Add your first lesson to get started.</p>
          )}
        </div>
      ) : (
        <DragDropContext onDragStart={handleDragStart} onDragEnd={handleDragEnd}>
          <Droppable droppableId="lessons">
            {(provided: any) => (
              <div
                {...provided.droppableProps}
                ref={provided.innerRef}
                className="space-y-3 max-w-2xl"
              >
                {filteredItems.map((lesson, index) => (
                  <DraggableLessonItem
                    key={lesson.lessonId}
                    lesson={lesson}
                    index={index}
                    onRemove={handleRemoveLesson}
                  />
                ))}
                {provided.placeholder}
              </div>
            )}
          </Droppable>
        </DragDropContext>
      )}
    </div>
  );
}
