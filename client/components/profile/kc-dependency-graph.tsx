'use client';

import React, { useEffect, useCallback, useMemo, useRef, useState } from 'react';
import {
  ReactFlow,
  useNodesState,
  useEdgesState,
  MiniMap,
  Controls,
  Background,
  Edge,
  Node,
  Position,
  Handle,
  useReactFlow,
  ReactFlowProvider,
  Panel,
  MarkerType,
  BaseEdge,
  EdgeLabelRenderer,
  getBezierPath,
  getStraightPath,
  EdgeProps
} from '@xyflow/react';
import '@xyflow/react/dist/style.css';
import * as d3 from 'd3';
import { useUserKCMasteryGraph } from '@/hooks/useUserKCMasteryGraph';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Slider } from '@/components/ui/slider';
import { Label } from '@/components/ui/label';
import { 
  Loader2, 
  Info, 
  Maximize, 
  Settings, 
  ChevronDown, 
  ChevronUp, 
  Zap,
  CheckCircle2,
  Hourglass,
  Circle,
  HelpCircle
} from 'lucide-react';
import { KCDetailPanel } from './KCDetailPanel';
import { Progress } from '@/components/ui/progress';
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from '@/components/ui/tooltip';

// Custom Box Node Component
const KCNode = ({ data, selected }: { data: any, selected?: boolean }) => {
  const mastery = data.pmastery || 0;
  const masteryPercentage = Math.round(mastery * 100);
  const isNeighbor = data.isNeighbor;
  
  // Style config based on mastery
  let config = {
    label: 'Beginner',
    icon: <Circle className="h-3 w-3" />,
    bg: 'bg-slate-50',
    border: 'border-slate-200',
    text: 'text-slate-600',
    chip: 'bg-slate-200/50 text-slate-600',
    bar: 'bg-slate-200',
    indicator: 'bg-slate-400'
  };
  
  if (mastery >= 0.8) {
    config = {
      label: 'Mastered',
      icon: <CheckCircle2 className="h-3 w-3" />,
      bg: 'bg-emerald-50',
      border: 'border-emerald-200',
      text: 'text-emerald-900',
      chip: 'bg-emerald-100 text-emerald-700',
      bar: 'bg-emerald-100',
      indicator: 'bg-emerald-500'
    };
  } else if (mastery >= 0.6) {
    config = {
      label: 'Proficient',
      icon: <Zap className="h-3 w-3" />,
      bg: 'bg-blue-50',
      border: 'border-blue-200',
      text: 'text-blue-900',
      chip: 'bg-blue-100 text-blue-700',
      bar: 'bg-blue-100',
      indicator: 'bg-blue-500'
    };
  } else if (mastery >= 0.4) {
    config = {
      label: 'Learning',
      icon: <Hourglass className="h-3 w-3" />,
      bg: 'bg-amber-50',
      border: 'border-amber-200',
      text: 'text-amber-900',
      chip: 'bg-amber-100 text-amber-700',
      bar: 'bg-amber-100',
      indicator: 'bg-amber-500'
    };
  }

  const selectionStyle = selected 
    ? 'ring-[6px] ring-blue-500/30 border-blue-500 z-50 shadow-2xl' 
    : isNeighbor 
      ? 'ring-4 ring-blue-400/20 z-40' 
      : 'shadow-sm';

  return (
    <div 
      className={`px-4 py-3 rounded-xl border-2 transition-all duration-300 min-w-[160px] max-w-[200px] relative ${config.bg} ${config.border} ${selectionStyle}`}
      style={{ opacity: data.opacity ?? 1 }}
    >
      {/* Target/Source specific label badges */}
      {data.relationship && (
        <div className={`absolute -top-3 left-1/2 -translate-x-1/2 px-2 py-0.5 rounded-full text-[8px] font-black uppercase tracking-tighter border shadow-sm z-[60] animate-in fade-in zoom-in duration-300 ${
          data.relationship === 'Prerequisite' 
            ? 'bg-red-50 text-red-600 border-red-200' 
            : 'bg-blue-50 text-blue-600 border-blue-200'
        }`}>
          {data.relationship}
        </div>
      )}
      <Handle 
        type="target" 
        position={Position.Top} 
        style={{ top: '50%', left: '50%', transform: 'translate(-50%, -50%)', opacity: 0 }} 
      />
      <Handle 
        type="source" 
        position={Position.Bottom} 
        style={{ top: '50%', left: '50%', transform: 'translate(-50%, -50%)', opacity: 0 }} 
      />
      
      <div className="flex flex-col gap-2.5 pointer-events-none">
        {/* Layer 1: Title */}
        <div className={`text-sm font-bold leading-tight line-clamp-2 ${config.text}`}>
          {data.label}
        </div>

        {/* Layer 2: Status Label Chip */}
        <div className="flex items-center">
          <div className={`flex items-center gap-1.5 px-2 py-0.5 rounded-full text-[10px] font-black uppercase tracking-wider ${config.chip}`}>
            {config.icon}
            {config.label}
          </div>
        </div>

        {/* Layer 3: Progress Bar */}
        <div className="space-y-1">
          <div className={`h-1.5 w-full rounded-full overflow-hidden ${config.bar}`}>
            <div 
              className={`h-full transition-all duration-1000 ${config.indicator}`}
              style={{ width: `${masteryPercentage}%` }}
            />
          </div>
        </div>
      </div>
    </div>
  );
};

