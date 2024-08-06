import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/Data/todoData.dart';
import 'package:todos_flutter_firebase/components/TodoBox/todo_box.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pendingTodos =
        todoData.where((todo) => todo['status'] == 'pending').toList();

    return Scaffold(
      body: TodoBox(
        todos: pendingTodos,
      ),
    );
  }
}
