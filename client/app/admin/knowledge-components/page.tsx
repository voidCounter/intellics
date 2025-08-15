'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { KnowledgeComponentWithRelationships } from '@/types/api';
import { DataTable } from '@/components/ui/data-table';
import { createColumns } from '@/components/admin/knowledge-components-table-columns';
import { KnowledgeComponentDrawer } from '@/components/admin/knowledge-component-drawer';
import { CreateKCDialog } from '@/components/admin/create-kc-dialog';
import { useKnowledgeComponents } from '@/hooks/useKnowledgeComponent';

export default function KnowledgeComponentsPage() {
  const router = useRouter();
  const { data: knowledgeComponents, isLoading, error } = useKnowledgeComponents();
  const [selectedKCId, setSelectedKCId] = useState<string | null>(null);
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  
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
      
      <div className="flex items-center justify-between gap-4">
        <div className="text-sm text-muted-foreground">
          {knowledgeComponents?.length || 0} knowledge component{(knowledgeComponents?.length || 0) !== 1 ? 's' : ''} found
        </div>
        <CreateKCDialog />
      </div>

      <DataTable
        columns={createColumns(handleKCUpdate, openDrawer, navigateToItem)}
        data={knowledgeComponents || []}
        searchKey="kc_name"
        searchPlaceholder="Search by name or description..."
        showPagination={true}
        showToolbar={true}
        onRowClick={openDrawer}
      />

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
    </div>
  );
}