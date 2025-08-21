import type { Metadata } from "next";
import { Nunito } from "next/font/google";
import { ClerkProvider } from '@clerk/nextjs'
import { ThemeProvider } from '@/components/theme-provider'
import { Toaster } from "@/components/ui/sonner";
import { ExitModal } from "@/components/modals/exit-modal";
import { HeartsModal } from "@/components/modals/hearts-modal";
import { PracticeModal } from "@/components/modals/practice-modal";
import "./globals.css";

const font = Nunito({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Lingo",
  description: "Lingo",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <ClerkProvider>
      <html lang="en">
        <body className={font.className}>
          <ThemeProvider
            attribute="class"
            defaultTheme="system"
            enableSystem
            disableTransitionOnChange
          >
            <Toaster />
            <ExitModal />
            <HeartsModal />
            <PracticeModal />
            {children}
          </ThemeProvider>
        </body>
      </html>
    </ClerkProvider>
  );
}
