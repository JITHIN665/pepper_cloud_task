import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../services/task/task_database.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _sortByDueDateAsc = true;
  String _filterType = 'all';
  DateTime _selectedDate = DateTime.now();

  /// Getter for filtered and sorted tasks
  /// 
  /// 
  List<Task> get tasks {
    List<Task> filteredTasks = _tasks;

    /// Apply filtering based on completion status
    /// 
    /// 
    if (_filterType == 'completed') {
      filteredTasks = filteredTasks.where((task) => task.isCompleted).toList();
    } else if (_filterType == 'uncompleted') {
      filteredTasks = filteredTasks.where((task) => !task.isCompleted).toList();
    }

    /// Sort tasks based on due date (ascending or descending)
    /// 
    /// 
    filteredTasks.sort((a, b) => _sortByDueDateAsc ? a.dueDate.compareTo(b.dueDate) : b.dueDate.compareTo(a.dueDate));

    return filteredTasks;
  }

  /// Getters for filter type and selected date
  /// 
  /// 
  String get filterType => _filterType;
  DateTime get selectedDate => _selectedDate;

  /// Updates the selected date and notifies listeners
  /// 
  /// 
  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Loads tasks from the database
  /// 
  /// 
  Future<void> loadTasks() async {
    _tasks = await TaskDatabase.instance.getTasks();
    notifyListeners();
  }

  /// Adds a new task to the database and refreshes the list
  /// 
  /// 
  Future<void> addTask(Task task) async {
    await TaskDatabase.instance.insertTask(task);
    await loadTasks();
  }

  /// Updates an existing task in the database and refreshes the list
  /// 
  /// 
  Future<void> updateTask(Task task) async {
    await TaskDatabase.instance.updateTask(task);
    await loadTasks();
  }

  /// Deletes a task from the database and refreshes the list
  /// 
  /// 
  Future<void> deleteTask(int id) async {
    await TaskDatabase.instance.deleteTask(id);
    await loadTasks();
  }

  /// Sets the current filter type and notifies listeners
  /// 
  /// 
  void setFilter(String filter) {
    _filterType = filter;
    notifyListeners();
  }

  /// Toggles the sorting order by due date and notifies listeners
  /// 
  /// 
  void toggleSortByDueDate() {
    _sortByDueDateAsc = !_sortByDueDateAsc;
    notifyListeners();
  }
}
