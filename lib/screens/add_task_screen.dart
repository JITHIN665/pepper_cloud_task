import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(
                    Task(title: titleController.text, description: descController.text, dueDate: selectedDate),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
