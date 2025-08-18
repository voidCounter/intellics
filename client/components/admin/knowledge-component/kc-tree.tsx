'use client';

import React, { useState, useEffect } from 'react';
import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
  DragEndEvent,
} from '@dnd-kit/core';
import {
  SortableContext,
  useSortable,
  sortableKeyboardCoordinates,
  verticalListSortingStrategy,
} from '@dnd-kit/sortable';
import { ChevronDown, ChevronRight, GripVertical, Edit, Eye, Trash2 } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';

export interface KCTreeNode {
  id: string;
  kc_id: string;
  kc_name: string;
  description: string;
  prerequisiteKcIds: string[];
  children: KCTreeNode[];
  level: number;
}

interface KCTreeProps {
  nodes: KCTreeNode[];
  onReorder?: (newOrder: KCTreeNode[]) => void;
  onEdit?: (kcId: string) => void;
  onView?: (kcId: string) => void;
  onRemove?: (kcId: string) => void;
}

interface DraggableNodeProps {
  node: KCTreeNode;
  index: number;
  isExpanded: boolean;
  hasChildren: boolean;
  indentLevel: number;
  onToggle: (nodeId: string) => void;
  onEdit?: (kcId: string) => void;
  onView?: (kcId: string) => void;
  onRemove?: (kcId: string) => void;
  isDragging: boolean;
  expandedNodes: Set<string>;
}

function DraggableNode({ 
  node, 
  index, 
  isExpanded, 
  hasChildren, 
  indentLevel, 
  onToggle, 
  onEdit, 
  onView, 
  onRemove, 
  isDragging,
  expandedNodes
}: DraggableNodeProps) {
  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging: isNodeDragging,
  } = useSortable({ id: node.id });

  const style = {
    transform: transform ? `translate3d(${transform.x}px, ${transform.y}px, 0)` : undefined,
    transition,
  };

  return (
    <div ref={setNodeRef} style={style} className="group">
      <div
        className={cn(
          "flex items-center gap-2 p-3 border rounded-lg mb-2 transition-all duration-200 hover:bg-muted/50",
          "bg-card",
          isNodeDragging && "opacity-50"
        )}
        style={{ marginLeft: `${indentLevel}px` }}
      >
        {/* Drag Handle */}
        <div 
          {...attributes}
          {...listeners}
          className={cn(
            "flex-shrink-0 cursor-grab active:cursor-grabbing p-1 rounded transition-colors",
            isDragging ? "bg-primary/20" : "hover:bg-muted/50"
          )}
          title="Drag to reorder"
        >
          <GripVertical className={cn(
            "h-4 w-4 transition-colors",
            isDragging ? "text-primary" : "text-muted-foreground"
          )} />
        </div>

        {/* Expand/Collapse Button */}
        {hasChildren && (
          <Button
            variant="ghost"
            size="sm"
            className="h-6 w-6 p-0 flex-shrink-0"
            onClick={() => onToggle(node.id)}
          >
            {isExpanded ? (
              <ChevronDown className="h-4 w-4" />
            ) : (
              <ChevronRight className="h-4 w-4" />
            )}
          </Button>
        )}

        {/* KC Info */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2">
            <h4 className="font-medium text-sm truncate">{node.kc_name}</h4>
            {node.prerequisiteKcIds.length > 0 && (
              <span className="text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded-full">
                {node.prerequisiteKcIds.length} prereq{node.prerequisiteKcIds.length !== 1 ? 's' : ''}
              </span>
            )}
          </div>
          {node.description && (
            <p className="text-xs text-muted-foreground truncate mt-1">
              {node.description}
            </p>
          )}
        </div>

        {/* Action Buttons */}
        <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
          {onView && (
            <Button
              variant="ghost"
              size="sm"
              className="h-7 w-7 p-0"
              onClick={() => onView(node.kc_id)}
            >
              <Eye className="h-3.5 w-3.5" />
            </Button>
          )}
          {onEdit && (
            <Button
              variant="ghost"
              size="sm"
              className="h-7 w-7 p-0"
              onClick={() => onEdit(node.kc_id)}
            >
              <Edit className="h-3.5 w-3.5" />
            </Button>
          )}
          {onRemove && (
            <Button
              variant="ghost"
              size="sm"
              className="h-7 w-7 p-0 text-red-600 hover:text-red-700 hover:bg-red-50"
              onClick={() => onRemove(node.kc_id)}
            >
              <Trash2 className="h-3.5 w-3.5" />
            </Button>
          )}
        </div>
      </div>

      {/* Render Children */}
      {hasChildren && isExpanded && (
        <div className="ml-4">
          {node.children.map((child, childIndex) => (
            <DraggableNode
              key={child.id}
              node={child}
              index={childIndex}
              isExpanded={expandedNodes.has(child.id)}
              hasChildren={child.children && child.children.length > 0}
              indentLevel={child.level}
              onToggle={onToggle}
              onEdit={onEdit}
              onView={onView}
              onRemove={onRemove}
              isDragging={isDragging}
              expandedNodes={expandedNodes}
            />
          ))}
        </div>
      )}
    </div>
  );
}

