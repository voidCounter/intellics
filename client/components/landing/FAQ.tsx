"use client";

import { motion, AnimatePresence } from "framer-motion";
import { ChevronDown } from "lucide-react";
import { useState } from "react";

const faqs = [
  {
    question: "Who is IntelliCS for?",
    answer:
      "Students and professionals learning computer science who want guided practice, instant feedback, and clear next-step recommendations.",
  },
  {
    question: "Do I need any background experience?",
    answer:
      "No. IntelliCS adapts as you go, so it works whether you’re just starting or reviewing core concepts.",
  },
  {
    question: "How is this different from normal practice sites?",
    answer:
      "Instead of giving you random questions, IntelliCS estimates what you already know and recommends what you should learn next — with hints when you need them.",
  },
];

export default function FAQ() {
  const [openIndex, setOpenIndex] = useState<number | null>(null);

  return (
    <section id="faq" className="bg-transparent py-12">
      <div className="container mx-auto px-6 max-w-4xl">
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8 }}
          className="text-center mb-12"
        >
          <h2 className="text-4xl md:text-5xl font-extrabold text-slate-900 mb-2 tracking-tight leading-tight">
            Questions
          </h2>
          <p className="text-base text-slate-500 font-light max-w-xl mx-auto">
            Everything you need to know about IntelliCS.
          </p>
        </motion.div>

        <div className="space-y-3">
          {faqs.map((faq, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 6 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6, delay: idx * 0.06 }}
              className="rounded-lg border border-slate-100 bg-white/50 shadow-sm"
            >
              <button
                onClick={() => setOpenIndex(openIndex === idx ? null : idx)}
                aria-expanded={openIndex === idx}
                aria-controls={`faq-answer-${idx}`}
                className="w-full flex items-center justify-between py-4 px-4 text-left group focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-500 rounded-md hover:bg-slate-50 transition-colors"
              >
                <span className="text-lg md:text-xl font-semibold text-slate-900 tracking-tight transition-colors group-hover:text-sky-600">
                  {faq.question}
                </span>
                <motion.div
                  animate={{ rotate: openIndex === idx ? 180 : 0 }}
                  className="text-slate-400 transition-transform"
                >
                  <ChevronDown size={20} />
                </motion.div>
              </button>

              <AnimatePresence>
                {openIndex === idx && (
                  <motion.div
                    initial={{ height: 0, opacity: 0 }}
                    animate={{ height: "auto", opacity: 1 }}
                    exit={{ height: 0, opacity: 0 }}
                    transition={{ duration: 0.32, ease: [0.16, 1, 0.3, 1] }}
                    className="overflow-hidden"
                  >
                    <div
                      id={`faq-answer-${idx}`}
                      className="px-4 pb-4 pt-2 text-base text-slate-600 font-normal leading-relaxed max-w-2xl"
                    >
                      {faq.answer}
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
