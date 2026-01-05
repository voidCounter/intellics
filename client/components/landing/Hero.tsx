"use client";

import { motion } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { ArrowRight, MoveRight } from "lucide-react";
import HeroCards from "./HeroCards";
import Link from "next/link";

export default function Hero() {
  return (
    <section className="relative pt-24 pb-12 overflow-hidden">
      <div className="container mx-auto px-6 text-center">
        <motion.h1
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.1, ease: [0.16, 1, 0.3, 1] }}
          className="text-4xl md:text-6xl font-black tracking-tight text-slate-900 mb-6 max-w-3xl mx-auto leading-[1.2] lg:leading-[1.2]"
        >
          Study Smarter With a Tutor That Adapts
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.2, ease: [0.16, 1, 0.3, 1] }}
          className="text-base md:text-xl text-slate-600 max-w-xl mx-auto mb-8 leading-relaxed font-light"
        >
          Get questions, hints, and lessons tailored to what you already
          understand — so you learn faster with less guessing.
        </motion.p>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.3, ease: [0.16, 1, 0.3, 1] }}
        >
          <Link href="/modules">
            <Button className="rounded-md bg-primary text-white hover:bg-slate-800 transition-all px-8 py-6 text-base font-medium shadow-lg shadow-slate-200">
              Start learning
            </Button>
          </Link>
        </motion.div>

        <HeroCards />
      </div>
    </section>
  );
}
