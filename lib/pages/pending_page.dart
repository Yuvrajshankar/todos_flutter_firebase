import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_flutter_firebase/components/TodoBox/todo_box.dart';
import 'package:todos_flutter_firebase/models/task.dart';
import 'package:todos_flutter_firebase/providers/tasks_provider.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    final List<TaskModel> pendingTodos =
        tasksProvider.tasks.where((task) => task.status == 'pending').toList();

    return Scaffold(
      body: pendingTodos.isNotEmpty
          ? TodoBox(
              todos: pendingTodos,
            )
          : const Center(
              child: Text(
                'No pending tasks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
