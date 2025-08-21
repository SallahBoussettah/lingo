import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function absoluteUrl(path: string) {
  const baseUrl = process.env.NEXT_PUBLIC_APP_URL;
  
  if (!baseUrl) {
    throw new Error("NEXT_PUBLIC_APP_URL environment variable is not set");
  }
  
  // Ensure the base URL has a proper scheme
  const url = baseUrl.startsWith('http') ? baseUrl : `https://${baseUrl}`;
  
  return `${url}${path}`;
};
