import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_flutter_firebase/providers/tasks_provider.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class EditTodo extends StatefulWidget {
  final String initialTitle;
  final String initialDescription;
  final String todoId;

  const EditTodo({
    super.key,
    required this.initialTitle,
    required this.initialDescription,
    required this.todoId,
  });

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateTodo() async {
    setState(() {
      isLoading = true;
    });

    // Reference to the Firestore document
    DocumentReference todoRef =
        FirebaseFirestore.instance.collection('todos').doc(widget.todoId);

    // Update the document in Firestore
    await todoRef.update({
      'title': _titleController.text,
      'description': _descriptionController.text,
    });

    // Update the task in the provider
    Provider.of<TasksProvider>(context, listen: false).updateTask(
        widget.todoId, _titleController.text, _descriptionController.text);

    Navigator.of(context).pop();

    setState(() {
      isLoading = false;
    });
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
              'Edit Task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: _titleController,
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
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _descriptionController,
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
        const SizedBox(height: 20.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _updateTodo,
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
                    'Edit it',
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
