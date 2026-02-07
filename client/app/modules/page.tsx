"use client";

import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { BookOpen, Search, Target, ArrowRight, Zap } from "lucide-react";
import Link from "next/link";
import { useHomeData } from "@/hooks/useHomeData";
import { ProtectedRoute } from "@/components/auth/protected-route";
import { motion } from "framer-motion";

export default function ModulesPage() {
  const { modules, isLoading, error, loadModules } = useHomeData();
  const [searchQuery, setSearchQuery] = useState("");

  useEffect(() => {
    loadModules();
  }, [loadModules]);

  // Filter modules based on search query
  const filteredModules = modules.filter(
    (module) =>
      module.module_name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      module.description.toLowerCase().includes(searchQuery.toLowerCase()),
  );

  if (isLoading) {
    return (
      <ProtectedRoute>
        <div className="min-h-screen bg-[#f8fafc] relative overflow-hidden">
          {/* Grid Background */}
          <div
            className="fixed inset-0 z-0 pointer-events-none opacity-[0.4]"
            style={{
              backgroundImage: `
                linear-gradient(to right, #e2e8f0 1px, transparent 1px),
                linear-gradient(to bottom, #e2e8f0 1px, transparent 1px)
              `,
              backgroundSize: "24px 24px",
              maskImage:
                "radial-gradient(circle at 50% 50%, black, transparent)",
              WebkitMaskImage:
                "radial-gradient(circle at 50% 50%, black, transparent)",
            }}
          />

          <div className="relative z-10 container mx-auto px-6 py-12">
            <div className="max-w-2xl mx-auto text-center mb-10 space-y-3">
              <div className="h-8 bg-slate-200 rounded-lg w-1/2 mx-auto animate-pulse" />
              <div className="h-4 bg-slate-200 rounded-lg w-1/3 mx-auto animate-pulse" />
            </div>

            <div className="max-w-md mx-auto mb-10">
              <div className="h-10 bg-slate-200 rounded-full w-full animate-pulse" />
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
              {[...Array(6)].map((_, index) => (
                <div
                  key={index}
                  className="h-[200px] bg-white rounded-2xl border border-slate-100 shadow-sm animate-pulse"
                />
              ))}
            </div>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  if (error) {
    return (
      <ProtectedRoute>
        <div className="min-h-screen bg-[#f8fafc] flex items-center justify-center relative overflow-hidden">
          {/* Grid Background */}
          <div
            className="fixed inset-0 z-0 pointer-events-none opacity-[0.4]"
            style={{
              backgroundImage: `
                linear-gradient(to right, #e2e8f0 1px, transparent 1px),
                linear-gradient(to bottom, #e2e8f0 1px, transparent 1px)
              `,
              backgroundSize: "24px 24px",
              maskImage:
                "radial-gradient(circle at 50% 50%, black, transparent)",
              WebkitMaskImage:
                "radial-gradient(circle at 50% 50%, black, transparent)",
            }}
          />
          <div className="text-center relative z-10">
            <h2 className="text-xl font-bold text-slate-900 mb-2">
              Unable to load modules
            </h2>
            <p className="text-slate-500 mb-6 text-sm">{error}</p>
            <Button onClick={() => loadModules()} variant="outline" size="sm">
              Try Again
            </Button>
          </div>
        </div>
      </ProtectedRoute>
    );
  }

  return (
    <ProtectedRoute>
      <div className="min-h-screen bg-[#f8fafc] relative overflow-hidden selection:bg-blue-100 selection:text-blue-900">
        {/* Persistent Grid Background */}
        <div
          className="fixed inset-0 z-0 pointer-events-none opacity-[0.65]"
          style={{
            backgroundImage: `
                linear-gradient(to right, #e2e8f0 1.25px, transparent 1.25px),
                linear-gradient(to bottom, #e2e8f0 1.25px, transparent 1.25px)
              `,
            backgroundSize: "24px 36px",
            maskImage:
              "radial-gradient(circle at 50% 30%, black 10%, transparent 80%)",
            WebkitMaskImage:
              "radial-gradient(circle at 50% 30%, black 10%, transparent 80%)",
          }}
        />

        <div className="relative z-10 container mx-auto px-6 py-12">
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, ease: [0.16, 1, 0.3, 1] }}
            className="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-10"
          >
            <div>
              <h1 className="text-3xl font-bold tracking-tight text-slate-900 mb-2">
                Modules
              </h1>
            </div>

            <div className="w-full md:w-auto min-w-[300px]">
              <div className="relative group">
                <div className="relative bg-white rounded-full shadow-sm border border-slate-200 flex items-center p-1.5 transition-all duration-300 focus-within:ring-2 focus-within:ring-blue-100 focus-within:border-blue-300">
                  <Search className="ml-3 h-4 w-4 text-slate-400" />
                  <input
                    type="text"
                    placeholder="Search modules..."
                    className="w-full bg-transparent border-none focus:ring-0 text-sm text-slate-900 placeholder:text-slate-400 px-3 py-1"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                  />
                </div>
              </div>
            </div>
          </motion.div>

          {filteredModules.length === 0 ? (
            <div className="text-center py-16 bg-white/50 rounded-3xl border border-dashed border-slate-200">
              <div className="inline-flex justify-center items-center w-12 h-12 rounded-full bg-slate-100 mb-3">
                <Search className="h-5 w-5 text-slate-400" />
              </div>
              <h3 className="text-lg font-medium text-slate-900 mb-1">
                No modules found
              </h3>
              <p className="text-sm text-slate-500">
                {searchQuery
                  ? `No matches for "${searchQuery}"`
                  : "No modules available."}
              </p>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
              {filteredModules.map((module, idx) => (
                <motion.div
                  key={module.module_id}
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.4, delay: idx * 0.05 }}
                >
                  <Link
                    href={`/modules/${module.module_id}`}
                    className="block h-full"
                  >
                    <Card className="h-full bg-white border-slate-200 shadow-[0_1px_3px_rgba(0,0,0,0.05)] hover:shadow-[0_8px_20px_rgba(0,0,0,0.08)] hover:-translate-y-0.5 hover:border-blue-200 transition-all duration-300 rounded-2xl overflow-hidden group flex flex-col">
                      <CardHeader className="p-5 pb-3">
                        <div className="flex justify-between items-start mb-4">
                          <div className="w-10 h-10 rounded-xl bg-blue-50 flex items-center justify-center text-blue-600 group-hover:bg-blue-600 group-hover:text-white transition-colors duration-300">
                            <BookOpen className="h-5 w-5" />
                          </div>
                        </div>

                        <CardTitle className="text-lg font-bold text-slate-900 leading-tight mb-2 group-hover:text-blue-700 transition-colors">
                          {module.module_name}
                        </CardTitle>

                        <CardDescription className="text-slate-500 text-base leading-relaxed line-clamp-2">
                          {module.description}
                        </CardDescription>
                      </CardHeader>

                      <CardContent className="p-5 pt-0 mt-auto">
                        <div className="flex items-center justify-between pt-4 mt-2 border-t border-slate-50">
                          <span className="text-xs font-semibold text-blue-600 flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-all transform translate-x-2 group-hover:translate-x-0">
                            Start
                            <ArrowRight className="h-3.5 w-3.5" />
                          </span>
                        </div>
                      </CardContent>
                    </Card>
                  </Link>
                </motion.div>
              ))}
            </div>
          )}
        </div>
      </div>
    </ProtectedRoute>
  );
}
