import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_flutter_firebase/components/TodoBox/todo_box.dart';
import 'package:todos_flutter_firebase/models/task.dart';
import 'package:todos_flutter_firebase/providers/tasks_provider.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    final List<TaskModel> completedTodos = tasksProvider.tasks
        .where((task) => task.status == 'completed')
        .toList();

    return Scaffold(
      body: completedTodos.isNotEmpty
          ? TodoBox(
              todos: completedTodos,
            )
          : const Center(
              child: Text(
                'No completed tasks exists',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
