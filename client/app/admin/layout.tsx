import { AdminSidebar } from "@/components/admin/admin-sidebar";
import {
  SidebarInset,
  SidebarProvider,
  SidebarTrigger,
} from "@/components/ui/sidebar";
import { ProtectedAdminRoute } from "@/components/auth/protected-admin-route";
import { AdminBreadcrumbs } from "@/components/admin/admin-breadcrumbs";

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <ProtectedAdminRoute>
      <SidebarProvider>
        <div className="flex h-screen max-w-7xl w-full">
          <AdminSidebar />
            <SidebarInset className="bg-transparent">
              <header>
                <div className="flex gap-4 items-center p-4">
                  <SidebarTrigger className="-ml-1" />
                  <AdminBreadcrumbs />
                </div>
              </header>
              <main className="flex-1 overflow-y-auto p-6">{children}</main>
            </SidebarInset>
          </div>
      </SidebarProvider>
    </ProtectedAdminRoute>
  );
}
