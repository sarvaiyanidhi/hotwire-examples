projects = [
  {
    title: "Website Redesign",
    description: "Complete overhaul of company website with modern design",
    status: "active",
    priority: 1
  },
  {
    title: "Mobile App Development",
    description: "Build native iOS and Android applications",
    status: "planning",
    priority: 2
  },
  {
    title: "Database Migration",
    description: "Migrate legacy database to new infrastructure",
    status: "completed",
    priority: 3
  }
]

projects.each do |project_attrs|
  project = Project.create!(project_attrs)
  
  # Create tasks for each project
  3.times do |i|
    task = project.tasks.create!(
      title: "Task #{i + 1} for #{project.title}",
      description: "Detailed description of task #{i + 1}",
      completed: [true, false].sample
    )
    
    # Add some comments
    2.times do |j|
      task.comments.create!(
        content: "Comment #{j + 1} on #{task.title}",
        author: ["John Doe", "Jane Smith", "Bob Johnson"].sample
      )
    end
  end
end