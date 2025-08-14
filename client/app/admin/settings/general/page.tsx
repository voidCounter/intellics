export default function GeneralSettingsPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">General Settings</h1>
        <p className="text-muted-foreground">
          Configure general application settings and preferences.
        </p>
      </div>
      
      <div className="space-y-6">
        <div className="rounded-lg border">
          <div className="p-6">
            <h3 className="text-lg font-semibold mb-4">Application Settings</h3>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Application Name</h4>
                  <p className="text-sm text-muted-foreground">The name displayed to users</p>
                </div>
                <input
                  type="text"
                  defaultValue="IntelliCS"
                  className="px-3 py-2 border rounded-md w-64"
                />
              </div>
              
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Default Language</h4>
                  <p className="text-sm text-muted-foreground">Primary language for the application</p>
                </div>
                <select className="px-3 py-2 border rounded-md w-64">
                  <option>English</option>
                  <option>Spanish</option>
                  <option>French</option>
                  <option>German</option>
                </select>
              </div>
              
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Time Zone</h4>
                  <p className="text-sm text-muted-foreground">Default time zone for the application</p>
                </div>
                <select className="px-3 py-2 border rounded-md w-64">
                  <option>UTC</option>
                  <option>America/New_York</option>
                  <option>Europe/London</option>
                  <option>Asia/Tokyo</option>
                </select>
              </div>
            </div>
          </div>
        </div>

        <div className="rounded-lg border">
          <div className="p-6">
            <h3 className="text-lg font-semibold mb-4">Security Settings</h3>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Session Timeout</h4>
                  <p className="text-sm text-muted-foreground">Auto-logout after inactivity (minutes)</p>
                </div>
                <input
                  type="number"
                  defaultValue="30"
                  className="px-3 py-2 border rounded-md w-32"
                />
              </div>
              
              <div className="flex items-center justify-between">
                <div>
                  <h4 className="font-medium">Password Policy</h4>
                  <p className="text-sm text-muted-foreground">Minimum password requirements</p>
                </div>
                <select className="px-3 py-2 border rounded-md w-64">
                  <option>Standard (8 chars, mixed case)</option>
                  <option>Strong (12 chars, symbols)</option>
                  <option>Very Strong (16 chars, complex)</option>
                </select>
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
