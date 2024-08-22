import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_flutter_firebase/components/PopUp/delete_profile.dart';
import 'package:todos_flutter_firebase/components/PopUp/popup.dart';
import 'package:todos_flutter_firebase/components/PopUp/update_profile.dart';
import 'package:todos_flutter_firebase/components/TodoBox/todo_box.dart';
import 'package:todos_flutter_firebase/models/task.dart';
import 'package:todos_flutter_firebase/models/user.dart';
import 'package:todos_flutter_firebase/providers/tasks_provider.dart';
import 'package:todos_flutter_firebase/providers/user_provider.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String filter = 'All';
  String? username;
  String? email;
  bool isLoading = true;

  List<TaskModel> filteredTodos(List<TaskModel> tasks) {
    switch (filter) {
      case 'Pending':
        return tasks.where((todo) => todo.status == 'pending').toList();
      case 'Completed':
        return tasks.where((todo) => todo.status == 'completed').toList();
      case 'Deleted':
        return tasks.where((todo) => todo.status == 'deleted').toList();
      default:
        return tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final tasksProvider = Provider.of<TasksProvider>(context);
    final UserModel? user = userProvider.user;
    final tasks = tasksProvider.tasks;

    final List<TaskModel> displayedTodos = filteredTodos(tasks);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Username:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(user?.username ?? 'N/A'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Email:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(user?.email ?? 'N/A'),
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
                          content: UpdateProfile(
                            initialName: user?.username ?? '',
                            initialEmail: user?.email ?? '',
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
            child: displayedTodos.isNotEmpty
                ? TodoBox(todos: displayedTodos)
                : const Center(
                    child: Text(
                      'No tasks',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