export function KCTree({ nodes, onReorder, onEdit, onView, onRemove }: KCTreeProps) {
  const [expandedNodes, setExpandedNodes] = useState<Set<string>>(new Set());
  const [localNodes, setLocalNodes] = useState<KCTreeNode[]>(nodes);
  const [isDragging, setIsDragging] = useState(false);

  // Debug: Log the tree structure
  console.log('KCTree nodes:', nodes);
  console.log('KCTree localNodes:', localNodes);
  console.log('KCTree expandedNodes:', expandedNodes);

  // Update localNodes when nodes prop changes
  useEffect(() => {
    setLocalNodes(nodes);
  }, [nodes]);

  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor, {
      coordinateGetter: sortableKeyboardCoordinates,
    })
  );

  const toggleNode = (nodeId: string) => {
    console.log('toggleNode called with:', nodeId);
    setExpandedNodes(prev => {
      const newSet = new Set(prev);
      if (newSet.has(nodeId)) {
        newSet.delete(nodeId);
        console.log('Node collapsed:', nodeId);
      } else {
        newSet.add(nodeId);
        console.log('Node expanded:', nodeId);
      }
      console.log('New expandedNodes:', newSet);
      return newSet;
    });
  };

  const handleDragStart = () => {
    setIsDragging(true);
  };

  const handleDragEnd = (event: DragEndEvent) => {
    setIsDragging(false);
    const { active, over } = event;

    if (over && active.id !== over.id) {
      // Find the dragged node and target node
      const draggedNode = findNodeById(localNodes, active.id as string);
      const targetNode = findNodeById(localNodes, over.id as string);
      
      if (draggedNode && targetNode) {
        // Update prerequisites based on the new position
        const newTree = updatePrerequisitesOnDrag(localNodes, draggedNode.id, targetNode.id);
        setLocalNodes(newTree);
        onReorder?.(newTree);
      }
    }
  };

  // Helper function to find a node by ID in the tree
  const findNodeById = (nodes: KCTreeNode[], id: string): KCTreeNode | null => {
    for (const node of nodes) {
      if (node.id === id) return node;
      if (node.children) {
        const found = findNodeById(node.children, id);
        if (found) return found;
      }
    }
    return null;
  };

  // Helper function to update prerequisites based on drag position
  const updatePrerequisitesOnDrag = (nodes: KCTreeNode[], draggedId: string, targetId: string): KCTreeNode[] => {
    // Find the dragged node and target node
    const draggedNode = findNodeById(nodes, draggedId);
    const targetNode = findNodeById(nodes, targetId);
    
    if (!draggedNode || !targetNode) return nodes;
    
    // Create a new tree with updated prerequisites
    const newNodes = nodes.map(node => {
      if (node.id === draggedId) {
        // Update the dragged node's prerequisites
        let newPrerequisites: string[] = [];
        
        // If dragging above target, target becomes prerequisite
        if (isAboveTarget(nodes, draggedId, targetId)) {
          newPrerequisites = [targetId];
        }
        // If dragging below target, dragged becomes prerequisite of target
        else if (isBelowTarget(nodes, draggedId, targetId)) {
          // Find all KCs that should be prerequisites of the dragged node
          newPrerequisites = findPrerequisitesForPosition(nodes, draggedId, targetId);
        }
        
        return {
          ...node,
          prerequisiteKcIds: newPrerequisites
        };
      }
      return node;
    });
    
    return newNodes;
  };

  // Helper function to determine if dragged node is above target
  const isAboveTarget = (nodes: KCTreeNode[], draggedId: string, targetId: string): boolean => {
    const draggedIndex = findNodeIndex(nodes, draggedId);
    const targetIndex = findNodeIndex(nodes, targetId);
    return draggedIndex < targetIndex;
  };

  // Helper function to determine if dragged node is below target
  const isBelowTarget = (nodes: KCTreeNode[], draggedId: string, targetId: string): boolean => {
    const draggedIndex = findNodeIndex(nodes, draggedId);
    const targetIndex = findNodeIndex(nodes, targetId);
    return draggedIndex > targetIndex;
  };

  // Helper function to find node index in flat list
  const findNodeIndex = (nodes: KCTreeNode[], id: string): number => {
    return nodes.findIndex(node => node.id === id);
  };

  // Helper function to find prerequisites for a position
  const findPrerequisitesForPosition = (nodes: KCTreeNode[], draggedId: string, targetId: string): string[] => {
    const targetIndex = findNodeIndex(nodes, targetId);
    const draggedIndex = findNodeIndex(nodes, draggedId);
    
    // Find all KCs that come before the target position
    const prerequisites: string[] = [];
    for (let i = 0; i < targetIndex; i++) {
      if (nodes[i].id !== draggedId) {
        prerequisites.push(nodes[i].id);
      }
    }
    
    return prerequisites;
  };

  // Helper function to get all node IDs from the tree (including nested)
  const getAllNodeIds = (nodes: KCTreeNode[]): string[] => {
    const ids: string[] = [];
    const collectIds = (nodeList: KCTreeNode[]) => {
      nodeList.forEach(node => {
        ids.push(node.id);
        if (node.children && node.children.length > 0) {
          collectIds(node.children);
        }
      });
    };
    collectIds(nodes);
    return ids;
  };

  const renderNode = (node: KCTreeNode, index: number) => {
    const isExpanded = expandedNodes.has(node.id);
    const hasChildren = node.children && node.children.length > 0;
    const indentLevel = node.level * 24; // Increased indent for better visual hierarchy

    console.log(`Rendering node ${node.id}:`, {
      name: node.kc_name,
      level: node.level,
      hasChildren,
      childrenCount: node.children?.length || 0,
      isExpanded,
      indentLevel
    });

    return (
      <DraggableNode 
        key={node.id} 
        node={node} 
        index={index}
        isExpanded={isExpanded}
        hasChildren={hasChildren}
        indentLevel={indentLevel}
        onToggle={toggleNode}
        onEdit={onEdit}
        onView={onView}
        onRemove={onRemove}
        isDragging={isDragging}
        expandedNodes={expandedNodes}
      />
    );
  };

  return (
    <DndContext
      sensors={sensors}
      collisionDetection={closestCenter}
      onDragStart={handleDragStart}
      onDragEnd={handleDragEnd}
    >
      <SortableContext
        items={getAllNodeIds(localNodes)}
        strategy={verticalListSortingStrategy}
      >
        <div className="space-y-1">
          {localNodes.map((node, index) => renderNode(node, index))}
        </div>
      </SortableContext>
    </DndContext>
  );
}