// --- Component Setup ---

const KCEdge = ({
  id,
  sourceX,
  sourceY,
  targetX,
  targetY,
  sourcePosition,
  targetPosition,
  style = {},
  markerEnd,
}: EdgeProps) => {
  const [edgePath] = getStraightPath({
    sourceX,
    sourceY,
    targetX,
    targetY,
  });

  return (
    <BaseEdge path={edgePath} markerEnd={markerEnd} style={style} />
  );
};

const nodeTypes = {
  kcNode: KCNode,
};

const edgeTypes = {
  customEdge: KCEdge,
};

function ForceLayoutGraph({ fullscreen = false }: { fullscreen?: boolean }) {
  const { data: graphData, isLoading, error } = useUserKCMasteryGraph();
  const recommendedKCId = graphData?.recommendedKCId || null;
  const [nodes, setNodes, onNodesChange] = useNodesState<Node>([]);
  const [edges, setEdges, onEdgesChange] = useEdgesState<Edge>([]);
  const [selectedNodeId, setSelectedNodeId] = useState<string | null>(null);
  const [focusedNodeId, setFocusedNodeId] = useState<string | null>(null);

  const recommendedNode = useMemo(() => {
    if (!recommendedKCId || nodes.length === 0) return null;
    return nodes.find(n => n.id === recommendedKCId) || null;
  }, [nodes, recommendedKCId]);

  const selectedNode = useMemo(() => {
    return nodes.find(n => n.id === selectedNodeId) || null;
  }, [nodes, selectedNodeId]);
  
  // Physics Playground State
  const [simConfig, setSimConfig] = useState(() => {
    if (typeof window !== 'undefined') {
      const saved = localStorage.getItem('intellics-graph-physics');
      if (saved) {
        try {
          return JSON.parse(saved);
        } catch (e) {
          console.error('Failed to parse graph physics config', e);
        }
      }
    }
    return {
      repulsion: -300,
      gravity: 0.05,
      collision: 100,
      decay: 0.3,
      dragEnergy: 0.05
    };
  });

  // Persist physics settings
  useEffect(() => {
    localStorage.setItem('intellics-graph-physics', JSON.stringify(simConfig));
  }, [simConfig]);
  const [showPhysics, setShowPhysics] = useState(false);
  const { fitView } = useReactFlow();

  // Highlighted edges and nodes
  const { incomingEdges, outgoingEdges, neighborNodeIds } = useMemo(() => {
    if (!selectedNodeId || !graphData) return { 
      incomingEdges: new Set<string>(), 
      outgoingEdges: new Set<string>(), 
      neighborNodeIds: new Set<string>() 
    };
    
    const incoming = new Set<string>();
    const outgoing = new Set<string>();
    const neighbors = new Set<string>();
    
    graphData.edges.forEach(edge => {
      if (edge.target === selectedNodeId) {
        incoming.add(edge.id);
        neighbors.add(edge.source);
      } else if (edge.source === selectedNodeId) {
        outgoing.add(edge.id);
        neighbors.add(edge.target);
      }
    });
    
    return { incomingEdges: incoming, outgoingEdges: outgoing, neighborNodeIds: neighbors };
  }, [selectedNodeId, graphData]);

  // Derived state for nodes and edges with highlighting applied for rendering
  const nodesWithHighlights = useMemo(() => {
    return nodes.map((node) => {
      const isSelected = node.id === selectedNodeId;
      const isFocused = node.id === focusedNodeId;
      const isNeighbor = neighborNodeIds.has(node.id);
      
      let relationship: 'Prerequisite' | 'Next Step' | null = null;
      if (isSelected || isFocused) {
          relationship = null;
      } else if (isNeighbor) {
          // Determine relationship type
          const isPrereq = Array.from(incomingEdges).some(edgeId => {
              const edge = edges.find(e => e.id === edgeId);
              return edge && edge.source === node.id;
          });
          relationship = isPrereq ? 'Prerequisite' : 'Next Step';
      }

      let opacity = 1;
      if (focusedNodeId) {
        opacity = (isFocused || isNeighbor) ? 1 : 0.1;
      } else if (selectedNodeId) {
        opacity = (isSelected || isNeighbor) ? 1 : 0.2;
      }

      return {
        ...node,
        data: {
          ...node.data,
          selected: isSelected || isFocused,
          isNeighbor,
          opacity,
          isFocused,
          relationship
        },
      };
    });
  }, [nodes, edges, selectedNodeId, focusedNodeId, neighborNodeIds, incomingEdges, outgoingEdges]);

  const edgesWithHighlights = useMemo(() => {
    return edges.map((edge) => {
      const isIncoming = incomingEdges.has(edge.id);
      const isOutgoing = outgoingEdges.has(edge.id);
      const isSelectedHighlight = isIncoming || isOutgoing;
      
      let edgeColor = '#cbd5e1';
      let strokeWidth = 2;
      let opacity = 1;
      let label = '';
      let animated = false;

      if (focusedNodeId) {
        if (isSelectedHighlight && (edge.source === focusedNodeId || edge.target === focusedNodeId)) {
          edgeColor = isIncoming ? '#ef4444' : '#3b82f6';
          strokeWidth = 4;
          opacity = 1;
          animated = true;
          label = isIncoming ? 'Prerequisite' : 'Next Step';
        } else {
          opacity = 0.02;
        }
      } else if (selectedNodeId) {
        if (isSelectedHighlight) {
          edgeColor = isIncoming ? '#ef4444' : '#3b82f6';
          strokeWidth = 4;
          opacity = 1;
          animated = true;
          label = isIncoming ? 'Prerequisite' : 'Next Step';
        } else {
          opacity = 0.05;
        }
      }

      return {
        ...edge,
        animated,
        style: {
          ...edge.style,
          stroke: edgeColor,
          strokeWidth,
          opacity,
        },
        markerEnd: {
          ...(edge.markerEnd as any),
          color: edgeColor,
        },
      };
    });
  }, [edges, selectedNodeId, focusedNodeId, incomingEdges, outgoingEdges]);

  // Initialize graph data
  useEffect(() => {
    if (graphData && graphData.nodes.length > 0) {
      const initialNodes: Node[] = graphData.nodes.map((node) => ({
        id: node.id,
        type: 'kcNode',
        data: { ...node },
        position: { x: Math.random() * 100, y: Math.random() * 100 },
      }));

      // CRITICAL FIX: Only include edges where both source and target exist in nodes
      const nodeIds = new Set(graphData.nodes.map(n => n.id));
      const validEdges = graphData.edges.filter(e => nodeIds.has(e.source) && nodeIds.has(e.target));

      const initialEdges: Edge[] = validEdges.map((edge) => ({
        id: edge.id,
        source: edge.source,
        target: edge.target,
        type: 'customEdge',
        animated: false,
        style: { stroke: '#cbd5e1', strokeWidth: 2 },
        markerEnd: {
          type: MarkerType.ArrowClosed,
          color: '#cbd5e1',
          width: 15,
          height: 15
        },
      }));

      setNodes(initialNodes);
      setEdges(initialEdges);
    }
  }, [graphData, setNodes, setEdges]);

  const simulationRef = useRef<d3.Simulation<any, undefined> | null>(null);

  // D3 Force Simulation
  useEffect(() => {
    if (nodes.length === 0) return;

    // Create fresh simulation objects
    const simNodes = nodes.map((node) => ({
      id: node.id,
      x: node.position.x,
      y: node.position.y,
      fx: (node as any).fx,
      fy: (node as any).fy,
    }));

    const simLinks = edges
      .filter(e => simNodes.some(n => n.id === e.source) && simNodes.some(n => n.id === e.target))
      .map((edge) => ({
        source: edge.source,
        target: edge.target,
      }));

    const simulation = d3
      .forceSimulation(simNodes as any)
      .force('charge', d3.forceManyBody().strength(simConfig.repulsion))
      .force('x', d3.forceX(0).strength(simConfig.gravity))
      .force('y', d3.forceY(0).strength(simConfig.gravity))
      .force('center', d3.forceCenter(0, 0))
      .force('collide', d3.forceCollide().radius(simConfig.collision))
      .alphaDecay(simConfig.decay)
      .on('tick', () => {
        setNodes((nds) =>
          nds.map((node) => {
            const simNode = simNodes.find((n) => n.id === node.id);
            if (simNode) {
              return {
                ...node,
                position: { x: simNode.x!, y: simNode.y! },
              };
            }
            return node;
          })
        );
      });

    simulationRef.current = simulation;

    return () => {
      simulation.stop();
    };
  }, [nodes.length, edges.length]);

  // Update simulation forces when simConfig changes
  useEffect(() => {
    if (simulationRef.current) {
      simulationRef.current
        .force('charge', d3.forceManyBody().strength(simConfig.repulsion))
        .force('x', d3.forceX(0).strength(simConfig.gravity))
        .force('y', d3.forceY(0).strength(simConfig.gravity))
        .force('collide', d3.forceCollide().radius(simConfig.collision))
        .alphaDecay(simConfig.decay)
        .alpha(0.3)
        .restart();
    }
  }, [simConfig]);

  // Drag handlers
  const onNodeDragStart = useCallback((_: any, node: Node) => {
    // Select node on drag start to show highlights
    setSelectedNodeId(node.id);
    // Keep alphaTarget low to prevent explosion
    simulationRef.current?.alphaTarget(simConfig.dragEnergy).restart();
  }, [simConfig.dragEnergy]);

  const onNodeDrag = useCallback((_: any, node: Node) => {
    const simNode = simulationRef.current?.nodes().find((n: any) => n.id === node.id);
    if (simNode) {
      simNode.fx = node.position.x;
      simNode.fy = node.position.y;
    }
  }, []);

  const onNodeDragStop = useCallback((_: any, node: Node) => {
    simulationRef.current?.alphaTarget(0);
    const simNode = simulationRef.current?.nodes().find((n: any) => n.id === node.id);
    if (simNode) {
      simNode.fx = null;
      simNode.fy = null;
    }
  }, []);

  const onNodeClick = useCallback((_: any, node: Node) => {
    setSelectedNodeId((current) => (current === node.id ? null : node.id));
    setFocusedNodeId(null);
  }, []);

  const onPaneClick = useCallback(() => {
    setSelectedNodeId(null);
    setFocusedNodeId(null);
  }, []);

  // Auto fit view
  useEffect(() => {
    if (nodes.length > 0) {
      const timer = setTimeout(() => fitView({ padding: 0.3, duration: 800 }), 500);
      return () => clearTimeout(timer);
    }
  }, [nodes.length, fitView]);

  if (isLoading) {
    return (
      <div className="h-[600px] flex items-center justify-center bg-slate-50/50">
        <div className="flex flex-col items-center gap-4">
          <Loader2 className="h-10 w-10 animate-spin text-blue-500" />
          <p className="text-gray-500 font-medium">Building knowledge graph...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="h-[600px] flex items-center justify-center text-red-500 bg-slate-50/50">
        Failed to load knowledge map. Please refresh.
      </div>
    );
  }

  return (
    <div 
      style={{ 
        width: '100%', 
        height: fullscreen ? 'calc(100vh - 65px)' : '600px' 
      }} 
      className="bg-[#f8fafc] relative"
    >
      <ReactFlow
        nodes={nodesWithHighlights}
        edges={edgesWithHighlights}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        onNodeClick={onNodeClick}
        onPaneClick={onPaneClick}
        onNodeDragStart={onNodeDragStart}
        onNodeDrag={onNodeDrag}
        onNodeDragStop={onNodeDragStop}
        nodeTypes={nodeTypes}
        edgeTypes={edgeTypes}
        fitView
        minZoom={0.05}
        maxZoom={2}
      >
        <Controls />
        <Background color="#e2e8f0" gap={20} size={1} />
        

        <Panel position="top-left" className="flex flex-col gap-2 items-start ml-2">
          <div className="flex gap-2">
            <Button variant="secondary" size="sm" onClick={() => fitView({ duration: 400 })} className="shadow-sm bg-white/80 backdrop-blur-sm border-slate-200">
              <Maximize className="h-4 w-4 mr-2" /> Center Graph
            </Button>
            
          </div>

          {/* Settings Control */}
          <div className="bg-white/90 backdrop-blur-md rounded-xl border border-slate-200 shadow-lg overflow-hidden w-64">
            <button 
              onClick={() => setShowPhysics(!showPhysics)}
              className="w-full px-4 py-3 flex items-center justify-between hover:bg-slate-50 transition-colors border-b border-transparent data-[open=true]:border-slate-100"
              data-open={showPhysics}
            >
              <div className="flex items-center gap-2 font-bold text-slate-800">
                <Settings className="h-4 w-4 text-slate-500" />
                Settings
              </div>
              {showPhysics ? <ChevronUp className="h-4 w-4 text-slate-400" /> : <ChevronDown className="h-4 w-4 text-slate-400" />}
            </button>

            {showPhysics && (
              <div className="p-4 space-y-6 animate-in fade-in slide-in-from-top-2 duration-200">
                {/* Repulsion */}
                <div className="space-y-3">
                  <div className="flex justify-between items-center">
                    <Label className="text-xs font-bold text-slate-500 uppercase tracking-wider">Repulsion</Label>
                    <span className="text-xs font-mono font-bold text-blue-600 bg-blue-50 px-1.5 py-0.5 rounded">{simConfig.repulsion}</span>
                  </div>
                  <Slider 
                    value={[Math.abs(simConfig.repulsion)]} 
                    min={0} 
                    max={1000} 
                    step={10} 
                    onValueChange={([val]) => setSimConfig((prev: any) => ({ ...prev, repulsion: -val }))}
                  />
                  <p className="text-[10px] text-slate-400 leading-tight">Controls how much nodes push each other away.</p>
                </div>

                {/* Gravity */}
                <div className="space-y-3">
                  <div className="flex justify-between items-center">
                    <Label className="text-xs font-bold text-slate-500 uppercase tracking-wider">Gravity</Label>
                    <span className="text-xs font-mono font-bold text-blue-600 bg-blue-50 px-1.5 py-0.5 rounded">{simConfig.gravity.toFixed(2)}</span>
                  </div>
                  <Slider 
                    value={[simConfig.gravity]} 
                    min={0} 
                    max={0.2} 
                    step={0.01} 
                    onValueChange={([val]) => setSimConfig((prev: any) => ({ ...prev, gravity: val }))}
                  />
                  <p className="text-[10px] text-slate-400 leading-tight">Strength of the pull toward the map center.</p>
                </div>

                {/* Collision */}
                <div className="space-y-3">
                  <div className="flex justify-between items-center">
                    <Label className="text-xs font-bold text-slate-500 uppercase tracking-wider">Collision</Label>
                    <span className="text-xs font-mono font-bold text-blue-600 bg-blue-50 px-1.5 py-0.5 rounded">{simConfig.collision}</span>
                  </div>
                  <Slider 
                    value={[simConfig.collision]} 
                    min={20} 
                    max={200} 
                    step={5} 
                    onValueChange={([val]) => setSimConfig((prev: any) => ({ ...prev, collision: val }))}
                  />
                  <p className="text-[10px] text-slate-400 leading-tight">Minimum physical space between node centers.</p>
                </div>

                {/* Decay */}
                <div className="space-y-3">
                  <div className="flex justify-between items-center">
                    <Label className="text-xs font-bold text-slate-500 uppercase tracking-wider">Settle Speed</Label>
                    <span className="text-xs font-mono font-bold text-blue-600 bg-blue-50 px-1.5 py-0.5 rounded">{(1 - simConfig.decay).toFixed(2)}</span>
                  </div>
                  <Slider 
                    value={[1 - simConfig.decay]} 
                    min={0.7} 
                    max={0.99} 
                    step={0.01} 
                    onValueChange={([val]) => setSimConfig((prev: any) => ({ ...prev, decay: 1 - val }))}
                  />
                  <p className="text-[10px] text-slate-400 leading-tight">Lower values make the graph more fluid.</p>
                </div>
              </div>
            )}
          </div>
        </Panel>
      </ReactFlow>

      {/* Detail Panel */}
      <KCDetailPanel 
        selectedNode={selectedNode} 
        recommendedNode={recommendedNode}
        onClose={() => {
          setSelectedNodeId(null);
          setFocusedNodeId(null);
        }}
        onSelectRecommended={(id) => {
          setFocusedNodeId(id);
          setSelectedNodeId(id);
        }}
      />
    </div>
  );
}

export function KCDependencyGraph({ fullscreen = false }: { fullscreen?: boolean }) {
  if (fullscreen) {
    return (
      <ReactFlowProvider>
        <ForceLayoutGraph fullscreen={true} />
      </ReactFlowProvider>
    );
  }

  return (
    <Card className="border-0 shadow-xl rounded-2xl overflow-hidden bg-white">
      <CardHeader className="border-b border-slate-50 bg-slate-50/30">
        <CardTitle className="text-2xl font-bold text-slate-900 flex items-center gap-2">
          Knowledge Map
        </CardTitle>
        <CardDescription className="text-slate-500">
          Interactive view of your learned skills and their dependencies
        </CardDescription>
      </CardHeader>
      <CardContent className="p-0">
        <ReactFlowProvider>
          <ForceLayoutGraph fullscreen={false} />
        </ReactFlowProvider>
      </CardContent>
    </Card>
  );
}
