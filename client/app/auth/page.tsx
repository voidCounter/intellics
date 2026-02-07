"use client";

import { Button } from "@/components/ui/button";
import Image from "next/image";
import { useRouter, useSearchParams } from "next/navigation";
import { Suspense, useEffect } from "react";
import { useAuth } from "@/hooks/useAuth";
import { authApi } from "@/services/api";
import { logger } from "@/lib/utils";

function AuthComponent() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { setUser, isAuthenticated, user } = useAuth();

  useEffect(() => {
    if (isAuthenticated) {
      router.push("/");
      return;
    }

    const token = searchParams.get("token");
    if (token) {
      localStorage.setItem("authToken", token);
      fetchUserInfo(token);
    }
  }, [searchParams, isAuthenticated, router]);

  useEffect(() => {
    if (user && isAuthenticated) {
      router.push("/");
    }
  }, [user, isAuthenticated, router]);

  const fetchUserInfo = async (token: string) => {
    try {
      const response = await authApi.getCurrentUser(token);
      const userData = response.data;
      setUser(userData);
    } catch (error) {
      logger.error("❌ Error fetching user info:", error);
      localStorage.removeItem("authToken");
    }
  };

  const handleLogin = () => {
    router.push("/api/auth/oauth");
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-50 via-white to-slate-50 relative overflow-hidden">
      <div className="order-1 lg:order-2 flex justify-center lg:justify-end">
        <div className="w-full max-w-md">
          <div className="bg-white rounded-2xl shadow-xl border border-slate-200 p-8 md:p-10">
            <div className="mb-8">
              <h2 className="text-2xl font-bold text-slate-900 mb-2">
                Welcome to IntelliCS
              </h2>
              <p className="text-slate-600">
                Sign in to start your personalized learning journey
              </p>
            </div>

            <Button
              size="lg"
              className="w-full h-12 text-base font-medium bg-white hover:bg-slate-50 text-slate-900 border-2 border-slate-300 hover:border-slate-400 shadow-sm transition-all duration-200"
              onClick={handleLogin}
            >
              <svg
                width="20"
                height="20"
                viewBox="0 0 18 18"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
                className="mr-3"
              >
                <path
                  d="M17.64 9.2045C17.64 8.56636 17.5855 7.95182 17.4873 7.35955H9v3.3h4.8445c-.208 1.22182-.84618 2.25636-1.8 2.95818v2.45818h2.90727C16.9836 14.2427 17.64 11.9527 17.64 9.2045z"
                  fill="#4285F4"
                />
                <path
                  d="M9 18c2.43 0 4.47364-.8 5.96455-2.16818l-2.90727-2.45818c-.80727.54273-1.84.86636-3.05727.86636-2.355 0-4.34909-1.58727-5.06-3.73182H0.995455v2.33545C2.48 15.9809 5.5 18 9 18z"
                  fill="#34A853"
                />
                <path
                  d="M3.93909 10.9664c-.18273-.54273-.28636-1.12091-.28636-1.71364s.10363-1.17091.28636-1.71364V5.20364H0.995455A8.99818 8.99818 0 0 0 0 9.25273c0 1.40909.34227 2.74182.995455 3.96636l2.943636-2.25273z"
                  fill="#FBBC05"
                />
                <path
                  d="M9 3.57909c1.32182 0 2.50909.45455 3.44455 1.34364l2.58318-2.58318C13.4709.78409 11.47727 0 9 0 5.5 0 2.48 2.01909.995455 5.20364L3.93909 7.456c.71091-2.14455 2.705-3.73182 5.060-3.73182z"
                  fill="#EA4335"
                />
              </svg>
              Continue with Google
            </Button>

            <div className="mt-6 pt-6 border-t border-slate-200">
              <p className="text-xs text-slate-500 text-center leading-relaxed">
                By continuing, you agree to our{" "}
                <a
                  href="#"
                  className="text-blue-600 hover:text-blue-700 underline"
                >
                  Terms of Service
                </a>{" "}
                and{" "}
                <a
                  href="#"
                  className="text-blue-600 hover:text-blue-700 underline"
                >
                  Privacy Policy
                </a>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default function AuthPage() {
  return (
    <Suspense
      fallback={
        <div className="min-h-screen flex items-center justify-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
        </div>
      }
    >
      <AuthComponent />
    </Suspense>
  );
}
