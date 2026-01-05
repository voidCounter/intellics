"use client";
import { motion } from "framer-motion";
import Image from "next/image";

const cards = [
  {
    text: "Track your knowledge gaps",
    image: "/images/Chill-Time.svg",
    rotate: -8,
    x: -270,
    z: 10,
    mobileY: 20,
  },
  {
    text: "Learn at your level",
    image: "/images/Fast-Internet.svg",
    rotate: 0,
    x: 0,
    z: 20,
    mobileY: 460,
  },
  {
    text: "Build lasting understanding",
    image: "/images/Loading-Time.svg",
    rotate: 8,
    x: 270,
    z: 10,
    mobileY: 900,
  },
];

export default function HeroCards() {
  return (
    <section className="relative min-h-[1348px] md:min-h-[450px]  md:h-[450px] w-full flex items-start justify-center mb-8 md:mb-12 mt-20 px-4">
      <div className="relative w-full max-w-4xl flex items-center justify-center">
        {cards.map((card, idx) => (
          <motion.div
            key={idx}
            initial={{ opacity: 0, y: 100, rotate: 0, scale: 0.8 }}
            whileInView={{
              opacity: 1,
              y: 0,
              // On mobile: no rotation or x offset, just stack vertically
              // On desktop (md+): apply rotation and x offset
              rotate: window.innerWidth >= 768 ? card.rotate : 0,
              x: window.innerWidth >= 768 ? card.x : 0,
              scale: 1,
              zIndex: card.z,
            }}
            whileHover={{
              scale: 1.05,
              zIndex: 30,
              rotate: 0,
              y: -20,
              transition: { duration: 0.3 },
            }}
            viewport={{ once: true }}
            transition={{
              duration: 1,
              delay: idx * 0.1,
              ease: [0.16, 1, 0.3, 1],
            }}
            className="absolute h-[420px] w-[300px] md:h-[420px] md:w-[300px] rounded-[2.5rem] overflow-hidden border-[8px] border-white shadow-[0_20px_50px_rgba(0,0,0,0.1)] bg-white"
            style={{
              // On mobile: position cards in a column with spacing
              top: window.innerWidth < 768 ? `${card.mobileY}px` : "50%",
              transform:
                window.innerWidth >= 768
                  ? `translateY(-50%) translateX(${card.x}px) rotate(${card.rotate}deg)`
                  : "none",
            }}
          >
            <div className="flex flex-col justify-center items-center gap-16 relative w-full h-full">
              <h3 className="text-2xl font-serif text-center px-4">
                {card.text}
              </h3>
              <Image
                src={card.image}
                width={200}
                height={200}
                alt={`Card ${idx + 1}`}
                priority
              />
            </div>
          </motion.div>
        ))}
      </div>
      {/* Decorative Glow behind the stack */}
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[400px] bg-blue-500/5 blur-[120px] rounded-full -z-10" />
    </section>
  );
}
