import ModulePageClient from './ModulePageClient';
import fs from 'fs';
import path from 'path';

export default function ModulePage() {
  return <ModulePageClient />;
}

export async function generateStaticParams() {
  const modulesPath = path.join(process.cwd(), 'public', 'data', 'modules.json');
  const modules = JSON.parse(fs.readFileSync(modulesPath, 'utf8'));
  return modules.map((module: { module_id: number }) => ({ module_id: module.module_id.toString() }));
}
