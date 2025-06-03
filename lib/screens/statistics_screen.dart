import 'package:flutter/material.dart';
import '../models/task.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Task> tasks;

  const StatisticsScreen({super.key, required this.tasks});

  int get completedTasksCount {
    return tasks.where((task) => task.isCompleted).length;
  }

  int get overdueTasksCount {
    return tasks
        .where((task) => !task.isCompleted && task.deadline.isBefore(DateTime.now()))
        .length;
  }

  int get remainingTasksCount {
    return tasks.where((task) => !task.isCompleted).length - overdueTasksCount;
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Статистика"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Выполнено",
                      style: TextStyle(fontSize: 18, color: Colors.green),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "$completedTasksCount задач(и)",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Просрочено",
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "$overdueTasksCount задач(и)",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Осталось",
                      style: TextStyle(fontSize: 18, color: Colors.orange),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "$remainingTasksCount задач(и)",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Вдохновляющая цитата:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                motivationalQuote,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}