import 'package:flutter/material.dart';
import '../models/task.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Task> tasks;

  const HomeScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final upcomingTasks =
        tasks.where((t) => t.deadline.isAfter(DateTime.now())).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Сегодня"),
        actions: [
          IconButton(
            icon: CircleAvatar(child: Icon(Icons.person)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: upcomingTasks.length,
        itemBuilder: (context, index) {
          final task = upcomingTasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(
              "До: ${task.deadline.toLocal().toString().split(' ')[0]}",
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
