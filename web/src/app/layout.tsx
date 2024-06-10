import type { Metadata } from "next";
import { Montserrat, Roboto } from "next/font/google";
import "./globals.css";

const montserrat = Montserrat({
  subsets: ["latin"],
  weight: ["500"],
  variable: "--font-montserrat",
});

const roboto = Roboto({
  subsets: ["latin"],
  weight: ["300", "400"],
  variable: "--font-roboto",
});

export const metadata: Metadata = {
  title: "Rock Paper Scissors Game",
  description: "Rock Paper Scissors Game",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${montserrat.variable} font-montserrat ${roboto.variable} font-roboto`}
      >
        {children}
      </body>
    </html>
  );
}
