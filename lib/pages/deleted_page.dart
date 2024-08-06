import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/Data/todoData.dart';
import 'package:todos_flutter_firebase/components/TodoBox/todo_box.dart';

class DeletedPage extends StatelessWidget {
  const DeletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // only "deleted" todos from todoData.dart
    final List<Map<String, dynamic>> deletedTodos =
        todoData.where((todo) => todo['status'] == 'deleted').toList();

    return Scaffold(
      body: TodoBox(todos: deletedTodos),
    );
  }
}
