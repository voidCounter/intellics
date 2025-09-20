import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Module, ModuleTitle } from "@/types/api";

const BACKEND_URL =
    process.env.NEXT_PUBLIC_API_BASE_URL || "http://localhost:8080";

// Hierarchical query keys for better cache invalidation
const moduleKeys = {
  all: ["modules"],
  lists: () => [...moduleKeys.all, "list"],
  list: (filters: string) => [...moduleKeys.lists(), { filters }],
  details: () => [...moduleKeys.all, "detail"],
  detail: (id: string) => [...moduleKeys.details(), id],
  kcMappings: (moduleId: string) => [...moduleKeys.detail(moduleId), "kcs"],
};

// Fetch all modules (no pagination support in backend)
export function useModules() {
  return useQuery({
    queryKey: moduleKeys.list("all"),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/modules`, // Backend doesn't support pagination
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch modules");
      }

      const data = await response.json();
      return data.data;
    },
  });
}

// Fetch all modules (for dropdowns, etc.)
export function useAllModules() {
  return useQuery<ModuleTitle[]>({
    queryKey: moduleKeys.list("all"),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/modules`, // No size parameter needed for non-paginated endpoint
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch all modules");
      }

      const data = await response.json();
      return data.data; // Direct array, not data.content
    },
  });
}

// Fetch module by ID
export function useModule(moduleId: string) {
  return useQuery({
    queryKey: moduleKeys.detail(moduleId),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/modules/${moduleId}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch module");
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!moduleId,
  });
}

// Fetch module's KC mappings
export function useModuleKCMappings(moduleId: string) {
  return useQuery({
    queryKey: moduleKeys.kcMappings(moduleId),
    queryFn: async () => {
      const token = localStorage.getItem("authToken");
      if (!token) throw new Error("No auth token");

      const response = await fetch(
        `${BACKEND_URL}/api/v1/modules/${moduleId}/kcs`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error("Failed to fetch module KC mappings");
      }

      const data = await response.json();
      return data.data;
    },
    enabled: !!moduleId,
  });
}
