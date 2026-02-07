import { useMemo } from 'react';
import { useUserKCMastery } from './useUserKCMastery';
import { useKnowledgeComponents } from './useKnowledgeComponent';
import { KCMastery, KnowledgeComponentWithRelationships } from '@/types/api';

export interface KCGraphNode extends KCMastery {
  id: string; 
  label: string;
}

export interface KCGraphEdge {
  id: string;
  source: string;
  target: string;
  label?: string;
}

export interface KCGraphData {
  nodes: KCGraphNode[];
  edges: KCGraphEdge[];
}

export function useUserKCMasteryGraph() {
  const { data: userMastery, isLoading: isMasteryLoading, error: masteryError } = useUserKCMastery();
  const { data: allKCs, isLoading: isKCsLoading, error: kcsError } = useKnowledgeComponents();

  const isLoading = isMasteryLoading || isKCsLoading;
  const error = masteryError || kcsError;

  const graphData = useMemo(() => {
    const data: KCGraphData = { nodes: [], edges: [] };

    if (userMastery && allKCs) {
      // Map existing mastery data for quick lookup
      const masteryMap = new Map(userMastery.map(m => [m.kcId, m]));

      // Create Nodes
      // We use all KCs so the graph is complete even if user hasn't started some KCs
      data.nodes = (allKCs as KnowledgeComponentWithRelationships[]).map((kc) => {
        const mastery = masteryMap.get(kc.kc_id);
        return {
          id: kc.kc_id,
          label: kc.kc_name,
          kcId: kc.kc_id,
          kcName: kc.kc_name,
          kcDescription: kc.description,
          pmastery: mastery ? mastery.pmastery : 0, 
          pguess: mastery ? mastery.pguess : 0.2,
          pslip: mastery ? mastery.pslip : 0.1,
          ptransit: mastery ? mastery.ptransit : 0.2,
          updatedAt: mastery ? mastery.updatedAt : (kc.updated_at || new Date().toISOString()),
          linkedLessons: kc.linkedLessons || [],
          linkedQuestions: kc.linkedQuestions || [],
          linkedModules: kc.linkedModules || []
        };
      });

      // Create Edges
      (allKCs as KnowledgeComponentWithRelationships[]).forEach((kc) => {
        if (kc.prerequisites) {
          kc.prerequisites.forEach((prereq) => {
            // Avoid duplicate edges if multiple modules define same prerequisite
            const edgeId = `${prereq.kc_id}-${kc.kc_id}`;
            if (!data.edges.some(e => e.id === edgeId)) {
              data.edges.push({
                id: edgeId,
                source: prereq.kc_id,
                target: kc.kc_id,
                label: prereq.rationale
              });
            }
          });
        }
      });
    }
    // --- Recommendation Engine ---
    let recommendedKCId: string | null = null;
    if (data.nodes.length > 0) {
      // 1. Find all candidates (mastery < 80%)
      const candidates = data.nodes.filter(node => node.pmastery < 0.8);
      
      // 2. Filter for "Ready" candidates (all prerequisites >= 60%)
      const readyCandidates = candidates.filter(node => {
        const prereqs = data.edges.filter(e => e.target === node.id);
        if (prereqs.length === 0) return true; // No prereqs? Always ready.
        
        return prereqs.every(edge => {
          const prereqNode = data.nodes.find(n => n.id === edge.source);
          return prereqNode ? prereqNode.pmastery >= 0.6 : true;
        });
      });

      // 3. Pick the best one (lowest mastery among ready candidates to build foundation)
      if (readyCandidates.length > 0) {
        const sorted = [...readyCandidates].sort((a, b) => a.pmastery - b.pmastery);
        recommendedKCId = sorted[0].id;
      } else if (candidates.length > 0) {
        // Fallback: just pick the one with highest mastery among all candidates 
        // (the one closest to breaking through)
        const sorted = [...candidates].sort((a, b) => b.pmastery - a.pmastery);
        recommendedKCId = sorted[0].id;
      }
    }

    return { ...data, recommendedKCId };
  }, [userMastery, allKCs]);

  return { data: graphData, isLoading, error };
}
