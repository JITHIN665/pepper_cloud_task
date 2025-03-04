import 'package:flutter/material.dart';
import 'package:pepper_cloud_task/widgets/custom_appbar.dart';
import 'package:pepper_cloud_task/widgets/custom_text_field.dart';
import 'package:pepper_cloud_task/widgets/gradient_button.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../providers/task/task_provider.dart';
import '../../widgets/date_picker_widget.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final taskProvider = Provider.of<TaskProvider>(context);
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF2F5FF),
      appBar: const CustomAppBar(title: 'Add Task'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              labelText: 'Title',
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: descController,
              labelText: 'Description',
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            DatePickerWidget(
              initialDate: selectedDate,
              onDateSelected: (date) {
                selectedDate = date;
              },
            ),
            const SizedBox(height: 40),
            GradientButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
                  taskProvider.addTask(
                    Task(
                      title: titleController.text,
                      description: descController.text,
                      dueDate: selectedDate,
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                        'Please Fill All Area',
                        style: TextStyle(color: Colors.red),
                      )),
                    );
                  }
                }
              },
              text: "Add Task",
            ),
          ],
        ),
      ),
    );
  }
}
