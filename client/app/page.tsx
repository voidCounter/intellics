import Hero from "@/components/landing/Hero";
import HeroCards from "@/components/landing/HeroCards";
import Stats from "@/components/landing/Stats";
import Features from "@/components/landing/Features";
import FAQ from "@/components/landing/FAQ";
import Footer from "@/components/landing/Footer";
import Navbar from "@/components/landing/Navbar";

export default function LandingPage() {
  return (
    <div className="min-h-screen w-full bg-[#f8fafc] relative selection:bg-blue-100 selection:text-blue-900 overflow-x-hidden">
      {/* Improved Persistent Grid Background - No fading mask to ensure visibility everywhere */}
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

      <div className="relative z-10 flex flex-col">
        <main className="py-24">
          <Navbar />
          <Hero />
          <Stats />
          <Features />
          <FAQ />
        </main>
        <Footer />
      </div>
    </div>
  );
}
