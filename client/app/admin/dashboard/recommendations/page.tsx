export default function RecommendationsPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">AI Recommendations</h1>
        <p className="text-muted-foreground">
          AI-powered insights and recommendations for improving learning outcomes.
        </p>
      </div>
      
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        <div className="rounded-lg border bg-card p-6">
          <h3 className="font-semibold">Content Gaps</h3>
          <p className="text-2xl font-bold">12</p>
          <p className="text-xs text-muted-foreground">Identified learning gaps</p>
        </div>
        <div className="rounded-lg border bg-card p-6">
          <h3 className="font-semibold">Optimization Score</h3>
          <p className="text-2xl font-bold">87%</p>
          <p className="text-xs text-muted-foreground">Content optimization</p>
        </div>
        <div className="rounded-lg border bg-card p-6">
          <h3 className="font-semibold">Predictions</h3>
          <p className="text-2xl font-bold">94%</p>
          <p className="text-xs text-muted-foreground">Accuracy rate</p>
        </div>
      </div>

      <div className="rounded-lg border">
        <div className="p-6">
          <h3 className="text-lg font-semibold mb-4">Top Recommendations</h3>
          <div className="space-y-4">
            <div className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div>
                <h4 className="font-medium">Add more practice questions for OOP concepts</h4>
                <p className="text-sm text-muted-foreground">Users are struggling with inheritance and polymorphism</p>
              </div>
              <span className="text-sm text-blue-600 font-medium">High Priority</span>
            </div>
            
            <div className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div>
                <h4 className="font-medium">Optimize lesson sequence for Module 3</h4>
                <p className="text-sm text-muted-foreground">Current order causes confusion for 23% of users</p>
              </div>
              <span className="text-sm text-orange-600 font-medium">Medium Priority</span>
            </div>
            
            <div className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div>
                <h4 className="font-medium">Add visual aids for complex diagrams</h4>
                <p className="text-sm text-muted-foreground">Visual learners need more support</p>
              </div>
              <span className="text-sm text-green-600 font-medium">Low Priority</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
