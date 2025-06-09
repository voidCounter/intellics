import LessonPageClient from './LessonPageClient';
import fs from 'fs';
import path from 'path';

export default function LessonPage() {
  return <LessonPageClient />;
}

export async function generateStaticParams() {
  const lessonsPath = path.join(process.cwd(), 'public', 'data', 'lessons.json');
  const lessons = JSON.parse(fs.readFileSync(lessonsPath, 'utf8'));
  return lessons.map((lesson: { lesson_id: number }) => ({ lesson_id: lesson.lesson_id.toString() }));
}