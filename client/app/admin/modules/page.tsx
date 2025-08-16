'use client';

import { useEffect, useState, useCallback, useMemo } from 'react';
import { Module } from '@/types/api';
import { CreateModuleDialog } from '@/components/admin/create-module-dialog';
import { ModuleSkeletonGrid } from '@/components/admin/module-skeleton';
import { DeleteConfirmationDialog } from '@/components/admin/delete-confirmation-dialog';
import { Edit, Eye, Trash2, Search, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { toast } from 'sonner';
import Link from 'next/link';

// Utility function to truncate text to a word limit
const truncateText = (text: string, wordLimit: number = 15): string => {
  if (!text) return 'No description available';
  
  const words = text.split(' ');
  if (words.length <= wordLimit) return text;
  
  return words.slice(0, wordLimit).join(' ') + '...';
};

export default function ModulesPage() {
  const [modules, setModules] = useState<Module[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [editingModule, setEditingModule] = useState<Module | null>(null);
  const [deletingModuleId, setDeletingModuleId] = useState<string | null>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [moduleToDelete, setModuleToDelete] = useState<Module | null>(null);
  const [searchQuery, setSearchQuery] = useState('');

  // Client-side search - filters modules locally
  const filteredModules = useMemo(() => {
    if (!searchQuery.trim()) return modules;
    
    const query = searchQuery.toLowerCase().trim();
    return modules.filter(module => 
      module.module_name.toLowerCase().includes(query) ||
      (module.description && module.description.toLowerCase().includes(query))
    );
  }, [modules, searchQuery]);

  const fetchModules = useCallback(async () => {
    try {
      setLoading(true);
      
      // Get the auth token from localStorage
      const token = localStorage.getItem('authToken');
      if (!token) {
        setError('Authentication required');
        setLoading(false);
        return;
      }

      const response = await fetch('/api/modules', {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });
      
      if (!response.ok) {
        if (response.status === 401) {
          setError('Authentication failed');
        } else {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return;
      }
      
      const data = await response.json();
      if (data.status === 'SUCCESS') {
        setModules(data.data);
      } else {
        setError('Failed to fetch modules');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchModules();
  }, [fetchModules]);

  const handleModuleCreated = () => {
    // Refresh the modules list after creating a new one
    fetchModules();
  };

  const handleModuleUpdated = () => {
    // Refresh the modules list after updating one
    fetchModules();
    setEditingModule(null);
  };

  const handleEditClick = (module: Module) => {
    setEditingModule(module);
  };

  const handleDeleteClick = (module: Module) => {
    setModuleToDelete(module);
    setDeleteDialogOpen(true);
  };

  const handleDeleteConfirm = async () => {
    if (!moduleToDelete) return;

    try {
      setDeletingModuleId(moduleToDelete.module_id);
      
      const token = localStorage.getItem('authToken');
      if (!token) {
        toast.error('Authentication required');
        return;
      }

      const response = await fetch(`/api/modules/${moduleToDelete.module_id}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.message || 'Failed to delete module');
      }

      // Update local state directly instead of refetching
      setModules(prevModules => 
        prevModules.filter(module => module.module_id !== moduleToDelete.module_id)
      );
      
      toast.success('Module deleted successfully');
      setDeleteDialogOpen(false);
      setModuleToDelete(null);
    } catch (error) {
      console.error('Error deleting module:', error);
      toast.error(error instanceof Error ? error.message : 'Failed to delete module');
    } finally {
      setDeletingModuleId(null);
    }
  };

  const clearSearch = () => {
    setSearchQuery('');
  };

  if (loading) {
    return (
      <div className="space-y-6">
        <div>
          <h1 className="text-3xl font-bold">Module Management</h1>
          <p className="text-muted-foreground">
            Create, edit, and organize learning modules and their content.
          </p>
        </div>
        
        <div className="flex justify-end">
          <CreateModuleDialog onModuleCreated={handleModuleCreated} onModuleUpdated={handleModuleUpdated} />
        </div>

        <ModuleSkeletonGrid count={6} />
      </div>
    );
  }

  if (error) {
    return (
      <div className="space-y-6">
        <div>
          <h1 className="text-3xl font-bold">Module Management</h1>
          <p className="text-muted-foreground">
            Create, edit, and organize learning modules and their content.
          </p>
        </div>
        <div className="flex items-center justify-center py-12">
          <div className="text-red-600">Error: {error}</div>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">Module Management</h1>
        <p className="text-muted-foreground">
          Create, edit, and organize learning modules and their content.
        </p>
      </div>
      
      <div className="flex items-center justify-start gap-4">
        <div className="relative flex-1 max-w-md">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="Search modules..."
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
        <CreateModuleDialog onModuleCreated={handleModuleCreated} onModuleUpdated={handleModuleUpdated} />
      </div>

      {/* Search Results Summary */}
      {searchQuery.trim() && (
        <div className="text-sm text-muted-foreground">
          {filteredModules.length} result{filteredModules.length !== 1 ? 's' : ''} for "{searchQuery}"
        </div>
      )}

      {filteredModules.length === 0 ? (
        <div className="text-center py-12">
          {searchQuery.trim() ? (
            <div className="space-y-2">
              <p className="text-muted-foreground">No modules found matching "{searchQuery}".</p>
              <Button variant="outline" onClick={clearSearch}>
                Clear search
              </Button>
            </div>
          ) : (
            <p className="text-muted-foreground">No modules found. Create your first module to get started.</p>
          )}
        </div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {filteredModules.map((module) => (
            <div 
              key={module.module_id} 
              className="rounded-lg border bg-card p-6 flex flex-col justify-between transition-all duration-200 hover:shadow-md"
            >
              <div className="flex justify-between items-start mb-4">
                <h3 className="font-semibold text-lg break-words overflow-hidden">{module.module_name}</h3>
              </div>
              <p className="text-muted-foreground mb-4 min-h-[3rem] break-words overflow-hidden">
                {truncateText(module.description, 12)}
              </p>
              <div className="flex items-center justify-between gap-2">
                <div className="flex gap-2">
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => handleEditClick(module)}
                    className="h-8 px-3"
                  >
                    <Edit className="h-3.5 w-3.5 mr-1.5" />
                    Edit
                  </Button>
                  <Link href={`/admin/modules/${module.module_id}`}>
                    <Button
                      variant="outline"
                      size="sm"
                      className="h-8 px-3"
                    >
                      <Eye className="h-3.5 w-3.5 mr-1.5" />
                      View
                    </Button>
                  </Link>
                </div>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => handleDeleteClick(module)}
                  disabled={deletingModuleId === module.module_id}
                  className="h-8 w-8 p-0 text-red-600 hover:text-red-700 hover:bg-red-50"
                >
                  <Trash2 className="h-3.5 w-3.5" />
                </Button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Edit Dialog - positioned outside the grid */}
      {editingModule && (
        <CreateModuleDialog
          module={editingModule}
          mode="edit"
          open={!!editingModule}
          onOpenChange={(open) => {
            if (!open) {
              setEditingModule(null);
            }
          }}
          onClose={() => setEditingModule(null)}
          onModuleCreated={handleModuleCreated}
          onModuleUpdated={handleModuleUpdated}
        />
      )}

      {/* Delete Confirmation Dialog */}
      <DeleteConfirmationDialog
        open={deleteDialogOpen}
        onOpenChange={setDeleteDialogOpen}
        onConfirm={handleDeleteConfirm}
        moduleName={moduleToDelete?.module_name || ''}
        isLoading={deletingModuleId === moduleToDelete?.module_id}
      />
    </div>
  );
}
