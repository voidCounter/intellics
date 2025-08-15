import { Skeleton } from '@/components/ui/skeleton';

export function ModuleSkeleton() {
  return (
    <div className="rounded-lg border bg-card p-6 flex flex-col justify-between">
      <div className="flex justify-between items-start mb-4">
        <Skeleton className="h-6 w-3/4" />
      </div>
      <div className="mb-4 min-h-[3rem] space-y-2">
        <Skeleton className="h-4 w-full" />
        <Skeleton className="h-4 w-2/3" />
      </div>
      <div className="flex gap-2">
        <Skeleton className="flex-1 h-9 rounded-md" />
        <Skeleton className="flex-1 h-9 rounded-md" />
      </div>
    </div>
  );
}

export function ModuleSkeletonGrid({ count = 6 }: { count?: number }) {
  return (
    <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
      {Array.from({ length: count }).map((_, index) => (
        <ModuleSkeleton key={index} />
      ))}
    </div>
  );
}
