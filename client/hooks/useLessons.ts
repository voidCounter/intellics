import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { LessonTitle } from "@/types/api";

const BACKEND_URL =
   process.env.NEXT_PUBLIC_API_BASE_URL || "http://localhost:8080";

// Hierarchical query keys for better cache invalidation
const lessonKeys = {
  all: ["lessons"],
  lists: () => [...lessonKeys.all, "list"],
  list: (filters: string) => [...lessonKeys.lists(), { filters }],
  details: () => [...lessonKeys.all, "detail"],
  detail: (id: string) => [...lessonKeys.details(), id],
  kcMappings: (lessonId: string) => [...lessonKeys.detail(lessonId), "kcs"],
};

// Fetch lesson titles for dropdowns (efficient)
export function useLessonTitles() {
  return useQuery<LessonTitle[]>({
    queryKey: lessonKeys.list("titles"),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/lessons?titlesOnly=true`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch lesson titles");
      }

      const data = await response.json();
      return data.data;
    },
  });
}

// Fetch all lessons (no pagination support in backend)
export function useLessons() {
  return useQuery({
    queryKey: lessonKeys.list("all"),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/lessons`, // Backend doesn't support pagination
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch lessons");
      }

      const data = await response.json();
      return data.data;
    },
  });
}

// Fetch all lessons (for dropdowns, etc.)
export function useAllLessons() {
  return useQuery<LessonTitle[]>({
    queryKey: lessonKeys.list("all"),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/lessons`, // No size parameter needed for non-paginated endpoint
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch all lessons");
      }

      const data = await response.json();
      return data.data; // Direct array, not data.content
    },
  });
}

// Fetch lesson by ID
export function useLesson(lessonId: string) {
  return useQuery({
    queryKey: lessonKeys.detail(lessonId),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/lessons/${lessonId}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch lesson");
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!lessonId,
  });
}

// Fetch lesson's KC mappings
export function useLessonKCMappings(lessonId: string) {
  return useQuery({
    queryKey: lessonKeys.kcMappings(lessonId),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/lessons/${lessonId}/kcs`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch lesson KC mappings");
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!lessonId,
  });
}
