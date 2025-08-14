'use client';

import { usePathname } from 'next/navigation';
import Link from 'next/link';
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from "@/components/ui/breadcrumb";
import { Home, Settings } from 'lucide-react';

export function AdminBreadcrumbs() {
  const pathname = usePathname();
  
  // Parse the pathname to create breadcrumb items
  const pathSegments = pathname.split('/').filter(Boolean);
  
  // Remove 'admin' from the beginning since we're already in admin context
  const adminSegments = pathSegments.slice(1);
  
  // Create breadcrumb items
  const breadcrumbItems = [
    {
      label: 'Admin',
      href: '/admin',
      isCurrent: adminSegments.length === 0,
    },
    ...adminSegments.map((segment, index) => {
      const href = `/admin/${adminSegments.slice(0, index + 1).join('/')}`;
      const label = segment
        .split('-')
        .map(word => word.charAt(0).toUpperCase() + word.slice(1))
        .join(' ');
      
      return {
        label,
        href,
        icon: undefined, // No icon for dynamic segments
        isCurrent: index === adminSegments.length - 1,
      };
    }),
  ];

  return (
    <Breadcrumb>
      <BreadcrumbList>
        {breadcrumbItems.map((item, index) => (
          <div key={item.href} className="flex items-center gap-2">
            {index > 0 && <BreadcrumbSeparator />}
            <BreadcrumbItem>
              {item.isCurrent ? (
                <BreadcrumbPage className="flex items-center gap-2">
                  {item.label}
                </BreadcrumbPage>
              ) : (
                <BreadcrumbLink href={item.href} className="flex items-center gap-2">
                  {item.label}
                </BreadcrumbLink>
              )}
            </BreadcrumbItem>
          </div>
        ))}
      </BreadcrumbList>
    </Breadcrumb>
  );
}
