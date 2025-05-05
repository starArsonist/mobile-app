import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Задачи"),
      ),
      body: Center(
        child: Text("Список задач появится тут"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: переход к созданию задачи
        },
        child: Icon(Icons.add),
      ),
    );
  }
}