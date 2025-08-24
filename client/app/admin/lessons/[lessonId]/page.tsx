"use client";

import { useParams } from "next/navigation";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Save, Eye, Edit, Plus, Trash2, ExternalLink, Check, ChevronsUpDown } from "lucide-react";
import Link from "next/link";
import { useState } from "react";
import MarkdownEditor from "@/components/admin/markdown-editor";
import { InteractiveProgressBar } from "@/components/admin/knowledge-component/progress-slider";
import { toast } from "sonner";
import { useAddKCToLesson, useRemoveKCFromLesson, useUpdateKCTargetMastery, useKnowledgeComponents } from "@/hooks/useKnowledgeComponent";
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "@/components/ui/command";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { cn } from "@/lib/utils";
import { MarkdownContent } from '@/components/ui/markdown-content';

import { logger } from '@/lib/utils';
interface LessonData {
  lesson_id: string;
  lesson_name: string;
  lesson_content: string;
}

export default function LessonDetailPage() {
  const params = useParams();
  const lessonId = params.lessonId as string;
  const queryClient = useQueryClient();

  const [isEditing, setIsEditing] = useState(false);
  const [isEditingTitle, setIsEditingTitle] = useState(false);
  const [editedContent, setEditedContent] = useState("");
  const [editedTitle, setEditedTitle] = useState("");
  const [isAddingKC, setIsAddingKC] = useState(false);

  // Fetch lesson data
  const {
    data: lesson,
    isLoading,
    error,
  } = useQuery({
    queryKey: ["lesson", lessonId],
    queryFn: async (): Promise<LessonData> => {
      const token = localStorage.getItem("authToken");
      if (!token) {
        throw new Error("Authentication required");
      }

      const response = await fetch(`/api/lessons/${lessonId}`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      });

      if (response.ok) {
        const data = await response.json();
        return data.data;
      } else {
        throw new Error("Failed to fetch lesson");
      }
    },
    enabled: !!lessonId,
  });

  // Update lesson title mutation
  const updateLessonTitleMutation = useMutation({
    mutationFn: async (title: string) => {
      const token = localStorage.getItem("authToken");
      if (!token) {
        throw new Error("Authentication required");
      }

      const response = await fetch(`/api/lessons/${lessonId}`, {
        method: "PUT",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          lesson_id: lessonId,
          lesson_name: title,
          lesson_content: lesson?.lesson_content || "",
        }),
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.message || "Failed to update lesson title");
      }

      return response;
    },
    onSuccess: () => {
      toast.success("Lesson title updated successfully");
      setIsEditingTitle(false);
      queryClient.invalidateQueries({ queryKey: ["lesson", lessonId] });
    },
    onError: (error: Error) => {
      toast.error(error.message || "Failed to update lesson title");
    },
  });

  // Update lesson content mutation
  const updateLessonMutation = useMutation({
    mutationFn: async (content: string) => {
      const token = localStorage.getItem("authToken");
      if (!token) {
        throw new Error("Authentication required");
      }

      const response = await fetch(`/api/lessons/${lessonId}`, {
        method: "PUT",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          lesson_id: lessonId,
          lesson_name: lesson?.lesson_name || "",
          lesson_content: content,
        }),
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.message || "Failed to update lesson");
      }

      return response;
    },
    onSuccess: () => {
      toast.success("Lesson updated successfully");
      setIsEditing(false);
      queryClient.invalidateQueries({ queryKey: ["lesson", lessonId] });
    },
    onError: (error: Error) => {
      toast.error(error.message || "Failed to update lesson");
    },
  });

  // Handle edit mode toggle
  const handleEditToggle = () => {
    if (isEditing) {
      setIsEditing(false);
      setEditedContent("");
    } else {
      setIsEditing(true);
      // For now, just pass the markdown content directly
      // The editor will handle it as plain text initially
      setEditedContent(lesson?.lesson_content || "");
    }
  };

  // Handle save
  const handleSave = () => {
    if (editedContent.trim()) {
      updateLessonMutation.mutate(editedContent);
    }
  };

  if (isLoading) {
    return (
      <div className="container mx-auto space-y-6">
        <Card>
          <CardHeader>
            <CardTitle>Lesson Information</CardTitle>
            <CardDescription>Loading lesson details...</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div className="h-4 bg-muted rounded animate-pulse"></div>
              <div className="h-4 bg-muted rounded w-3/4 animate-pulse"></div>
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container mx-auto space-y-6">
        <Card>
          <CardHeader>
            <CardTitle>Lesson Information</CardTitle>
            <CardDescription>Error loading lesson</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="text-red-600">Error: {error.message}</div>
          </CardContent>
        </Card>
      </div>
    );
  }

  if (!lesson) {
    return (
      <div className="container mx-auto py-6 space-y-6">
        <div className="flex items-center gap-4">
          <Link href="/admin/lessons">
            <Button variant="outline" size="sm">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Back to Lessons
            </Button>
          </Link>
          <div>
            <h1 className="text-3xl font-bold">Lesson Not Found</h1>
            <p className="text-muted-foreground">
              The requested lesson could not be found
            </p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto max-w-4xl space-y-6">
      {/* Lesson Information Card */}
      <Card>
        <CardHeader>
          <div className="flex flex-col gap-2">
            {isEditingTitle ? (
              <div className="space-y-2">
                <input
                  type="text"
                  value={editedTitle}
                  onChange={(e) => setEditedTitle(e.target.value)}
                  className="text-3xl font-bold bg-transparent border-b-2 border-blue-500 focus:outline-none focus:border-blue-600"
                  placeholder="Enter lesson title..."
                />
                <div className="flex items-center gap-2">
                  <Button
                    size="sm"
                    onClick={() => {
                      if (editedTitle.trim()) {
                        updateLessonTitleMutation.mutate(editedTitle);
                      }
                    }}
                    disabled={updateLessonTitleMutation.isPending}
                  >
                    {updateLessonTitleMutation.isPending
                      ? "Saving..."
                      : "Save Title"}
                  </Button>
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => {
                      setIsEditingTitle(false);
                      setEditedTitle(lesson.lesson_name);
                    }}
                  >
                    Cancel
                  </Button>
                </div>
              </div>
            ) : (
              <div className="flex items-center gap-8">
                <h1 className="text-3xl font-bold">{lesson.lesson_name}</h1>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => {
                    setIsEditingTitle(true);
                    setEditedTitle(lesson.lesson_name);
                  }}
                  className="h-8 w-8 p-0"
                >
                  <Edit className="h-4 w-4" />
                </Button>
              </div>
            )}
            <div className="flex flex-row gap-2 items-center">
              <label className="text-sm font-medium text-muted-foreground">
                LESSON ID:
              </label>
              <p className="text-sm border-secondary border p-1 rounded-md">
                {lessonId}
              </p>
            </div>
          </div>
        </CardHeader>
      </Card>

      {/* Knowledge Components */}
      <Card>
        <CardHeader>
          <div>
            <CardTitle>Knowledge Components</CardTitle>
            <CardDescription>
              Manage knowledge components and their target mastery levels for this lesson
            </CardDescription>
          </div>
        </CardHeader>
        <CardContent>
          <LessonKCMappingsSection 
            lessonId={lessonId}
            queryClient={queryClient}
            onKCsChange={() => {
              // Refetch lesson with KCs
              queryClient.invalidateQueries({ queryKey: ["lesson", lessonId, "with-kcs"] });
            }}
          />
        </CardContent>
      </Card>

      {/* Lesson Content */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>Lesson Content</CardTitle>
              <CardDescription>
                Edit or view the lesson content below
              </CardDescription>
            </div>
            <div className="flex items-center gap-2">
              <Button
                variant={isEditing ? "outline" : "default"}
                onClick={handleEditToggle}
                disabled={updateLessonMutation.isPending}
              >
                {isEditing ? (
                  <>
                    <Eye className="h-4 w-4 mr-2" />
                    View
                  </>
                ) : (
                  <>
                    <Edit className="h-4 w-4 mr-2" />
                    Edit
                  </>
                )}
              </Button>

              {isEditing && (
                <Button
                  onClick={handleSave}
                  disabled={updateLessonMutation.isPending}
                >
                  <Save className="h-4 w-4 mr-2" />
                  {updateLessonMutation.isPending ? "Saving..." : "Save"}
                </Button>
              )}
            </div>
          </div>
        </CardHeader>
        <CardContent>
          {isEditing ? (
            <MarkdownEditor
              value={editedContent}
              onChange={setEditedContent}
              placeholder="Write your lesson content..."
            />
          ) : (
            <div className="max-w-3xl mx-auto">
              <MarkdownContent 
                content={lesson.lesson_content}
                variant="admin"
              />
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}

// Knowledge Component Mappings Section
function LessonKCMappingsSection({ lessonId, queryClient, onKCsChange }: { lessonId: string; queryClient: any; onKCsChange: () => void }) {
  const [isAddingKC, setIsAddingKC] = useState(false);
  const [selectedKCId, setSelectedKCId] = useState("");
  const [targetMastery, setTargetMastery] = useState(0.5);
  const [open, setOpen] = useState(false);
  const [searchValue, setSearchValue] = useState("");
  const [updatingKCs, setUpdatingKCs] = useState<Set<string>>(new Set());

  const { data: lessonWithKCs, isLoading: isLoadingLesson } = useQuery({
    queryKey: ["lesson", lessonId, "with-kcs"],
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(`/api/lessons/${lessonId}/with-kcs`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error("Failed to fetch lesson with KCs");
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!lessonId,
  });

  const { data: availableKCs, isLoading: isLoadingKCs } = useKnowledgeComponents();
  
  const addKCMutation = useAddKCToLesson();
  const removeKCMutation = useRemoveKCFromLesson();
  const updateTargetMasteryMutation = useUpdateKCTargetMastery();

  const handleAddKC = async () => {
    if (!selectedKCId || targetMastery === undefined) return;
    
    try {
      await addKCMutation.mutateAsync({
        lessonId,
        kcId: selectedKCId,
        targetMastery
      });
      
      toast.success("KC added to lesson successfully");
      setIsAddingKC(false);
      setSelectedKCId("");
      setTargetMastery(0.5);
      setSearchValue("");
      onKCsChange();
    } catch (error) {
      toast.error("Failed to add KC to lesson");
    }
  };

  const handleRemoveKC = async (kcId: string) => {
    try {
      await removeKCMutation.mutateAsync({
        lessonId,
        kcId
      });
      
      toast.success("KC removed from lesson successfully");
      onKCsChange();
    } catch (error) {
      toast.error("Failed to remove KC from lesson");
    }
  };

  const handleUpdateTargetMastery = async (kcId: string, newTargetMastery: number) => {
    // Prevent multiple simultaneous updates for the same KC
    if (updatingKCs.has(kcId)) {
      return;
    }

    try {
      setUpdatingKCs(prev => new Set(prev).add(kcId));
      
      // Optimistically update the local state immediately
      queryClient.setQueryData(
        ["lesson", lessonId, "with-kcs"],
        (oldData: any) => {
          if (!oldData) return oldData;
          
          return {
            ...oldData,
            knowledgeComponents: oldData.knowledgeComponents.map((mapping: any) =>
              mapping.kcId === kcId
                ? { ...mapping, targetMastery: newTargetMastery }
                : mapping
            )
          };
        }
      );
      
      await updateTargetMasteryMutation.mutateAsync({
        lessonId,
        kcId,
        targetMastery: newTargetMastery
      });
      
      toast.success("Target mastery updated successfully");
      // No need to call onKCsChange() since we already updated the cache
    } catch (error) {
      // Revert optimistic update on error
      queryClient.invalidateQueries({ queryKey: ["lesson", lessonId, "with-kcs"] });
      toast.error("Failed to update target mastery");
    } finally {
      setUpdatingKCs(prev => {
        const newSet = new Set(prev);
        newSet.delete(kcId);
        return newSet;
      });
    }
  };

  if (isLoadingLesson || isLoadingKCs) {
    return <div className="text-center py-4">Loading knowledge components...</div>;
  }

  // Filter out KCs that are already mapped to this lesson
  const availableKCsForLesson = availableKCs?.filter((kc: any) => 
    !lessonWithKCs?.knowledgeComponents?.some((mapping: any) => mapping.kcId === kc.kc_id)
  ) || [];

  // Debug logging
  logger.log('Available KCs:', availableKCs);
  logger.log('Lesson with KCs:', lessonWithKCs);
  logger.log('Available KCs for lesson:', availableKCsForLesson);

  return (
    <div className="space-y-4">
      {/* Add KC Button */}
      <div className="flex justify-end">
        <Button
          onClick={() => setIsAddingKC(true)}
          size="sm"
        >
          <Plus className="h-4 w-4 mr-2" />
          Add KC
        </Button>
      </div>

      {/* Add KC Dialog */}
      {isAddingKC && (
        <div className="border rounded-lg p-4 bg-muted/50">
          <div className="space-y-3">
            <div>
              <label className="text-sm font-medium">Select Knowledge Component</label>
              <Popover open={open} onOpenChange={setOpen}>
                <PopoverTrigger asChild>
                  <Button
                    variant="outline"
                    role="combobox"
                    aria-expanded={open}
                    className="w-full justify-between mt-1"
                  >
                    {selectedKCId
                      ? availableKCsForLesson.find((kc: any) => kc.kc_id === selectedKCId)?.kc_name
                      : "Choose a KC..."}
                    <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                  </Button>
                </PopoverTrigger>
                <PopoverContent className="w-full p-0">
                  <Command>
                    <CommandInput 
                      placeholder="Search knowledge components..." 
                      value={searchValue}
                      onValueChange={setSearchValue}
                    />
                    <CommandList>
                      <CommandEmpty>No knowledge component found.</CommandEmpty>
                      <CommandGroup>
                        {availableKCsForLesson
                          .filter((kc: any) => 
                            kc.kc_name.toLowerCase().includes(searchValue.toLowerCase())
                          )
                          .map((kc: any) => (
                            <CommandItem
                              key={kc.kc_id}
                              value={kc.kc_id}
                              onSelect={(currentValue) => {
                                setSelectedKCId(currentValue === selectedKCId ? "" : currentValue);
                                setOpen(false);
                                setSearchValue("");
                              }}
                            >
                              <Check
                                className={cn(
                                  "mr-2 h-4 w-4",
                                  selectedKCId === kc.kc_id ? "opacity-100" : "opacity-0"
                                )}
                              />
                              {kc.kc_name}
                            </CommandItem>
                          ))}
                      </CommandGroup>
                    </CommandList>
                  </Command>
                </PopoverContent>
              </Popover>
            </div>
            
            <div>
              <label className="text-sm font-medium">Target Mastery</label>
              <div className="mt-2">
                <InteractiveProgressBar
                  value={targetMastery}
                  onChange={setTargetMastery}
                  type="mastery"
                />
              </div>
            </div>
            
            <div className="flex items-center gap-2">
              <Button
                onClick={handleAddKC}
                disabled={!selectedKCId || addKCMutation.isPending}
                size="sm"
              >
                {addKCMutation.isPending ? "Adding..." : "Save"}
              </Button>
              <Button
                variant="outline"
                onClick={() => setIsAddingKC(false)}
                size="sm"
              >
                Cancel
              </Button>
            </div>
          </div>
        </div>
      )}

      {/* KC Mappings List */}
      <div className="space-y-3">
        {lessonWithKCs?.knowledgeComponents && lessonWithKCs.knowledgeComponents.length > 0 ? (
          lessonWithKCs.knowledgeComponents.map((mapping: any) => {
            const targetMasteryValue = Number(mapping.targetMastery);
            const percentage = Math.round(targetMasteryValue * 100);
            

            
            return (
              <div key={mapping.kcId} className="flex items-center justify-between p-3 border rounded-lg">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-2">
                    <span className="font-medium">{mapping.kcName}</span>
                    <Link href={`/admin/knowledge-components/${mapping.kcId}`}>
                      <Button variant="ghost" size="sm" className="h-6 w-6 p-0">
                        <ExternalLink className="h-3 w-3" />
                      </Button>
                    </Link>
                  </div>
                  <div className="flex items-center gap-4">
                    <div className="flex-1 max-w-md">
                      <InteractiveProgressBar
                        key={`${mapping.kcId}-${targetMasteryValue}`}
                        value={targetMasteryValue}
                        onChange={(value) => handleUpdateTargetMastery(mapping.kcId, value)}
                        type="mastery"
                      />
                    </div>
                    
                  </div>
                </div>
                
                <div className="flex items-center gap-2">
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => handleRemoveKC(mapping.kcId)}
                    disabled={removeKCMutation.isPending}
                  >
                    <Trash2 className="h-4 w-4" />
                  </Button>
                </div>
              </div>
            );
          })
        ) : (
          <div className="text-center py-8 text-muted-foreground">
            No knowledge components mapped to this lesson yet.
          </div>
        )}
      </div>
    </div>
  );
}
