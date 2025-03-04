import 'package:flutter/material.dart';
import 'package:pepper_cloud_task/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:pepper_cloud_task/providers/task/task_provider.dart';
import 'package:pepper_cloud_task/widgets/task_tile.dart';
import 'package:pepper_cloud_task/models/task.dart';
import 'package:pepper_cloud_task/screens/task/edit_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    List<Task> tasks = List.from(taskProvider.tasks);

    return Scaffold(
      backgroundColor: const Color(0xffF2F5FF),
      appBar: const CustomAppBar(
        title: 'Task Manager',
        showBackButton: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MenuAnchor(
                  builder: (BuildContext context, MenuController controller, Widget? child) {
                    return GestureDetector(
                      onTap: () => controller.open(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF3A49F9),
                              Color(0xFF9C2CF3),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.filter_list, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              taskProvider.filterType == 'all'
                                  ? 'All Tasks'
                                  : taskProvider.filterType == 'completed'
                                      ? 'Completed Tasks'
                                      : 'Uncompleted Tasks',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () => taskProvider.setFilter('all'),
                      child: const Text('All Tasks'),
                    ),
                    MenuItemButton(
                      onPressed: () => taskProvider.setFilter('completed'),
                      child: const Text('Completed Tasks'),
                    ),
                    MenuItemButton(
                      onPressed: () => taskProvider.setFilter('uncompleted'),
                      child: const Text('Uncompleted Tasks'),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    taskProvider.toggleSortByDueDate();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF3A49F9),
                          Color(0xFF9C2CF3),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sort, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          "Sort",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
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
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/addTask');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF9C2CF3), Color(0xFF3A49F9)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 8),
              Text("Add Task", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
