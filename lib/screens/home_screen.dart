import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onStart;

  const HomeScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Добро пожаловать в Task Planner',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onStart,
            child: const Text('Начать работу'),
          ),
        ],
      ),
    );
  }
}