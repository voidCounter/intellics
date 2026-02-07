'use client';

import { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { ProtectedRoute } from '@/components/auth/protected-route';
import { Key, Save, CheckCircle, AlertCircle } from 'lucide-react';
import { toast } from 'sonner';

export default function ApiKeysPage() {
  const [apiKey, setApiKey] = useState('');
  const [isSaved, setIsSaved] = useState(false);

  useEffect(() => {
    // Load existing key from localStorage
    const savedKey = localStorage.getItem('geminiApiKey');
    if (savedKey) {
      setApiKey(savedKey);
      setIsSaved(true);
    }
  }, []);

  const handleSave = () => {
    if (!apiKey.trim()) {
      localStorage.removeItem('geminiApiKey');
      toast.info('API Key removed', {
        description: 'The application will try to use the system default key.'
      });
      setIsSaved(false);
      return;
    }

    localStorage.setItem('geminiApiKey', apiKey.trim());
    setIsSaved(true);
    toast.success('API Key saved', {
      description: 'Your custom Gemini API key will be used for future requests.'
    });
  };

  return (
    <ProtectedRoute>
      <div className="min-h-screen bg-[#f8fafc] py-12">
        <div className="container mx-auto px-4 max-w-2xl">
          <div className="mb-8">
            <h1 className="text-3xl font-bold text-slate-900 mb-2">Settings</h1>
            <p className="text-slate-500">Manage your preferences and API keys.</p>
          </div>

          <div className="grid gap-6">
            <Card className="border-slate-200 shadow-sm">
              <CardHeader>
                <div className="flex items-center gap-2 mb-2">
                  <div className="p-2 bg-blue-50 rounded-lg text-blue-600">
                    <Key className="h-5 w-5" />
                  </div>
                  <CardTitle className="text-xl text-slate-900">Gemini API Key</CardTitle>
                </div>
                <CardDescription className="text-slate-500">
                  Provide your own Google Gemini API key to use for AI features.
                  This key is stored locally in your browser and sent directly to our backend.
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="api-key" className="text-slate-700">API Key</Label>
                    <div className="relative">
                      <Input
                        id="api-key"
                        type="password"
                        placeholder="AIzaSy..."
                        value={apiKey}
                        onChange={(e) => {
                          setApiKey(e.target.value);
                          setIsSaved(false);
                        }}
                        className="pr-10"
                      />
                      {isSaved && apiKey && (
                        <CheckCircle className="absolute right-3 top-1/2 -translate-y-1/2 h-4 w-4 text-emerald-500" />
                      )}
                    </div>
                    <p className="text-xs text-slate-500">
                      Don't have a key? <a href="https://aistudio.google.com/app/apikey" target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">Get one from Google AI Studio</a>.
                    </p>
                  </div>

                  <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 flex items-start gap-3">
                    <AlertCircle className="h-5 w-5 text-amber-600 mt-0.5 flex-shrink-0" />
                    <div className="text-sm text-amber-800">
                      <p className="font-medium mb-1">Important Note</p>
                      <p>
                        Using your own key ensures you don't hit the shared rate limits. 
                        We do not store your key on our servers; it is sent only when needed.
                      </p>
                    </div>
                  </div>

                  <div className="flex justify-end pt-2">
                    <Button onClick={handleSave} className="gap-2">
                      <Save className="h-4 w-4" />
                      Save Key
                    </Button>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </ProtectedRoute>
  );
}
