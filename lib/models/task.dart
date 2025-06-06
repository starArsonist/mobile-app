enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime deadline;
  final TaskPriority priority;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadline,
    required this.priority,
    this.isCompleted = false,
  });
}
