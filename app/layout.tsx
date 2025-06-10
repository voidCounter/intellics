import './globals.css';
import type { Metadata } from 'next';
import { IBM_Plex_Sans } from 'next/font/google';
import { Toaster } from "@/components/ui/sonner"
import { Navbar } from '@/components/layout/navbar';
import { SessionProvider } from '@/components/providers/session-provider';

const ibmPlexSans = IBM_Plex_Sans({
  subsets: ['latin'],
  weight: ['400', '500', '600', '700'],
  variable: '--font-ibm-plex-sans',
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
    <html lang="en" className={ibmPlexSans.variable}>
      <body className="font-sans">
        <SessionProvider>
          <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
            <Navbar />
            <Toaster richColors />
            <main>{children}</main>
          </div>
        </SessionProvider>
      </body>
    </html>
  );
}