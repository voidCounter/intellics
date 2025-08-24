'use client';

import { useMemo, useState } from 'react';
import { Edit, Eye, Trash2, Search, X, Plus } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { KCTree, buildKCTree, KCTreeNode } from '@/components/admin/knowledge-component/kc-tree';
import { logger } from '@/lib/utils';
import { 
  useModuleKCs, 
  useRemoveKCFromModule, 
  useReorderModuleKCs,
  useUpdateKCPrerequisites 
} from '@/hooks/useModuleKCs';

// Utility function to truncate text to a word limit
const truncateText = (text: string, wordLimit: number = 15): string => {
  if (!text) return 'No description available';
  
  const words = text.split(' ');
  if (words.length <= wordLimit) return text;
  
  return words.slice(0, wordLimit).join(' ') + '...';
};

interface ModuleKCsTabProps {
  moduleId: string;
}

export function ModuleKCsTab({ moduleId }: ModuleKCsTabProps) {
  const [searchQuery, setSearchQuery] = useState('');

  // Use the new React Query hooks
  const { data: kcs = [], isLoading, error } = useModuleKCs(moduleId);
  const removeKCMutation = useRemoveKCFromModule(moduleId);
  const reorderKCMutation = useReorderModuleKCs(moduleId);
  const updatePrerequisitesMutation = useUpdateKCPrerequisites(moduleId);

  // Transform flat KC list to hierarchical tree
  const kcTree = useMemo(() => {
    if (!kcs || kcs.length === 0) return [];
    
    // Add unique id for each KC (required by the tree component)
    const kcsWithIds = kcs.map((kc: any) => ({
      ...kc,
      id: kc.kc_id, // Use kc_id as the unique id
    }));
    
    return buildKCTree(kcsWithIds);
  }, [kcs]);

  // Client-side search - filters KCs locally
  const filteredKCs = useMemo(() => {
    if (!searchQuery.trim()) return kcs;
    
    const query = searchQuery.toLowerCase().trim();
    return kcs.filter((kc: any) => 
      kc.kc_name.toLowerCase().includes(query) ||
      (kc.description && kc.description.toLowerCase().includes(query))
    );
  }, [kcs, searchQuery]);

  // Filter tree based on search query
  const filteredTree = useMemo(() => {
    if (!searchQuery.trim()) return kcTree;
    
    // If there's a search query, show filtered KCs in a flat list
    const filteredKCsWithIds = filteredKCs.map((kc: any) => ({
      ...kc,
      id: kc.kc_id,
      children: [],
      level: 0,
    }));
    
    return filteredKCsWithIds;
  }, [kcTree, filteredKCs, searchQuery]);

  const handleRemoveKC = (kcId: string) => {
    removeKCMutation.mutate(kcId);
  };

  const handleReorderKCs = (newOrder: KCTreeNode[]) => {
    // Transform tree order to backend format
    const kcOrders = newOrder.map((node, index) => ({
      kcId: node.kc_id,
      orderIndex: index,
    }));
    
    reorderKCMutation.mutate(kcOrders);
  };

  const handleEditKC = (kcId: string) => {
    // TODO: Implement edit functionality
    logger.log('Edit KC:', kcId);
  };

  const handleViewKC = (kcId: string) => {
    // TODO: Implement view functionality
    logger.log('View KC:', kcId);
  };

  const clearSearch = () => {
    setSearchQuery('');
  };

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-2xl font-bold">Module Knowledge Components</h2>
            <p className="text-muted-foreground">
              Manage knowledge components assigned to this module.
            </p>
          </div>
          <Button disabled>
            <Plus className="h-4 w-4 mr-2" />
            Add KC
          </Button>
        </div>
        
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="rounded-lg border bg-card p-6 animate-pulse">
              <div className="h-6 bg-muted rounded mb-4"></div>
              <div className="h-4 bg-muted rounded mb-2"></div>
              <div className="h-4 bg-muted rounded w-3/4"></div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-2xl font-bold">Module Knowledge Components</h2>
            <p className="text-muted-foreground">
              Manage knowledge components assigned to this module.
            </p>
          </div>
          <Button disabled>
            <Plus className="h-4 w-4 mr-2" />
            Add KC
          </Button>
        </div>
        <div className="flex items-center justify-center py-12">
          <div className="text-red-600">Error: {error.message}</div>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-2xl font-bold">Module Knowledge Components</h2>
          <p className="text-muted-foreground">
            Manage knowledge components assigned to this module.
          </p>
        </div>
        <Button>
          <Plus className="h-4 w-4 mr-2" />
          Add KC
        </Button>
      </div>
      
      <div className="flex items-center justify-start gap-4">
        <div className="relative flex-1 max-w-md">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="Search knowledge components..."
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
      </div>

      {/* Search Results Summary */}
      {searchQuery.trim() && (
        <div className="text-sm text-muted-foreground">
          {filteredKCs.length} result{filteredKCs.length !== 1 ? 's' : ''} for "{searchQuery}"
          {filteredKCs.length > 0 && (
            <span className="ml-2 text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded-full">
              Showing flat list for search results
            </span>
          )}
        </div>
      )}

      {filteredTree.length === 0 ? (
        <div className="text-center py-12">
          {searchQuery.trim() ? (
            <div className="space-y-2">
              <p className="text-muted-foreground">No knowledge components found matching "{searchQuery}".</p>
              <Button variant="outline" onClick={clearSearch}>
                Clear search
              </Button>
            </div>
          ) : (
            <p className="text-muted-foreground">No knowledge components assigned to this module. Add your first KC to get started.</p>
          )}
        </div>
      ) : (
        <div className="space-y-4">
          {/* Tree View */}
          <div className="border rounded-lg p-4 bg-background">
            <KCTree
              nodes={filteredTree}
              onReorder={handleReorderKCs}
              onEdit={handleEditKC}
              onView={handleViewKC}
              onRemove={handleRemoveKC}
            />
          </div>
        </div>
      )}
    </div>
  );
}
