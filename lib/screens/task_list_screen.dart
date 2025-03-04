import 'package:flutter/material.dart';
import 'package:pepper_cloud_task/screens/edit_task_screen.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';
import '../models/task.dart';
// import 'edit_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    List<Task> tasks = List.from(taskProvider.tasks);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              taskProvider.toggleFilter();
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              taskProvider.toggleSort();
            },
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks available. Add one!'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTaskScreen(task: tasks[index]),
                      ),
                    );
                  },
                  child: TaskTile(task: tasks[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTask');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}