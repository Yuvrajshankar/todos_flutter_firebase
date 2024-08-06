import 'package:flutter/material.dart';

class ViewTodo extends StatelessWidget {
  final String title;
  final String description;

  const ViewTodo({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxHeight: 87,
          ),
          child: SingleChildScrollView(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          constraints: const BoxConstraints(
            maxHeight: 300,
          ),
          child: SingleChildScrollView(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
