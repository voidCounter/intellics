import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { toast } from 'sonner';

import { logger } from '@/lib/utils';
export interface ModuleKC {
  kc_id: string;
  kc_name: string;
  description: string;
  prerequisiteKcIds: string[];
}

export interface ModuleKCWithPrerequisites {
  kc_id: string;
  kc_name: string;
  description: string;
  prerequisiteKcIds: string[];
}

// Hook for fetching module KCs with prerequisites
export function useModuleKCs(moduleId: string) {
  return useQuery({
    queryKey: ['module-kcs', moduleId],
    queryFn: async (): Promise<ModuleKCWithPrerequisites[]> => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('Authentication required');
      }

      const response = await fetch(`/api/modules/${moduleId}/kcs`, {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });

      if (!response.ok) {
        if (response.status === 401) {
          throw new Error('Authentication failed');
        } else {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
      }

      const data = await response.json();
      if (data.status === 'SUCCESS') {
        return data.data;
      } else {
        throw new Error('Failed to fetch knowledge components');
      }
    },
    enabled: !!moduleId,
  });
}

// Hook for adding KC to module
export function useAddKCToModule(moduleId: string) {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (kcData: { kcId: string; prerequisiteKcIds?: string[] }) => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('Authentication required');
      }

      const response = await fetch(`/api/modules/${moduleId}/kcs`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          kcId: kcData.kcId,
          prerequisiteKcIds: kcData.prerequisiteKcIds || [],
        }),
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.message || 'Failed to add KC to module');
      }

      return response.json();
    },
    onSuccess: () => {
      // Invalidate and refetch the module KCs query
      queryClient.invalidateQueries({ queryKey: ['module-kcs', moduleId] });
      toast.success('Knowledge Component added to module successfully');
    },
    onError: (error: Error) => {
      logger.error('Error adding KC to module:', error);
      toast.error(error.message || 'Failed to add KC to module');
    },
  });
}

// Hook for removing KC from module
export function useRemoveKCFromModule(moduleId: string) {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (kcId: string) => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('Authentication required');
      }

      const response = await fetch(`/api/modules/${moduleId}/kcs/${kcId}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.message || 'Failed to remove KC from module');
      }

      return response;
    },
    onSuccess: () => {
      // Invalidate and refetch the module KCs query
      queryClient.invalidateQueries({ queryKey: ['module-kcs', moduleId] });
      toast.success('Knowledge Component removed from module successfully');
    },
    onError: (error: Error) => {
      logger.error('Error removing KC from module:', error);
      toast.error(error.message || 'Failed to remove KC from module');
    },
  });
}

// Hook for updating KC prerequisites
export function useUpdateKCPrerequisites(moduleId: string) {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (kcData: { kcId: string; prerequisiteKcIds: string[] }) => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('Authentication required');
      }

      const response = await fetch(`/api/modules/${moduleId}/kcs/${kcData.kcId}/prerequisites`, {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          prerequisiteKcIds: kcData.prerequisiteKcIds,
        }),
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.message || 'Failed to update KC prerequisites');
      }

      return response.json();
    },
    onSuccess: () => {
      // Invalidate and refetch the module KCs query
      queryClient.invalidateQueries({ queryKey: ['module-kcs', moduleId] });
      toast.success('KC prerequisites updated successfully');
    },
    onError: (error: Error) => {
      logger.error('Error updating KC prerequisites:', error);
      toast.error(error.message || 'Failed to update KC prerequisites');
    },
  });
}

// Hook for reordering KCs in module
export function useReorderModuleKCs(moduleId: string) {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (newOrder: { kcId: string; orderIndex: number }[]) => {
      const token = localStorage.getItem('authToken');
      if (!token) {
        throw new Error('Authentication required');
      }

      const response = await fetch(`/api/modules/${moduleId}/kcs/reorder`, {
        method: 'PUT',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ kcOrders: newOrder }),
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.message || 'Failed to reorder KCs');
      }

      return response.json();
    },
    onSuccess: () => {
      // Invalidate and refetch the module KCs query
      queryClient.invalidateQueries({ queryKey: ['module-kcs', moduleId] });
      toast.success('KC order updated successfully');
    },
    onError: (error: Error) => {
      logger.error('Error reordering KCs:', error);
      toast.error(error.message || 'Failed to reorder KCs');
    },
  });
}
