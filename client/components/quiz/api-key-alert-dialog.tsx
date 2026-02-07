'use client';

import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { useRouter } from "next/navigation";
import { Key } from "lucide-react";

interface ApiKeyAlertDialogProps {
  isOpen: boolean;
  onOpenChange: (isOpen: boolean) => void;
}

export function ApiKeyAlertDialog({ isOpen, onOpenChange }: ApiKeyAlertDialogProps) {
  const router = useRouter();

  const handleGoToSettings = () => {
    router.push("/settings/api-keys");
    onOpenChange(false);
  };

  return (
    <AlertDialog open={isOpen} onOpenChange={onOpenChange}>
      <AlertDialogContent className="max-w-md">
        <AlertDialogHeader>
          <div className="mx-auto w-12 h-12 bg-blue-50 rounded-full flex items-center justify-center mb-4 text-blue-600">
            <Key className="h-6 w-6" />
          </div>
          <AlertDialogTitle className="text-center text-xl">Gemini API Key Required</AlertDialogTitle>
          <AlertDialogDescription className="text-center text-slate-600">
            To evaluate your written answers, you need to provide your own Gemini API key. 
            This ensures better performance and avoids shared rate limits.
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter className="flex flex-col sm:flex-row gap-2 sm:gap-0 mt-4">
          <AlertDialogCancel className="sm:flex-1">Later</AlertDialogCancel>
          <AlertDialogAction 
            onClick={handleGoToSettings}
            className="sm:flex-1 bg-blue-600 hover:bg-blue-700"
          >
            Go to Settings
          </AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  );
}
