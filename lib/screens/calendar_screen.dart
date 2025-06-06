import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';

class CalendarScreen extends StatefulWidget {
  final List<Task> tasks;

  const CalendarScreen({super.key, required this.tasks});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Task> _getTasksForDay(DateTime day) {
    return widget.tasks.where((task) =>
      task.deadline.year == day.year &&
      task.deadline.month == day.month &&
      task.deadline.day == day.day
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tasksForSelectedDay = _getTasksForDay(_selectedDay ?? _focusedDay);
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2100, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: CalendarFormat.month,
          eventLoader: _getTasksForDay,
          calendarStyle: CalendarStyle(
            markerDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: tasksForSelectedDay.isEmpty
              ? const Center(child: Text('Нет задач на этот день'))
              : ListView.builder(
                  itemCount: tasksForSelectedDay.length,
                  itemBuilder: (context, index) {
                    final task = tasksForSelectedDay[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: Icon(
                        task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                        color: task.isCompleted ? Colors.green : Colors.grey,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}