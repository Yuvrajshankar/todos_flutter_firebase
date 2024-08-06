import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/components/PopUp/popup.dart';
import 'package:todos_flutter_firebase/components/PopUp/edit_todo.dart'; // Updated import
import 'package:todos_flutter_firebase/components/PopUp/view_todo.dart';
import 'package:todos_flutter_firebase/components/TodoBox/button_background.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class TodoBox extends StatelessWidget {
  final List<Map<String, dynamic>> todos;

  const TodoBox({
    super.key,
    required this.todos,
  });

  // Function to get status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return completedColor;
      case 'pending':
        return pendingColor;
      case 'deleted':
        return deletedColor;
      default:
        return Colors.transparent;
    }
  }

  // Function to render buttons
  List<Widget> renderButtons(
      BuildContext context, String status, Map<String, dynamic> todo) {
    switch (status) {
      case 'pending':
        return [
          ButtonBackground(
            icon: const Icon(Icons.edit),
            onTap: () {
              showCustomPopup(
                context: context,
                content: EditTodo(
                  initialTitle: todo['title'],
                  initialDescription: todo['description'],
                ),
              );
            },
          ),
          const SizedBox(width: 8.0),
          ButtonBackground(
            icon: const Icon(Icons.done),
            onTap: () {},
          ),
          const SizedBox(width: 8.0),
          ButtonBackground(
            icon: const Icon(Icons.delete),
            onTap: () {},
          ),
        ];
      case 'completed':
        return [
          ButtonBackground(
            icon: const Icon(Icons.close),
            onTap: () {},
          ),
          const SizedBox(width: 8.0),
          ButtonBackground(
            icon: const Icon(Icons.delete),
            onTap: () {},
          ),
        ];
      case 'deleted':
        return [
          ButtonBackground(
            icon: const Icon(Icons.restart_alt),
            onTap: () {},
          ),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: todos.map((todo) {
          return Container(
            decoration: BoxDecoration(
              color: navColor,
              borderRadius: BorderRadius.circular(14.0),
            ),
            constraints: const BoxConstraints(
              maxHeight: 210.0,
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsetsDirectional.only(bottom: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(3.0, 1.0, 3.0, 1.0),
                      decoration: BoxDecoration(
                        color: getStatusColor(todo['status']),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        todo['status'],
                      ),
                    ),
                    ButtonBackground(
                      icon: const Icon(Icons.visibility),
                      onTap: () {
                        showCustomPopup(
                          context: context,
                          content: ViewTodo(
                            title: todo['title'],
                            description: todo['description'],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  todo['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  height: 60.0,
                  child: Text(
                    todo['description'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: descColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      todo['date'],
                      style: const TextStyle(
                        color: dateColor,
                        fontSize: 13.0,
                      ),
                    ),
                    Row(
                      children: [
                        ...renderButtons(context, todo['status'], todo),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