// Utility function to build tree from flat KC list
export function buildKCTree(kcs: any[]): KCTreeNode[] {
  console.log('buildKCTree input:', kcs);
  const kcMap = new Map<string, any>();
  const rootNodes: KCTreeNode[] = [];

  // First pass: create all nodes
  kcs.forEach(kc => {
    kcMap.set(kc.kc_id, {
      ...kc,
      children: [],
      level: 0,
    });
  });

  // Second pass: build parent-child relationships
  kcs.forEach(kc => {
    const node = kcMap.get(kc.kc_id);
    
    if (kc.prerequisiteKcIds && kc.prerequisiteKcIds.length > 0) {
      // This KC has prerequisites, so it's a child
      kc.prerequisiteKcIds.forEach((prereqId: string) => {
        const parentNode = kcMap.get(prereqId);
        if (parentNode) {
          parentNode.children.push(node);
          node.level = Math.max(node.level, parentNode.level + 1);
        }
      });
    } else {
      // This KC has no prerequisites, so it's a root node
      rootNodes.push(node);
    }
  });

  // Sort nodes by level and then by name
  const sortNodes = (nodes: KCTreeNode[]): KCTreeNode[] => {
    return nodes.sort((a, b) => {
      if (a.level !== b.level) return a.level - b.level;
      return a.kc_name.localeCompare(b.kc_name);
    });
  };

  // Sort all levels
  const sortAllLevels = (nodes: KCTreeNode[]): KCTreeNode[] => {
    const sorted = sortNodes(nodes);
    sorted.forEach(node => {
      if (node.children.length > 0) {
        node.children = sortAllLevels(node.children);
      }
    });
    return sorted;
  };

  const result = sortAllLevels(rootNodes);
  console.log('buildKCTree result:', result);
  return result;
}
