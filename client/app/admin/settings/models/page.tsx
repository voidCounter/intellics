export default function ModelsSettingsPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">AI Model Settings</h1>
        <p className="text-muted-foreground">
          Configure AI models, parameters, and learning algorithms.
        </p>
      </div>
      
      <div className="space-y-6">
        <div className="rounded-lg border">
          <div className="p-6">
            <h3 className="text-lg font-semibold mb-4">Model Configuration</h3>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Primary AI Model</h4>
                  <p className="text-sm text-muted-foreground">Main model for content generation and recommendations</p>
                </div>
                <select className="px-3 py-2 border rounded-md w-64">
                  <option>GPT-4</option>
                  <option>Claude-3</option>
                  <option>Gemini Pro</option>
                  <option>Custom Model</option>
                </select>
              </div>
              
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Temperature</h4>
                  <p className="text-sm text-muted-foreground">Creativity vs consistency (0.0 - 1.0)</p>
                </div>
                <input
                  type="range"
                  min="0"
                  max="1"
                  step="0.1"
                  defaultValue="0.7"
                  className="w-64"
                />
                <span className="text-sm font-medium w-16">0.7</span>
              </div>
              
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Max Tokens</h4>
                  <p className="text-sm text-muted-foreground">Maximum response length</p>
                </div>
                <input
                  type="number"
                  defaultValue="1000"
                  className="px-3 py-2 border rounded-md w-32"
                />
              </div>
            </div>
          </div>
        </div>

        <div className="rounded-lg border">
          <div className="p-6">
            <h3 className="text-lg font-semibold mb-4">Learning Algorithm Settings</h3>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Adaptive Learning Rate</h4>
                  <p className="text-sm text-muted-foreground">How quickly the system adapts to user behavior</p>
                </div>
                <select className="px-3 py-2 border rounded-md w-64">
                  <option>Conservative (0.1)</option>
                  <option>Balanced (0.5)</option>
                  <option>Aggressive (0.9)</option>
                </select>
              </div>
              
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Personalization Weight</h4>
                  <p className="text-sm text-muted-foreground">Balance between personal and general recommendations</p>
                </div>
                <input
                  type="range"
                  min="0"
                  max="1"
                  step="0.1"
                  defaultValue="0.6"
                  className="w-64"
                />
                <span className="text-sm font-medium w-16">0.6</span>
              </div>
            </div>
          </div>
        </div>

        <div className="rounded-lg border">
          <div className="p-6">
            <h3 className="text-lg font-semibold mb-4">Model Performance</h3>
            <div className="grid gap-4 md:grid-cols-3">
              <div className="text-center p-4 bg-muted rounded-lg">
                <div className="text-2xl font-bold text-blue-600">94.2%</div>
                <div className="text-sm text-muted-foreground">Accuracy</div>
              </div>
              <div className="text-center p-4 bg-muted rounded-lg">
                <div className="text-2xl font-bold text-green-600">127ms</div>
                <div className="text-sm text-muted-foreground">Response Time</div>
              </div>
              <div className="text-center p-4 bg-muted rounded-lg">
                <div className="text-2xl font-bold text-purple-600">1.2M</div>
                <div className="text-sm text-muted-foreground">Training Samples</div>
              </div>
            </div>
          </div>
        </div>

        <div className="flex justify-end">
          <button className="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">
            Save Changes
          </button>
        </div>
      </div>
    </div>
  );
}
