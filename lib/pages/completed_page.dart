import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/Data/todoData.dart';
import 'package:todos_flutter_firebase/components/TodoBox/todo_box.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // only "completed" todos from todoData.dart
    final List<Map<String, dynamic>> completedTodos =
        todoData.where((todo) => todo['status'] == 'completed').toList();

    return Scaffold(
      body: TodoBox(todos: completedTodos),
    );
  }
}
