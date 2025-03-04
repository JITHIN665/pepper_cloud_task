import 'package:flutter/material.dart';
import 'package:pepper_cloud_task/screens/task/edit_task_screen.dart';
import 'package:pepper_cloud_task/screens/task/task_details_screen.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Dismissible(
      key: Key(task.id.toString()),
      background: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.red,
        ),
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(task: task),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              colors: [Color(0xFFAEC4FF),Color(0xFFD3A8FF), ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (bool? value) {
                  taskProvider.updateTask(
                    Task(
                      id: task.id,
                      title: task.title,
                      description: task.description,
                      dueDate: task.dueDate,
                      isCompleted: value ?? task.isCompleted,
                    ),
                  );
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      task.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: task.isCompleted ? Colors.green[200] : Colors.red[200],
                              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Text(task.isCompleted ? "Completed" : "Pending")),
                        const SizedBox(width: 20),
                        Text(
                          "Due date: ${task.dueDate.toLocal().toString().split(' ')[0]}",
                          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text("Edit"),
                    onTap: () {
                      Future.delayed(
                        Duration.zero,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(task: task),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
