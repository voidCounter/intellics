import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";

const BACKEND_URL =
  process.env.NEXT_PUBLIC_BACKEND_URL || "http://localhost:8080";

// Hierarchical query keys for better cache invalidation
const kcKeys = {
  all: ["kcs"],
  lists: () => [...kcKeys.all, "list"],
  list: (filters: string) => [...kcKeys.lists(), { filters }],
  details: () => [...kcKeys.all, "detail"],
  detail: (id: string) => [...kcKeys.details(), id],
};

// Fetch all knowledge components with relationships
export function useKnowledgeComponents() {
  return useQuery({
    queryKey: kcKeys.list("all"),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(`${BACKEND_URL}/api/v1/kcs?include=true`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error("Failed to fetch knowledge components");
      }

      const data = await response.json();
      return data.data.content;
    },
  });
}

// Fetch KC with relationships
export function useKnowledgeComponent(kcId: string) {
  return useQuery({
    queryKey: kcKeys.detail(kcId),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/kcs/${kcId}?include=true`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch KC");
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!kcId,
  });
}

// Add KC to lesson
export function useAddKCToLesson() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      lessonId,
      kcId,
      targetMastery,
    }: {
      lessonId: string;
      kcId: string;
      targetMastery: number;
    }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/lessons/${lessonId}/kcs`,
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ kcId, targetMastery }),
        }
      );

      if (!response.ok) {
        throw new Error("Failed to add KC to lesson");
      }

      return response.json();
    },
    onSuccess: (_, { kcId }) => {
      // Invalidate both individual KC and KC list to trigger refetch
      queryClient.invalidateQueries({ queryKey: kcKeys.detail(kcId) });
      queryClient.invalidateQueries({ queryKey: kcKeys.lists() });
      queryClient.refetchQueries({ queryKey: kcKeys.lists() });
    },
  });
}

// Remove KC from lesson
export function useRemoveKCFromLesson() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      lessonId,
      kcId,
    }: {
      lessonId: string;
      kcId: string;
    }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/lessons/${lessonId}/kcs/${kcId}`,
        {
          method: "DELETE",
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to remove KC from lesson");
      }

      // DELETE endpoints typically return 204 No Content with no body
      // Don't try to parse JSON for successful DELETE responses
      if (response.status === 204) {
        return null;
      }

      // Only try to parse JSON if there's actually content
      const contentType = response.headers.get("content-type");
      if (contentType && contentType.includes("application/json")) {
        return response.json();
      }

      return null;
    },
    onSuccess: (_, { kcId }) => {
      // Invalidate both individual KC and KC list to trigger refetch
      queryClient.invalidateQueries({ queryKey: kcKeys.detail(kcId) });
      queryClient.invalidateQueries({ queryKey: kcKeys.lists() });
      queryClient.refetchQueries({ queryKey: kcKeys.lists() });
    },
  });
}

// Add KC to question
export function useAddKCToQuestion() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      questionId,
      kcId,
      weight,
    }: {
      questionId: string;
      kcId: string;
      weight: number;
    }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions/${questionId}/kcs`,
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ kc_id: kcId, weight }),
        }
      );

      if (!response.ok) {
        throw new Error("Failed to add KC to question");
      }

      return response.json();
    },
    onSuccess: (_, { kcId }) => {
      // Invalidate both individual KC and KC list to trigger refetch
      queryClient.invalidateQueries({ queryKey: kcKeys.detail(kcId) });
      queryClient.invalidateQueries({ queryKey: kcKeys.lists() });
      queryClient.refetchQueries({ queryKey: kcKeys.lists() });
    },
  });
}

