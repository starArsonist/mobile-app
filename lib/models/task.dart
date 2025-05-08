enum TaskPriority { high, medium, low }

class Task {
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime deadline;
  final TaskPriority priority;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadline,
    required this.priority,
    this.isCompleted = false,
  });
}
