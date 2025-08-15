"use client"

import { ColumnDef } from "@tanstack/react-table"
import { useRouter } from "next/navigation"

import { Button } from "@/components/ui/button"
import { Trash2, ExternalLink, PanelRight, BookOpen, HelpCircle } from "lucide-react"
import { KnowledgeComponentWithRelationships } from "@/types/api"


// Utility function to truncate text
const truncateText = (text: string, maxLength: number = 30): string => {
  if (!text) return "No description";
  if (text.length <= maxLength) return text;
  return text.substring(0, maxLength) + "...";
};

// Utility function to format relationship counts
const formatRelationships = (items: any[], maxShow: number = 2): string => {
  if (!items || items.length === 0) return "None";
  if (items.length <= maxShow) {
    return items.map(item => item.name || item.module_name || item.lesson_name || item.question_text).join(", ");
  }
  const shown = items.slice(0, maxShow).map(item => item.name || item.module_name || item.lesson_name || item.question_text).join(", ");
  return `${shown}, +${items.length - maxShow} more`;
};

export const createColumns = (
  onUpdate?: (updatedKc: KnowledgeComponentWithRelationships) => void,
  openDrawer?: (kc: KnowledgeComponentWithRelationships) => void,
  navigateToItem?: (type: 'module' | 'lesson' | 'question', id: string) => void
): ColumnDef<KnowledgeComponentWithRelationships>[] => [
  {
    accessorKey: "kc_name",
    header: "KC Name",
    enableColumnFilter: false,
    accessorFn: (row) => `${row.kc_name} ${row.description || ''}`.toLowerCase(),
    cell: ({ row }) => {
      const kc = row.original;
      
      return (
        <div className="space-y-1 relative">
          <div className="font-medium">{kc.kc_name}</div>
          <div className="text-sm text-muted-foreground max-w-[300px]">
            {truncateText(kc.description, 50)}
          </div>
          
          {/* Row hover button - appears when hovering anywhere over the row */}
          <div className="absolute left-0 top-1/2 -translate-y-1/2 opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none">
            <div className="pointer-events-auto">
              <Button 
                size="sm" 
                variant="secondary" 
                className="border-2 border-gray-300 bg-white hover:bg-gray-50 hover:border-gray-400 text-gray-700 font-medium shadow-lg"
                onClick={() => openDrawer?.(kc)}
              >
                <PanelRight className="h-4 w-4 mr-2" />
                Open
              </Button>
            </div>
          </div>
        </div>
      );
    },
  },
  {
    accessorFn: (row) => {
      if (!row.linkedModules || row.linkedModules.length === 0) return "None";
      return row.linkedModules.map(m => m.module_name).join(", ");
    },
    id: "linkedModules",
    header: "Linked Module(s)",
    enableColumnFilter: true,
    filterFn: (row, columnId, filterValue) => {
      const modules = row.original.linkedModules;
      
      // Handle "None" filter value
      if (filterValue.includes("None")) {
        // If "None" is selected, show KCs that have no modules
        if (!modules || modules.length === 0) return true;
        return false;
      }
      
      // If no modules and we're not filtering by "None", don't show
      if (!modules || modules.length === 0) return false;
      
      // Check if ALL of the selected filter values are present in the modules
      return filterValue.every((filterVal: string) => 
        modules.some(module => module.module_name === filterVal)
      );
    },
    cell: ({ row }) => {
      const modules = row.original.linkedModules;
      if (!modules || modules.length === 0) {
        return <span className="text-muted-foreground">None</span>;
      }
      
      return (
        <div className="flex flex-wrap items-center gap-1 text-sm">
          {modules.map((module, index) => (
            <span 
              key={`${row.original.kc_id}-${module.module_id}`} 
              className="flex items-center gap-1 underline underline-offset-2 cursor-pointer hover:text-gray-600"
              onClick={() => navigateToItem?.('module', module.module_id)}
            >
              <BookOpen className="h-4 w-4 text-gray-500" />
              {module.module_name}
            </span>
          ))}
        </div>
      );
    },
  },
  {
    accessorFn: (row) => {
      if (!row.linkedLessons || row.linkedLessons.length === 0) return "None";
      return row.linkedLessons.map(l => l.lesson_name).join(", ");
    },
    id: "linkedLessons",
    header: "Linked Lesson(s)",
    enableColumnFilter: true,
    filterFn: (row, columnId, filterValue) => {
      const lessons = row.original.linkedLessons;
      
      // Handle "None" filter value
      if (filterValue.includes("None")) {
        // If "None" is selected, show KCs that have no lessons
        if (!lessons || lessons.length === 0) return true;
        return false;
      }
      
      // If no lessons and we're not filtering by "None", don't show
      if (!lessons || lessons.length === 0) return false;
      
      // Check if ALL of the selected filter values are present in the lessons
      return filterValue.every((filterVal: string) => 
        lessons.some(lesson => lesson.lesson_name === filterVal)
      );
    },
    cell: ({ row }) => {
      const lessons = row.original.linkedLessons;
      if (!lessons || lessons.length === 0) {
        return <span className="text-muted-foreground">None</span>;
      }
      
      return (
        <div className="flex flex-wrap items-center gap-1 text-sm">
          {lessons.map((lesson, index) => (
            <span 
              key={`${row.original.kc_id}-${lesson.lesson_id}`} 
              className="flex items-center gap-1 underline underline-offset-2 cursor-pointer hover:text-gray-600"
              onClick={() => navigateToItem?.('lesson', lesson.lesson_id)}
            >
              <ExternalLink className="h-4 w-4 text-gray-500" />
              {lesson.lesson_name}
            </span>
          ))}
        </div>
      );
    },
  },
  {
    accessorFn: (row) => {
      if (!row.linkedQuestions || row.linkedQuestions.length === 0) return "None";
      return row.linkedQuestions.map(q => truncateText(q.question_text, 20)).join(", ");
    },
    id: "linkedQuestions",
    header: "Linked Question(s)",
    enableColumnFilter: true,
    filterFn: (row, columnId, filterValue) => {
      const questions = row.original.linkedQuestions;
      
      // Handle "None" filter value
      if (filterValue.includes("None")) {
        // If "None" is selected, show KCs that have no questions
        if (!questions || questions.length === 0) return true;
        return false;
      }
      
      // If no questions and we're not filtering by "None", don't show
      if (!questions || questions.length === 0) return false;
      
      // Check if ALL of the selected filter values are present in the questions
      return filterValue.every((filterVal: string) => 
        questions.some(question => truncateText(question.question_text, 20) === filterVal)
      );
    },
    cell: ({ row }) => {
      const questions = row.original.linkedQuestions;
      if (!questions || questions.length === 0) {
        return <span className="text-muted-foreground">None</span>;
      }
      
      return (
        <div className="flex flex-wrap items-center gap-1 text-sm">
          {questions.map((question, index) => (
            <span 
              key={`${row.original.kc_id}-${question.question_id}`} 
              className="flex items-center gap-1 underline underline-offset-2 cursor-pointer hover:text-gray-600"
              onClick={() => navigateToItem?.('question', question.question_id)}
            >
              <HelpCircle className="h-6 w-6 text-gray-500" />
              {truncateText(question.question_text, 25)}
            </span>
          ))}
        </div>
      );
    },
  },
  {
    id: "actions",
    header: "Actions",
    cell: ({ row }) => {
      const kc = row.original;
      
      return (
        <div className="flex items-center gap-2">
          <Button
            variant="ghost"
            size="sm"
            className="h-8 w-8 p-0 text-red-600 hover:text-red-700 hover:bg-red-50"
            onClick={() => console.log("Delete KC:", kc.kc_id)}
          >
            <Trash2 className="h-4 w-4" />
          </Button>
        </div>
      );
    },
  },
];
