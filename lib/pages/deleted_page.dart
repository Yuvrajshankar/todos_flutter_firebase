import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_flutter_firebase/components/TodoBox/todo_box.dart';
import 'package:todos_flutter_firebase/models/task.dart';
import 'package:todos_flutter_firebase/providers/tasks_provider.dart';

class DeletedPage extends StatelessWidget {
  const DeletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    final List<TaskModel> deletedTodos =
        tasksProvider.tasks.where((task) => task.status == 'deleted').toList();

    return Scaffold(
      body: deletedTodos.isNotEmpty
          ? TodoBox(
              todos: deletedTodos,
            )
          : const Center(
              child: Text(
                'No deleted tasks exists',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
