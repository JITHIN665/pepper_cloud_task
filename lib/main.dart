import 'package:flutter/material.dart';
import 'package:pepper_cloud_task/providers/task_provider.dart';
import 'package:pepper_cloud_task/screens/add_task_screen.dart';
import 'package:pepper_cloud_task/screens/splash_screen.dart';
import 'package:pepper_cloud_task/screens/task_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/': (context) => const TaskListScreen(),
          '/addTask': (context) => const AddTaskScreen(),
        },
      ),
    );
  }
}