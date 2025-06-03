import 'package:flutter/material.dart';
import '../models/task.dart';
import './profile_screen.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onTaskUpdated;

  const EditTaskScreen({super.key, required this.task, required this.onTaskUpdated});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _deadline;
  late TaskPriority _priority;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(
      text: widget.task.description,
    );
    _deadline = widget.task.deadline;
    _priority = widget.task.priority;
  }

  void _pickDeadline() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _deadline = date;
      });
    }
  }

  void _submit() {
    final updatedTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      createdAt: widget.task.createdAt,
      deadline: _deadline,
      priority: _priority,
      isCompleted: widget.task.isCompleted,
    );
    widget.onTaskUpdated(updatedTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Редактировать задачу"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
                  "Дедлайн: ${_deadline.toLocal().toString().split(' ')[0]}",
                ),
                Spacer(),
                TextButton(onPressed: _pickDeadline, child: Text("Изменить")),
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
            ElevatedButton(
              onPressed: _submit,
              child: Text("Сохранить изменения"),
            ),
          ],
        ),
      ),
    );
  }
}