// Remove KC from question
export function useRemoveKCFromQuestion() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      questionId,
      kcId,
    }: {
      questionId: string;
      kcId: string;
    }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions/${questionId}/kcs/${kcId}`,
        {
          method: "DELETE",
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to remove KC from question");
      }

      // DELETE endpoints typically return 204 No Content with no body
      if (response.status === 204) {
        return null;
      }

      // Only try to parse JSON if there's actually content
      const contentType = response.headers.get("content-type");
      if (contentType && contentType.includes("application/json")) {
        return response.json();
      }

      return null;
    },
    onSuccess: (_, { kcId }) => {
      // Invalidate both individual KC and KC list to trigger refetch
      queryClient.invalidateQueries({ queryKey: kcKeys.detail(kcId) });
      queryClient.invalidateQueries({ queryKey: kcKeys.lists() });
      queryClient.refetchQueries({ queryKey: kcKeys.lists() });
    },
  });
}

// Update KC target mastery in lesson
export function useUpdateKCTargetMastery() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      lessonId,
      kcId,
      targetMastery,
    }: {
      lessonId: string;
      kcId: string;
      targetMastery: number;
    }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/lessons/${lessonId}/kcs/${kcId}`,
        {
          method: "PATCH",
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ targetMastery }),
        }
      );

      if (!response.ok) {
        const errorText = await response.text();
        console.error('Target mastery update failed:', response.status, errorText);
        throw new Error(`Failed to update target mastery: ${response.status} ${errorText}`);
      }

      return response.json();
    },
    onSuccess: (_, { kcId }) => {
      // Invalidate both individual KC and KC list to trigger refetch
      queryClient.invalidateQueries({ queryKey: kcKeys.detail(kcId) });
      queryClient.invalidateQueries({ queryKey: kcKeys.lists() });
      queryClient.refetchQueries({ queryKey: kcKeys.lists() });
    },
  });
}

// Update KC weight in question
export function useUpdateKCWeight() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      questionId,
      kcId,
      weight,
    }: {
      questionId: string;
      kcId: string;
      weight: number;
    }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/questions/${questionId}/kcs/${kcId}`,
        {
          method: "PATCH",
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ weight }),
        }
      );

      if (!response.ok) {
        const errorText = await response.text();
        console.error('Question weight update failed:', response.status, errorText);
        throw new Error(`Failed to update weight: ${response.status} ${errorText}`);
      }

      return response.json();
    },
    onSuccess: (_, { kcId }) => {
      // Invalidate both individual KC and KC list to trigger refetch
      queryClient.invalidateQueries({ queryKey: kcKeys.detail(kcId) });
      queryClient.invalidateQueries({ queryKey: kcKeys.lists() });
      queryClient.refetchQueries({ queryKey: kcKeys.lists() });
    },
  });
}

// Create new knowledge component
export function useCreateKnowledgeComponent() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      kc_name,
      description,
    }: {
      kc_name: string;
      description?: string;
    }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(`${BACKEND_URL}/api/v1/kcs`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ kc_name, description }),
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.message || "Failed to create knowledge component");
      }

      return response.json();
    },
    onSuccess: () => {
      // Invalidate KC list to trigger refetch
      queryClient.invalidateQueries({ queryKey: kcKeys.lists() });
      queryClient.refetchQueries({ queryKey: kcKeys.lists() });
    },
  });
}

// Add KC to module
export function useAddKCToModule() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      moduleId,
      kcId,
    }: {
      moduleId: string;
      kcId: string;
    }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const requestBody = { kcId };
      console.log('Sending request body:', requestBody);
      console.log('kcId type:', typeof kcId, 'value:', kcId);
      console.log('JSON stringified:', JSON.stringify(requestBody));

      const response = await fetch(
        `${BACKEND_URL}/api/v1/modules/${moduleId}/kcs/link`, // Use the correct endpoint for linking existing KCs
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify(requestBody),
        }
      );

      if (!response.ok) {
        throw new Error("Failed to add KC to module");
      }

      return response.json();
    },
    onSuccess: (_, { kcId }) => {
      // Invalidate both individual KC and KC list to trigger refetch
      queryClient.invalidateQueries({ queryKey: kcKeys.detail(kcId) });
      queryClient.invalidateQueries({ queryKey: kcKeys.lists() });
      queryClient.refetchQueries({ queryKey: kcKeys.lists() });
    },
  });
}

// Remove KC from module
export function useRemoveKCFromModule() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      moduleId,
      kcId,
    }: {
      moduleId: string;
      kcId: string;
    }) => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/modules/${moduleId}/kcs/${kcId}`,
        {
          method: "DELETE",
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to remove KC from module");
      }

      // DELETE endpoints typically return 204 No Content with no body
      if (response.status === 204) {
        return null;
      }

      // Only try to parse JSON if there's actually content
      const contentType = response.headers.get("content-type");
      if (contentType && contentType.includes("application/json")) {
        return response.json();
      }

      return null;
    },
    onSuccess: (_, { kcId }) => {
      // Invalidate both individual KC and KC list to trigger refetch
      queryClient.invalidateQueries({ queryKey: kcKeys.detail(kcId) });
      queryClient.invalidateQueries({ queryKey: kcKeys.lists() });
      queryClient.refetchQueries({ queryKey: kcKeys.lists() });
    },
  });
}
