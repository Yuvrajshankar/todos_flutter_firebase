import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_flutter_firebase/models/task.dart';
import 'package:todos_flutter_firebase/providers/tasks_provider.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final headingController = TextEditingController();
  final descController = TextEditingController();
  bool isLoading = false;

  Future<void> _createTodo() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final title = headingController.text;
    final description = descController.text;

    if (uid != null && title.isNotEmpty && description.isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });

        final docRef =
            await FirebaseFirestore.instance.collection('todos').add({
          'uid': uid,
          'title': title,
          'description': description,
          'status': 'pending',
          'createdAt': Timestamp.now(),
        });

        // Create a TaskModel object with the new task data
        final newTask = TaskModel(
          uid: docRef.id,
          title: title,
          description: description,
          status: 'pending',
          createdAt: Timestamp.now(),
        );

        // Add the new task to TasksProvider
        final tasksProvider =
            Provider.of<TasksProvider>(context, listen: false);
        tasksProvider.addTask(newTask);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task created successfully')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating todo: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title or description cannot be empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Task",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        // Heading Field
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: headingController,
            decoration: InputDecoration(
              labelText: 'Heading',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: textColor),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            ),
          ),
        ),
        // Description Field
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: descController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: textColor),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            ),
            maxLines: 5,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _createTodo,
            style: ElevatedButton.styleFrom(
              backgroundColor: selectColor,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: textColor)
                : const Text(
                    'Create',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
