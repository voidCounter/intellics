"use client"

import { useRouter } from "next/navigation"
import { HelpCircle } from "lucide-react"
import { QuestionTitle } from "@/types/api"
import { useAllQuestions } from "@/hooks/useQuestions"
import { useAddKCToQuestion, useRemoveKCFromQuestion, useUpdateKCWeight } from "@/hooks/useKnowledgeComponent"
import { LinkedItems } from "./linked-items"

import { logger } from '@/lib/utils';
interface LinkedQuestion {
  question_id: string
  question_text: string
  weight: number
}

interface LinkedQuestionsWrapperProps {
  questions: LinkedQuestion[]
  kcId: string
  onQuestionsChange?: (questions: LinkedQuestion[]) => void
  navigateToItem?: (type: 'module' | 'lesson' | 'question', id: string) => void
}

export function LinkedQuestionsWrapper({ questions, kcId, onQuestionsChange, navigateToItem }: LinkedQuestionsWrapperProps) {
  const router = useRouter()
  const { data: availableQuestions = [], isLoading, error } = useAllQuestions()
  const addKCToQuestionMutation = useAddKCToQuestion()
  const removeKCFromQuestionMutation = useRemoveKCFromQuestion()
  const updateKCWeightMutation = useUpdateKCWeight()

  const navigateToQuestion = (questionId: string) => {
    if (navigateToItem) {
      navigateToItem('question', questionId)
    } else {
      router.push(`/admin/questions/${questionId}`)
    }
  }

  const handleAddQuestion = async (newQuestion: any) => {
    const questionData = {
      questionId: newQuestion.id,
      kcId: kcId,
      weight: newQuestion.weight || 0.1
    }

    await addKCToQuestionMutation.mutateAsync(questionData)
    
    // Create the new question object for optimistic update
    const newLinkedQuestion: LinkedQuestion = {
      question_id: newQuestion.id,
      question_text: newQuestion.name,
      weight: newQuestion.weight || 0.1
    }

    // Optimistically add the question to the UI immediately
    const updatedQuestions = [...questions, newLinkedQuestion]
    if (onQuestionsChange) {
      onQuestionsChange(updatedQuestions)
    }
  }

  const handleRemoveQuestion = async (questionId: string) => {
    const questionData = {
      questionId: questionId,
      kcId: kcId,
    }

    await removeKCFromQuestionMutation.mutateAsync(questionData)
    
    // Optimistically remove the question from the UI immediately
    const updatedQuestions = questions.filter(question => question.question_id !== questionId)
    if (onQuestionsChange) {
      onQuestionsChange(updatedQuestions)
    }
  }

  const handleEditQuestion = async (question: LinkedQuestion, newWeight: number) => {
    try {
      await updateKCWeightMutation.mutateAsync({
        questionId: question.question_id,
        kcId: kcId,
        weight: newWeight
      })

      // Update local state
      const updatedQuestions = questions.map(q => 
        q.question_id === question.question_id 
          ? { ...q, weight: newWeight }
          : q
      )
      
      if (onQuestionsChange) {
        onQuestionsChange(updatedQuestions)
      }
    } catch (error) {
      logger.error('Error updating weight:', error)
      // Revert the local change on error
      question.weight = question.weight
    }
  }

  const getNewQuestion = () => ({ id: '', name: '', weight: 0.1 })

  const getQuestionId = (question: LinkedQuestion) => question.question_id
  const getQuestionName = (question: LinkedQuestion) => question.question_text

  const getExtraField = (question: LinkedQuestion) => ({
    label: 'Weight',
    value: question.weight,
    onChange: (value: number) => {
      // Update the local state for editing
      question.weight = value
    }
  })

  const getExtraFieldForNew = (newQuestion: any) => ({
    label: 'Weight',
    value: newQuestion.weight || 0.1,
    fieldName: 'weight'
  })

  // Transform available questions to match the generic interface
  const transformedAvailableQuestions = availableQuestions.map((question: QuestionTitle) => ({
    id: question.question_id,
    name: question.question_text
  }))

  return (
    <LinkedItems
      items={questions}
      kcId={kcId}
      type="question"
      onItemsChange={onQuestionsChange}
      availableItems={transformedAvailableQuestions}
      isLoading={isLoading}
      error={error}
      onAdd={handleAddQuestion}
      onRemove={handleRemoveQuestion}
      onEdit={handleEditQuestion}
      getNewItem={getNewQuestion}
      getItemId={getQuestionId}
      getItemName={getQuestionName}
      getExtraField={getExtraField}
      getExtraFieldForNew={getExtraFieldForNew}
      navigateToItem={navigateToQuestion}
      icon={<HelpCircle className="h-12 w-12 text-muted-foreground mx-auto mb-4" />}
      title="Linked Questions"
      description="Connect this knowledge component to specific questions with weight values"
    />
  )
}
