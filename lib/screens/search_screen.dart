import 'package:flutter/material.dart';
import '../models/task.dart';

class SearchScreen extends StatelessWidget {
  final List<Task> tasks;

  const SearchScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Поиск'),
    );
  }
}