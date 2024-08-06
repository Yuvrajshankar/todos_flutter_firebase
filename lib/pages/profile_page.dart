import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todos_flutter_firebase/Data/todoData.dart';
import 'package:todos_flutter_firebase/components/PopUp/delete_profile.dart';
import 'package:todos_flutter_firebase/components/PopUp/popup.dart';
import 'package:todos_flutter_firebase/components/PopUp/update_profile.dart';
import 'package:todos_flutter_firebase/components/TodoBox/todo_box.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String filter = 'All';

  List<Map<String, dynamic>> filteredTodos() {
    switch (filter) {
      case 'Pending':
        return todoData.where((todo) => todo['status'] == 'pending').toList();
      case 'Completed':
        return todoData.where((todo) => todo['status'] == 'completed').toList();
      case 'Deleted':
        return todoData.where((todo) => todo['status'] == 'deleted').toList();
      default:
        return todoData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Username:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("uv"),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("uvdev@gmail.com"),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        showCustomPopup(
                          context: context,
                          content: const UpdateProfile(
                            initialName: "uv",
                            initialEmail: "uvdev@gmail.com",
                          ),
                        );
                      },
                      label: const Text('Edit'),
                      icon: const Icon(Icons.edit),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: completedColor,
                        iconColor: textColor,
                        foregroundColor: textColor,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showCustomPopup(
                          context: context,
                          content: const DeleteProfile(),
                        );
                      },
                      label: const Text('Delete'),
                      icon: const Icon(Icons.delete),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        iconColor: textColor,
                        foregroundColor: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: navColor,
                  border: Border.all(color: textColor),
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: DropdownButton<String>(
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All')),
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    DropdownMenuItem(
                        value: 'Completed', child: Text('Completed')),
                    DropdownMenuItem(value: 'Deleted', child: Text('Deleted')),
                  ],
                  value: filter,
                  onChanged: (newValue) {
                    setState(() {
                      filter = newValue!;
                    });
                  },
                  dropdownColor: navColor,
                  underline: Container(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TodoBox(
              todos: filteredTodos(),
            ),
          ),
        ],
      ),
    );
  }
}
