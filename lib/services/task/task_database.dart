// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pepper_cloud_task/models/task.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  /// Getter for the database, initializes if not already created
  /// 
  /// 
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  /// Initializes the database
  /// 
  /// 
  Future<Database> _initDB(String filePath) async {
    // Get database directory path
    final dbPath = await getDatabasesPath();
    // Combine directory and file name
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// Creates the tasks table in the database
  /// 
  /// 
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,  
        title TEXT NOT NULL,                   
        description TEXT NOT NULL,             
        dueDate TEXT NOT NULL,                 
        isCompleted INTEGER NOT NULL          
      )
    ''');
  }

  /// Fetches all tasks from the database
  /// 
  /// 
  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final result = await db.query('tasks');
    return result.map((map) => Task.fromMap(map)).toList();
  }

  /// Inserts a new task into the database
  /// 
  /// 
  Future<int> insertTask(Task task) async {
    final db = await instance.database;
    return await db.insert('tasks', task.toMap());
  }

  /// Updates an existing task in the database where ID matches
  /// 
  /// 
  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  /// Deletes a task from the database where ID matches
  /// 
  /// 
  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
