import 'package:flutter/material.dart';
import 'package:pepper_cloud_task/models/task.dart';
import 'package:pepper_cloud_task/widgets/custom_appbar.dart';
import 'package:pepper_cloud_task/widgets/custom_text.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;
  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> taskDetails = [
      {"label": "Title:", "value": task.title},
      {"label": "Description:", "value": task.description},
      {"label": "Due Date:", "value": "${task.dueDate.toLocal()}".split(' ')[0]},
      {"label": "Status:", "value": task.isCompleted ? "Completed" : "Pending"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF2F5FF),
      appBar: const CustomAppBar(title: 'Task Details'),
      body: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color(0xffFFFFFF),
        ),
        child: ListView.builder(
          itemCount: taskDetails.length,
          itemBuilder: (context, index) {
            final detail = taskDetails[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomTextRow(label: detail["label"]!, value: detail["value"]!),
            );
          },
        ),
      ),
    );
  }
}
