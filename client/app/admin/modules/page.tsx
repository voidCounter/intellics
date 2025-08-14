export default function ModulesPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">Module Management</h1>
        <p className="text-muted-foreground">
          Create, edit, and organize learning modules and their content.
        </p>
      </div>
      
      <div className="flex justify-between items-center">
        <div className="flex gap-2">
          <input
            type="text"
            placeholder="Search modules..."
            className="px-3 py-2 border rounded-md w-64"
          />
          <select className="px-3 py-2 border rounded-md">
            <option>All Categories</option>
            <option>OOP Fundamentals</option>
            <option>Advanced Concepts</option>
            <option>Design Patterns</option>
          </select>
        </div>
        <button className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">
          Create Module
        </button>
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        <div className="rounded-lg border bg-card p-6">
          <div className="flex justify-between items-start mb-4">
            <h3 className="font-semibold text-lg">OOP Fundamentals</h3>
            <span className="px-2 py-1 bg-green-100 text-green-800 text-xs rounded-full">Active</span>
          </div>
          <p className="text-muted-foreground mb-4">
            Introduction to Object-Oriented Programming concepts including classes, objects, and inheritance.
          </p>
          <div className="flex justify-between items-center text-sm text-muted-foreground mb-4">
            <span>5 Lessons</span>
            <span>2.5 hours</span>
          </div>
          <div className="flex gap-2">
            <button className="flex-1 px-3 py-2 border rounded-md hover:bg-muted">Edit</button>
            <button className="flex-1 px-3 py-2 border rounded-md hover:bg-muted">View</button>
          </div>
        </div>

        <div className="rounded-lg border bg-card p-6">
          <div className="flex justify-between items-start mb-4">
            <h3 className="font-semibold text-lg">Advanced OOP</h3>
            <span className="px-2 py-1 bg-blue-100 text-blue-800 text-xs rounded-full">Draft</span>
          </div>
          <p className="text-muted-foreground mb-4">
            Advanced concepts like polymorphism, abstraction, and design principles.
          </p>
          <div className="flex justify-between items-center text-sm text-muted-foreground mb-4">
            <span>8 Lessons</span>
            <span>4 hours</span>
          </div>
          <div className="flex gap-2">
            <button className="flex-1 px-3 py-2 border rounded-md hover:bg-muted">Edit</button>
            <button className="flex-1 px-3 py-2 border rounded-md hover:bg-muted">Preview</button>
          </div>
        </div>

        <div className="rounded-lg border bg-card p-6">
          <div className="flex justify-between items-start mb-4">
            <h3 className="font-semibold text-lg">Design Patterns</h3>
            <span className="px-2 py-1 bg-yellow-100 text-yellow-800 text-xs rounded-full">In Review</span>
          </div>
          <p className="text-muted-foreground mb-4">
            Common design patterns and their implementation in OOP.
          </p>
          <div className="flex justify-between items-center text-sm text-muted-foreground mb-4">
            <span>6 Lessons</span>
            <span>3 hours</span>
          </div>
          <div className="flex gap-2">
            <button className="flex-1 px-3 py-2 border rounded-md hover:bg-muted">Edit</button>
            <button className="flex-1 px-3 py-2 border rounded-md hover:bg-muted">Review</button>
          </div>
        </div>
      </div>
    </div>
  );
}
