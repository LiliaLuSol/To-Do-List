import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'database_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    final data = await DatabaseHelper.instance.readTasks();
    _tasks = data.map((task) => Task.fromMap(task)).toList();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await DatabaseHelper.instance.createTask(task.toMap());
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task.toMap());
    await fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    await fetchTasks();
  }
}