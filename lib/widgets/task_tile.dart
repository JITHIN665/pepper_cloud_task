import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Dismissible(
      key: Key(task.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        taskProvider.deleteTask(task.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task deleted!')),
        );
      },
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => taskProvider.updateTask(
            Task(
              id: task.id,
              title: task.title,
              description: task.description,
              dueDate: task.dueDate,
              isCompleted: !task.isCompleted,
            ),
          ),
        ),
      ),
    );
  }
}
