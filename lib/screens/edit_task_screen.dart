import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;
  const EditTaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    final descController = TextEditingController(text: task.description);
    DateTime selectedDate = task.dueDate;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(
                    Task(
                      id: task.id,
                      title: titleController.text,
                      description: descController.text,
                      dueDate: selectedDate,
                      isCompleted: task.isCompleted,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}