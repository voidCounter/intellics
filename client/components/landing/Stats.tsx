"use client";

import { motion } from "framer-motion";

const stats = [
  { label: "Knowledge Components", value: "51+" },
  { label: "Interactive Lessons", value: "21+" },
  { label: "Practice Questions", value: "237+" },
];

export default function Stats() {
  return (
    <section className="py-24 bg-transparent border-y border-slate-100/50">
      <div className="container mx-auto px-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-16 text-center">
          {stats.map((stat, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 10 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.8, delay: idx * 0.1, ease: [0.16, 1, 0.3, 1] }}
              className="flex flex-col gap-3"
            >
              <div className="text-5xl font-bold text-slate-900 tracking-tighter">{stat.value}</div>
              <div className="text-xs font-semibold text-slate-400 uppercase tracking-[0.2em]">{stat.label}</div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
