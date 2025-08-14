"use client"

import * as React from "react"
import {
  AudioWaveform,
  BookOpen,
  Bot,
  Brain,
  Command,
  Frame,
  GalleryVerticalEnd,
  Map,
  PieChart,
  Settings2,
  SquareTerminal,
  User2,
} from "lucide-react"

import { NavMain } from "@/components/admin/nav-main"
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarHeader,
  SidebarRail,
} from "@/components/ui/sidebar"

// This is sample data.
const data = {
  navMain: [
    {
      title: "Dashboard",
      url: "/admin/dashboard",
      icon: SquareTerminal,
      isActive: true,
      items: [
        {
          title: "Overview",
          url: "/admin/dashboard",
        },
        {
          title: "Progress",
          url: "/admin/dashboard/progress",
        },
        {
          title: "Performance Trends",
          url: "/admin/dashboard/performance",
        },
        {
          title: "User Engagement",
          url: "/admin/dashboard/user-engagement",
        },
        {
          title: "Recommendations",
          url: "/admin/dashboard/recommendations",
        }
      ],
    },
    {
      title: "Users",
      url: "/admin/users",
      icon: User2,
    },
    {
      title: "Knowledge Components",
      url: "/admin/knowledge-components",
      icon: Brain,
    },
    {
      title: "Modules",
      url: "/admin/modules",
      icon: BookOpen,
    },
    {
      title: "Settings",
      url: "/admin/settings",
      icon: Settings2,
      items: [
        {
          title: "General",
          url: "/admin/settings/general",
        },
        {
          title: "Models",
          url: "/admin/settings/models",
        },
      ],
    },
  ],
}

export function AdminSidebar({ ...props }: React.ComponentProps<typeof Sidebar>) {
  return (
    <Sidebar className="pt-16" collapsible="icon" {...props}>
      <SidebarContent>
        <NavMain items={data.navMain} />
      </SidebarContent>
      <SidebarRail />
    </Sidebar>
  )
}
