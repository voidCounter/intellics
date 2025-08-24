import './globals.css';
import type { Metadata } from 'next';
import { DM_Sans } from 'next/font/google';
import { Toaster } from "@/components/ui/sonner"
import { Navbar } from '@/components/layout/navbar';
import { AppProvider } from '@/components/providers/app-provider';

const dmSans = DM_Sans({ 
  subsets: ['latin'],
  variable: '--font-dm-sans',
  display: 'swap',
});

export const metadata: Metadata = {
  title: 'Intellics - Intelligent Tutoring System',
  description: 'Learn Object-Oriented Programming with adaptive AI tutoring',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={`${dmSans.variable} font-sans`}>
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