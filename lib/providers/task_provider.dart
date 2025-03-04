import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_database.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _showCompletedOnly = false;
  bool _sortByDueDate = false;

  List<Task> get tasks {
    List<Task> filteredTasks = _tasks;
    if (_showCompletedOnly) {
      filteredTasks = filteredTasks.where((task) => task.isCompleted).toList();
    }
    if (_sortByDueDate) {
      filteredTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    }
    return filteredTasks;
  }

  Future<void> loadTasks() async {
    _tasks = await TaskDatabase.instance.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await TaskDatabase.instance.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await TaskDatabase.instance.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await TaskDatabase.instance.deleteTask(id);
    await loadTasks();
  }

  void toggleFilter() {
    _showCompletedOnly = !_showCompletedOnly;
    notifyListeners();
  }

  void toggleSort() {
    _sortByDueDate = !_sortByDueDate;
    notifyListeners();
  }
}
