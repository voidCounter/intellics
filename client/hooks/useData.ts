import { useCallback } from 'react';
import { useContentStore, useProgressStore } from '@/lib/stores';
import { dataApi } from '@/services/api';

export const useData = () => {
  const { 
    modules, 
    lessons, 
    questions, 
    scaffolds, 
    knowledgeComponents,
    setModules, 
    setLessons, 
    setQuestions, 
    setScaffolds,
    setKnowledgeComponents,
  } = useContentStore();

  const {
    kcMasteries,
    userInteractions,
    setKCMasteries,
    setUserInteractions
  } = useProgressStore();

  const loadData = useCallback(async () => {
    try {
      const [modulesData, lessonsData, questionsData, scaffoldsData] = await Promise.all([
        dataApi.getModules(),
        dataApi.getLessons(),
        dataApi.getQuestions(),
        dataApi.getScaffolds()
      ]);

      setModules(modulesData);
      setLessons(lessonsData);
      setQuestions(questionsData);
      setScaffolds(scaffoldsData);
      
      // For now, set empty arrays for KC data since we don't have API endpoints yet
      // TODO: Add API calls when backend endpoints are available
      setKnowledgeComponents([]);
      setKCMasteries([]);
      setUserInteractions([]);
    } catch (error) {
      console.error('Error loading data:', error);
    }
  }, [setModules, setLessons, setQuestions, setScaffolds, setKnowledgeComponents, setKCMasteries, setUserInteractions]);

  return {
    modules,
    lessons,
    questions,
    scaffolds,
    knowledgeComponents,
    kcMasteries,
    userInteractions,
    loadData,
  };
};
