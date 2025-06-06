import 'package:flutter/material.dart';
import '../models/task.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Task> tasks;

  const StatisticsScreen({super.key, required this.tasks});

  int get completedTasksCount => tasks.where((task) => task.isCompleted).length;
  int get totalTasksCount => tasks.length;
  int get overdueTasksCount => tasks.where((task) => !task.isCompleted && task.deadline.isBefore(DateTime.now())).length;

  String get motivationalQuote {
    if (completedTasksCount >= 5)
      return "Ты на пути к величию! Так держать!";
    else if (completedTasksCount > 0)
      return "Продолжай в том же духе — успех рядом!";
    else
      return "Начни с малого. Каждый шаг приближает тебя к цели.";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text("Выполнено задач"),
              trailing: Text("$completedTasksCount / $totalTasksCount"),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.error, color: Colors.red),
              title: const Text("Просрочено задач"),
              trailing: Text("$overdueTasksCount"),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.list, color: Colors.blue),
              title: const Text("Всего задач"),
              trailing: Text("$totalTasksCount"),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "Мотивация:",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              motivationalQuote,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}