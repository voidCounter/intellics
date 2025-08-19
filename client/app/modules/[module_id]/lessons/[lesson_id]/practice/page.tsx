import PracticePageClient from './PracticePageClient';
import fs from 'fs';
import path from 'path';

export default function PracticePage() {
  return <PracticePageClient />;
}

export async function generateStaticParams() {
  const modulesPath = path.join(process.cwd(), 'public', 'data', 'modules.json');
  const lessonsPath = path.join(process.cwd(), 'public', 'data', 'lessons.json');
  
  const modules = JSON.parse(fs.readFileSync(modulesPath, 'utf8'));
  const lessons = JSON.parse(fs.readFileSync(lessonsPath, 'utf8'));
  
  const params = [];
  for (const module of modules) {
    for (const lesson of lessons) {
      params.push({
        module_id: module.module_id.toString(),
        lesson_id: lesson.lesson_id.toString()
      });
    }
  }
  
  return params;
}
