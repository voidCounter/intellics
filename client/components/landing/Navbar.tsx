"use client";

import { motion } from "framer-motion";
import { Button } from "@/components/ui/button";
import Link from "next/link";

export default function Navbar() {
  return (
    <motion.header
      initial={{ y: -100 }}
      animate={{ y: 0 }}
      className="fixed top-0 left-0 right-0 z-50 flex justify-center p-6"
    >
      <nav className="flex items-center justify-between w-full max-w-3xl px-4 pl-6 py-3 bg-white/70 backdrop-blur-md rounded-full border border-white/20 shadow-lg shadow-black/5">
        <Link
          href="/"
          className="text-xl font-bold tracking-tight text-slate-900"
        >
          IntelliCS<span className="text-blue-600">.</span>
        </Link>

        <div className="hidden md:flex items-center gap-8 text-sm font-medium text-slate-600">
          <Link
            href="#features"
            className="hover:text-slate-900 transition-colors"
          >
            Features
          </Link>
          {/*<Link href="#how-it-works" className="hover:text-slate-900 transition-colors">How it works</Link>*/}
          <Link href="#faq" className="hover:text-slate-900 transition-colors">
            FAQ
          </Link>
          {/*<Link href="#pricing" className="hover:text-slate-900 transition-colors">Pricing</Link>*/}
        </div>

        <Button
          className="rounded-full border text-foreground transition-all px-6"
          variant={"outline"}
        >
          Try it for free →
        </Button>
      </nav>
    </motion.header>
  );
}
