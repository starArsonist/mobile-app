import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(Task) onTaskAdded;

  const AddTaskScreen({required this.onTaskAdded});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _deadline;
  TaskPriority _priority = TaskPriority.medium;

  void _submit() {
    if (_titleController.text.isEmpty || _deadline == null) return;

    final newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      createdAt: DateTime.now(),
      deadline: _deadline!,
      priority: _priority,
    );

    widget.onTaskAdded(newTask);
    Navigator.pop(context);
  }

  void _pickDeadline() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _deadline = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Добавить задачу"),
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Название"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Описание"),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  _deadline == null
                      ? "Дедлайн"
                      : "Дедлайн: ${_deadline!.toLocal().toString().split(' ')[0]}",
                ),
                Spacer(),
                TextButton(onPressed: _pickDeadline, child: Text("Выбрать")),
              ],
            ),
            DropdownButton<TaskPriority>(
              value: _priority,
              onChanged: (value) {
                if (value != null) setState(() => _priority = value);
              },
              items:
                  TaskPriority.values.map((p) {
                    return DropdownMenuItem(
                      value: p,
                      child: Text(p.name.toUpperCase()),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text("Сохранить")),
          ],
        ),
      ),
    );
  }
}
