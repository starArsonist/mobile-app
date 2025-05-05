import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Домашний экран"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // TODO: переход к календарю
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Цитата дня и задачи здесь"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: переход к добавлению задачи
        },
        child: Icon(Icons.add),
      ),
    );
  }
}