import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/models/task.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void setTasks(List<TaskModel> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void addTask(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(String id, String newTitle, String newDescription) {
    final taskIndex = _tasks.indexWhere((task) => task.uid == id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = TaskModel(
        uid: id,
        title: newTitle,
        description: newDescription,
        status: _tasks[taskIndex].status,
        createdAt: _tasks[taskIndex].createdAt,
      );
      notifyListeners();
    }
  }

  void updateTaskStatus(String id, String newStatus) {
    final taskIndex = _tasks.indexWhere((task) => task.uid == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].status = newStatus;
      notifyListeners();
    }
  }

  void clearTasks() {
    _tasks = [];
    notifyListeners();
  }

  void debugPrintTasks() {
    for (var task in _tasks) {
      debugPrint(
          'Task ID: ${task.uid}, Title: ${task.title}, Description: ${task.description}, Status: ${task.status}, Created At: ${task.createdAt}');
    }
  }
}
