import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

enum TaskFilter { all, completed, incomplete }

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskFilter _filter = TaskFilter.all;

  List<Task> _tasks = [];

  List<Task> get _filteredTasks {
    switch (_filter) {
      case TaskFilter.completed:
        return _tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.incomplete:
        return _tasks.where((task) => !task.isCompleted).toList();
      default:
        return _tasks;
    }
  }

  void _toggleCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _addNewTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
  }

  void _editTask(Task oldTask, Task newTask) {
    setState(() {
      final index = _tasks.indexOf(oldTask);
      if (index != -1) _tasks[index] = newTask;
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            Navigator.canPop(context)
                ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
                : null,
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
        title: Text("Задачи"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilterChip(
                label: Text('Все'),
                selected: _filter == TaskFilter.all,
                onSelected: (_) => setState(() => _filter = TaskFilter.all),
              ),
              FilterChip(
                label: Text('Выполненные'),
                selected: _filter == TaskFilter.completed,
                onSelected:
                    (_) => setState(() => _filter = TaskFilter.completed),
              ),
              FilterChip(
                label: Text('Невыполненные'),
                selected: _filter == TaskFilter.incomplete,
                onSelected:
                    (_) => setState(() => _filter = TaskFilter.incomplete),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredTasks.length,
        itemBuilder: (context, index) {
          final task = _filteredTasks[index];
          return Dismissible(
            key: ValueKey(task.title + task.deadline.toString()),
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.edit, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                // Свайп влево = удалить
                _deleteTask(task);
                return true;
              } else if (direction == DismissDirection.startToEnd) {
                // Свайп вправо = редактировать
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => EditTaskScreen(
                          task: task,
                          onTaskUpdated:
                              (updatedTask) => _editTask(task, updatedTask),
                        ),
                  ),
                );
                return false;
              }
              return false;
            },
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  task.isCompleted
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: task.isCompleted ? Colors.blue : null,
                ),
                onPressed: () => _toggleCompletion(task),
              ),
              title: Text(task.title),
              subtitle: Text(
                "Дедлайн: ${task.deadline.toLocal().toString().split(' ')[0]}",
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task.priority.name.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(onTaskAdded: _addNewTask),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text("Добавить задание"),
        ),
      ),
    );
  }
}
