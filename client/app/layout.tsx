import "./globals.css";
import type { Metadata } from "next";
import { DM_Sans, Lora } from "next/font/google";
import { Toaster } from "@/components/ui/sonner";
import Navbar from "@/components/landing/Navbar";
import { AppProvider } from "@/components/providers/app-provider";

const dmSans = DM_Sans({
  subsets: ["latin"],
  variable: "--font-dm-sans",
  display: "swap",
});

const lora = Lora({
  subsets: ["latin"],
  variable: "--font-lora",
  display: "swap",
});

export const metadata: Metadata = {
  title: "Intellics - Intelligent Tutoring System",
  description: "Learn Object-Oriented Programming with adaptive AI tutoring",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={`${dmSans.variable} ${lora.variable} font-sans`}>
        <AppProvider>
          <div className="min-h-screen">
            <Navbar />
            <Toaster richColors />
            <main>{children}</main>
          </div>
        </AppProvider>
      </body>
    </html>
  );
}
