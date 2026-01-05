"use client";

import { motion } from "framer-motion";

const features = [
  {
    title: "Learn Faster With Adaptive Practice",
    description:
      "You get questions matched to your real skill level, so you’re never stuck on work that’s too hard — or bored with work that’s too easy.",
  },
  {
    title: "Get Unstuck With Step-By-Step Help",
    description:
      "Hints, worked examples, and clear explanations guide you through problems instead of leaving you guessing why you were wrong.",
  },
  {
    title: "Always Know What To Study Next",
    description:
      "Your progress is tracked at a fine-grained level, so IntelliCS can recommend the next lesson or question based on what you’ve mastered.",
  },
];

export default function Features() {
  return (
    <section id="features" className="py-40 bg-transparent">
      <div className="container mx-auto px-6">
        <div className="flex flex-col md:flex-row gap-24 items-start">
          <div className="md:w-1/2 md:sticky md:top-40">
            <motion.h2
              initial={{ opacity: 0, x: -10 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.8, ease: [0.16, 1, 0.3, 1] }}
              className="text-5xl md:text-7xl font-bold tracking-tighter text-slate-900 leading-[0.95] mb-8"
            >
              Adaptive Learning <br />
              Built Around
              <span className="font-serif italic font-light text-slate-400">
                Your Progress
              </span>{" "}
              <br />
            </motion.h2>
          </div>

          <div className="md:w-1/2">
            <motion.p
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.8, ease: [0.16, 1, 0.3, 1] }}
              className="text-xl text-slate-500 mb-16 leading-relaxed font-light"
            >
              Built for students and professionals who want to master anything
              through guided, personalized practice.
            </motion.p>

            <div className="grid gap-12">
              {features.map((feature, idx) => (
                <motion.div
                  key={idx}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{
                    duration: 0.8,
                    delay: idx * 0.2,
                    ease: [0.16, 1, 0.3, 1],
                  }}
                  className="group"
                >
                  <div className="flex items-start gap-6 border-l border-slate-100 pl-8 transition-colors group-hover:border-blue-500">
                    <div>
                      <h3 className="text-2xl font-bold text-slate-900 mb-3 tracking-tight">
                        {feature.title}
                      </h3>
                      <p className="text-slate-500 leading-relaxed font-light text-lg">
                        {feature.description}
                      </p>
                    </div>
                  </div>
                </motion.div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
