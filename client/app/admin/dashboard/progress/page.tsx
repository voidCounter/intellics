export default function ProgressPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">Progress Dashboard</h1>
        <p className="text-muted-foreground">
          Track learning progress and performance metrics across all users.
        </p>
      </div>
      
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <div className="rounded-lg border bg-card p-6">
          <h3 className="font-semibold">Total Users</h3>
          <p className="text-2xl font-bold">1,247</p>
          <p className="text-xs text-muted-foreground">+12% from last month</p>
        </div>
        <div className="rounded-lg border bg-card p-6">
          <h3 className="font-semibold">Active Learners</h3>
          <p className="text-2xl font-bold">892</p>
          <p className="text-xs text-muted-foreground">+8% from last month</p>
        </div>
        <div className="rounded-lg border bg-card p-6">
          <h3 className="font-semibold">Avg. Completion Rate</h3>
          <p className="text-2xl font-bold">73%</p>
          <p className="text-xs text-muted-foreground">+5% from last month</p>
        </div>
        <div className="rounded-lg border bg-card p-6">
          <h3 className="font-semibold">Total Sessions</h3>
          <p className="text-2xl font-bold">15,892</p>
          <p className="text-xs text-muted-foreground">+23% from last month</p>
        </div>
      </div>

      <div className="rounded-lg border">
        <div className="p-6">
          <h3 className="text-lg font-semibold mb-4">Progress Trends</h3>
          <div className="h-64 bg-muted rounded flex items-center justify-center">
            <p className="text-muted-foreground">Progress chart will be implemented here</p>
          </div>
        </div>
      </div>
    </div>
  );
}
