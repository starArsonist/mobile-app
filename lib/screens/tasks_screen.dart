import 'package:flutter/material.dart';
import 'package:mobile_app/screens/profile_screen.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

enum TaskFilter { all, completed, incomplete }

class TasksScreen extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) onAddTask;
  final Function(Task, Task) onEditTask;
  final Function(Task) onDeleteTask;

  const TasksScreen({
    super.key,
    required this.tasks,
    required this.onAddTask,
    required this.onEditTask,
    required this.onDeleteTask,
  });

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskFilter _filter = TaskFilter.all;

  List<Task> get _filteredTasks {
    switch (_filter) {
      case TaskFilter.completed:
        return widget.tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.incomplete:
        return widget.tasks.where((task) => !task.isCompleted).toList();
      default:
        return widget.tasks;
    }
  }

  void _toggleCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _addNewTask(Task task) {
    setState(() {
      widget.tasks.add(task);
    });
  }

  void _editTask(Task oldTask, Task newTask) {
    setState(() {
      final index = widget.tasks.indexOf(oldTask);
      if (index != -1) widget.tasks[index] = newTask;
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      widget.tasks.remove(task);
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
                "Дедлайн: ${task.deadline.toLocal().toString().split(' ')[0]}\n"
                "Приоритет: ${task.priority.name.toUpperCase()}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => widget.onDeleteTask(task),
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
