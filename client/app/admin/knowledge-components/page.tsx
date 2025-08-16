'use client';

import { useState, useRef } from 'react';
import { useRouter } from 'next/navigation';
import { KnowledgeComponentWithRelationships } from '@/types/api';
import { DataTable } from '@/components/ui/data-table';
import { createColumns } from '@/components/admin/knowledge-components-table-columns';
import { KnowledgeComponentDrawer } from '@/components/admin/knowledge-component-drawer';
import { CreateKCDialog } from '@/components/admin/create-kc-dialog';
import { useKnowledgeComponents, useSoftDeleteKnowledgeComponents } from '@/hooks/useKnowledgeComponent';
import { Button } from '@/components/ui/button';
import { Trash2, RotateCcw } from 'lucide-react';

export default function KnowledgeComponentsPage() {
  const router = useRouter();
  const { data: knowledgeComponents, isLoading, error } = useKnowledgeComponents();
  const [selectedKCId, setSelectedKCId] = useState<string | null>(null);
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [selectedRows, setSelectedRows] = useState<KnowledgeComponentWithRelationships[]>([]);
  
  const batchDeleteMutation = useSoftDeleteKnowledgeComponents();
  
  // Get the fresh KC data based on selectedKCId
  const selectedKC = selectedKCId ? knowledgeComponents?.find((kc: KnowledgeComponentWithRelationships) => kc.kc_id === selectedKCId) : null;
  
  // Debug logging
  if (selectedKCId && selectedKC) {
    console.log('Selected KC computed:', selectedKC);
  }

  // Handle KC updates from the drawer
  const handleKCUpdate = (updatedKc: KnowledgeComponentWithRelationships) => {
    // KC updated successfully - no toast notification needed
  };

  // Handle opening the drawer
  const openDrawer = (kc: KnowledgeComponentWithRelationships) => {
    console.log('Opening drawer with KC:', kc);
    setSelectedKCId(kc.kc_id);
    setIsDrawerOpen(true);
  };

  // Handle closing the drawer
  const closeDrawer = () => {
    setIsDrawerOpen(false);
    setSelectedKCId(null);
  };

  // Handle navigation to items
  const navigateToItem = (type: 'module' | 'lesson' | 'question', id: string) => {
    switch (type) {
      case 'module':
        router.push(`/admin/modules/${id}`);
        break;
      case 'lesson':
        router.push(`/admin/lessons/${id}`);
        break;
      case 'question':
        router.push(`/admin/questions/${id}`);
        break;
    }
  };

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div>
          <h1 className="text-3xl font-bold">Knowledge Components</h1>
          <p className="text-muted-foreground">
            Manage knowledge components and their relationships to modules, lessons, and questions.
          </p>
        </div>
        
        <div className="flex items-center justify-between gap-4">
          <div className="h-10 w-64 bg-muted rounded animate-pulse"></div>
          <div className="h-10 w-32 bg-muted rounded animate-pulse"></div>
        </div>

        <div className="rounded-md border">
          <div className="h-96 bg-muted rounded animate-pulse"></div>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="space-y-6">
        <div>
          <h1 className="text-3xl font-bold">Knowledge Components</h1>
          <p className="text-muted-foreground">
            Manage knowledge components and their relationships to modules, lessons, and questions.
          </p>
        </div>
        <div className="flex items-center justify-center py-12">
          <div className="text-red-600">Error: {error?.message || 'An error occurred'}</div>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">Knowledge Components</h1>
        <p className="text-muted-foreground">
          Manage knowledge components and their relationships to modules, lessons, and questions.
        </p>
      </div>
      
      <div className="space-y-4">
        <div className="flex gap-3">
          <CreateKCDialog />
          <Button
            variant="outline"
            size="icon"
            onClick={() => {
              localStorage.removeItem('table-column-sizes-knowledge-components');
              window.location.reload();
            }}
            title="Refresh"
          >
            <RotateCcw className="h-4 w-4" />
          </Button>
        </div>
        <div className="text-sm text-muted-foreground">
          {knowledgeComponents?.length || 0} knowledge component{(knowledgeComponents?.length || 0) !== 1 ? 's' : ''} found
        </div>
      </div>

      <div className="border-t pt-6">
        <DataTable
          columns={createColumns(handleKCUpdate, openDrawer, navigateToItem)}
          data={knowledgeComponents || []}
          searchKey="kc_name"
          searchPlaceholder="Search by name or description..."
          showPagination={true}
          showToolbar={true}
          tableId="knowledge-components"
          onSelectionChange={setSelectedRows}
          onClearSelection={() => {}}
        />
      </div>

      {/* Drawer at page level to persist state */}
      {selectedKC && (
        <KnowledgeComponentDrawer
          kc={selectedKC}
          trigger={<div style={{ display: 'none' }} />}
          onUpdate={handleKCUpdate}
          isOpen={isDrawerOpen}
          onOpenChange={setIsDrawerOpen}
        />
      )}

      {/* Floating delete action bar - appears when rows are selected */}
      {selectedRows.length > 0 && (
        <div className="fixed bottom-6 left-1/2 transform -translate-x-1/2 z-50">
          <div className="bg-white border border-gray-200 rounded-lg shadow-lg px-6 py-4 flex items-center gap-4">
            <div className="flex items-center gap-2">
              <div className="w-2 h-2 bg-blue-500 rounded-full animate-pulse"></div>
              <span className="text-sm font-medium text-gray-700">
                {selectedRows.length} knowledge component{selectedRows.length !== 1 ? 's' : ''} selected for soft delete
              </span>
            </div>
            
            <div className="flex items-center gap-2">
              <Button
                variant="outline"
                size="sm"
                onClick={() => {
                  // Clear selection using the table's internal method
                  if ((window as any).__clearTableSelection) {
                    (window as any).__clearTableSelection();
                  }
                  // Also clear our local state
                  setSelectedRows([]);
                }}
                className="text-gray-600 hover:text-gray-800"
              >
                Clear Selection
              </Button>
              
              <Button
                variant="destructive"
                size="sm"
                onClick={async () => {
                  try {
                    await batchDeleteMutation.mutateAsync(
                      selectedRows.map(row => row.kc_id)
                    );
                    setSelectedRows([]);
                  } catch (error) {
                    console.error('Error soft deleting knowledge components:', error);
                  }
                }}
                disabled={batchDeleteMutation.isPending}
                className="shadow-sm"
              >
                <Trash2 className="h-4 w-4 mr-2" />
                {batchDeleteMutation.isPending ? 'Soft Deleting...' : `Soft Delete ${selectedRows.length}`}
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}