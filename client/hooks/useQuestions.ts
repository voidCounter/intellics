import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { QuestionTitle } from "@/types/api";

const BACKEND_URL =
  process.env.NEXT_PUBLIC_BACKEND_URL || "http://localhost:8080";

// Hierarchical query keys for better cache invalidation
const questionKeys = {
  all: ["questions"],
  lists: () => [...questionKeys.all, "list"],
  list: (filters: string) => [...questionKeys.lists(), { filters }],
  details: () => [...questionKeys.all, "detail"],
  detail: (id: string) => [...questionKeys.details(), id],
  kcMappings: (questionId: string) => [...questionKeys.detail(questionId), "kcs"],
  scaffolds: (questionId: string) => [...questionKeys.detail(questionId), "scaffolds"],
};

// Fetch all questions with pagination
export function useQuestions(page: number = 0, size: number = 20) {
  return useQuery({
    queryKey: questionKeys.list(`page=${page}&size=${size}`),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions?page=${page}&size=${size}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch questions");
      }

      const data = await response.json();
      return data.data;
    },
  });
}

// Fetch all questions (for dropdowns, etc.)
export function useAllQuestions() {
  return useQuery<QuestionTitle[]>({
    queryKey: questionKeys.list("all"),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions?titlesOnly=true`, // Use titlesOnly for efficiency
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch all questions");
      }

      const data = await response.json();
      return data.data;
    },
  });
}

// Fetch question by ID
export function useQuestion(questionId: string) {
  return useQuery({
    queryKey: questionKeys.detail(questionId),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions/${questionId}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch question");
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!questionId,
  });
}

// Fetch question's KC mappings
export function useQuestionKCMappings(questionId: string) {
  return useQuery({
    queryKey: questionKeys.kcMappings(questionId),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions/${questionId}/kcs`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch question KC mappings");
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!questionId,
  });
}

// Fetch question's scaffolds
export function useQuestionScaffolds(questionId: string) {
  return useQuery({
    queryKey: questionKeys.scaffolds(questionId),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions/${questionId}/scaffolds`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch question scaffolds");
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!questionId,
  });
}

// Create new question
export function useCreateQuestion() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (questionData: any) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions`,
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify(questionData),
        }
      );

      if (!response.ok) {
        throw new Error("Failed to create question");
      }

      return response.json();
    },
    onSuccess: () => {
      // Invalidate questions list to trigger refetch
      queryClient.invalidateQueries({ queryKey: questionKeys.lists() });
    },
  });
}

// Update question
export function useUpdateQuestion() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({ questionId, questionData }: { questionId: string; questionData: any }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions/${questionId}`,
        {
          method: "PUT",
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify(questionData),
        }
      );

      if (!response.ok) {
        throw new Error("Failed to update question");
      }

      return response.json();
    },
    onSuccess: (_, { questionId }) => {
      // Invalidate specific question and questions list
      queryClient.invalidateQueries({ queryKey: questionKeys.detail(questionId) });
      queryClient.invalidateQueries({ queryKey: questionKeys.lists() });
    },
  });
}

// Delete question
export function useDeleteQuestion() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (questionId: string) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions/${questionId}`,
        {
          method: "DELETE",
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to delete question");
      }

      return response.json();
    },
    onSuccess: (_, questionId) => {
      // Invalidate specific question and questions list
      queryClient.invalidateQueries({ queryKey: questionKeys.detail(questionId) });
      queryClient.invalidateQueries({ queryKey: questionKeys.lists() });
    },
  });
}
