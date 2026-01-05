"use client";

import Link from "next/link";

export default function Footer() {
  return (
    <footer className="py-24 bg-transparent">
      <div className="container mx-auto px-6">
        <div className="flex flex-col md:flex-row justify-between items-center gap-12 border-t border-slate-100/50 pt-16">
          <div className="flex flex-col gap-4 items-center md:items-start">
            <span className="text-2xl font-bold tracking-tighter text-slate-900">
              IntelliCS<span className="text-blue-600">.</span>
            </span>
            <p className="text-sm text-slate-400 font-medium">© 2026 IntelliCS. Crafted with precision.</p>
          </div>

          <div className="flex items-center gap-12 text-sm font-semibold text-slate-400 tracking-tight">
            <Link href="#" className="hover:text-slate-900 transition-colors uppercase tracking-[0.1em]">Privacy</Link>
            <Link href="#" className="hover:text-slate-900 transition-colors uppercase tracking-[0.1em]">Terms</Link>
            <Link href="#" className="hover:text-slate-900 transition-colors uppercase tracking-[0.1em]">Contact</Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
