"use client"

import { useRouter } from "next/navigation"
import { GraduationCap } from "lucide-react"
import { LessonTitle } from "@/types/api"
import { useLessonTitles } from "@/hooks/useLessons"
import { useAddKCToLesson, useRemoveKCFromLesson, useUpdateKCTargetMastery } from "@/hooks/useKnowledgeComponent"
import { LinkedItems } from "./linked-items"

import { logger } from '@/lib/utils';
interface LinkedLesson {
  lesson_id: string
  lesson_name: string
  target_mastery: number
}

interface LinkedLessonsWrapperProps {
  lessons: LinkedLesson[]
  kcId: string
  onLessonsChange?: (lessons: LinkedLesson[]) => void
  navigateToItem?: (type: 'module' | 'lesson' | 'question', id: string) => void
}

export function LinkedLessonsWrapper({ lessons, kcId, onLessonsChange, navigateToItem }: LinkedLessonsWrapperProps) {
  const router = useRouter()
  const { data: availableLessons = [], isLoading, error } = useLessonTitles()
  const addKCToLessonMutation = useAddKCToLesson()
  const removeKCFromLessonMutation = useRemoveKCFromLesson()
  const updateKCTargetMasteryMutation = useUpdateKCTargetMastery()

  const navigateToLesson = (lessonId: string) => {
    if (navigateToItem) {
      navigateToItem('lesson', lessonId)
    } else {
      router.push(`/admin/lessons/${lessonId}`)
    }
  }

  const handleAddLesson = async (newLesson: any) => {
    const lessonData = {
      lessonId: newLesson.id,
      kcId: kcId,
      targetMastery: newLesson.target || 0.1
    }

    await addKCToLessonMutation.mutateAsync(lessonData)
    
    // Create the new lesson object for optimistic update
    const newLinkedLesson: LinkedLesson = {
      lesson_id: newLesson.id,
      lesson_name: newLesson.name,
      target_mastery: newLesson.target || 0.1
    }

    // Optimistically add the lesson to the UI immediately
    const updatedLessons = [...lessons, newLinkedLesson]
    if (onLessonsChange) {
      onLessonsChange(updatedLessons)
    }
  }

  const handleRemoveLesson = async (lessonId: string) => {
    const lessonData = {
      lessonId: lessonId,
      kcId: kcId,
    }

    await removeKCFromLessonMutation.mutateAsync(lessonData)
    
    // Optimistically remove the lesson from the UI immediately
    const updatedLessons = lessons.filter(lesson => lesson.lesson_id !== lessonId)
    if (onLessonsChange) {
      onLessonsChange(updatedLessons)
    }
  }

  const handleEditLesson = async (lesson: LinkedLesson, newTargetMastery: number) => {
    try {
      await updateKCTargetMasteryMutation.mutateAsync({
        lessonId: lesson.lesson_id,
        kcId: kcId,
        targetMastery: newTargetMastery
      })

      // Update local state
      const updatedLessons = lessons.map(l => 
        l.lesson_id === lesson.lesson_id 
          ? { ...l, target_mastery: newTargetMastery }
          : l
      )
      
      if (onLessonsChange) {
        onLessonsChange(updatedLessons)
      }
    } catch (error) {
      logger.error('Error updating target mastery:', error)
      // Revert the local change on error
      lesson.target_mastery = lesson.target_mastery
    }
  }

  const getNewLesson = () => ({ id: '', name: '', target: 0.1 })

  const getLessonId = (lesson: LinkedLesson) => lesson.lesson_id
  const getLessonName = (lesson: LinkedLesson) => lesson.lesson_name

  const getExtraField = (lesson: LinkedLesson) => ({
    label: 'Target Mastery',
    value: lesson.target_mastery,
    onChange: (value: number) => {
      // Update the local state for editing
      lesson.target_mastery = value
    }
  })

  const getExtraFieldForNew = (newLesson: any) => ({
    label: 'Target',
    value: newLesson.target || 0.1,
    fieldName: 'target'
  })

  // Transform available lessons to match the generic interface
  const transformedAvailableLessons = availableLessons.map((lesson: LessonTitle) => ({
    id: lesson.lesson_id,
    name: lesson.lesson_name
  }))

  return (
    <LinkedItems
      items={lessons}
      kcId={kcId}
      type="lesson"
      onItemsChange={onLessonsChange}
      availableItems={transformedAvailableLessons}
      isLoading={isLoading}
      error={error}
      onAdd={handleAddLesson}
      onRemove={handleRemoveLesson}
      onEdit={handleEditLesson}
      getNewItem={getNewLesson}
      getItemId={getLessonId}
      getItemName={getLessonName}
      getExtraField={getExtraField}
      getExtraFieldForNew={getExtraFieldForNew}
      navigateToItem={navigateToLesson}
      icon={<GraduationCap className="h-12 w-12 text-muted-foreground mx-auto mb-4" />}
      title="Linked Lessons"
      description="Connect this knowledge component to specific lessons with target mastery levels"
    />
  )
}
