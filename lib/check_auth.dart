import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos_flutter_firebase/layout/layout.dart';
import 'package:todos_flutter_firebase/models/task.dart';
import 'package:todos_flutter_firebase/models/user.dart';
import 'package:todos_flutter_firebase/pages/auth_page.dart';
import 'package:todos_flutter_firebase/providers/tasks_provider.dart';
import 'package:todos_flutter_firebase/providers/user_provider.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  // get all user created task from firestore
  Future<void> _fetchTasks(BuildContext context, String uid) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('todos')
          .where('uid', isEqualTo: uid)
          .get();

      debugPrint("FETCHED TASKS: $querySnapshot");

      final tasks = querySnapshot.docs.map((doc) {
        return TaskModel(
          uid: doc.id,
          title: doc['title'],
          description: doc['description'],
          status: doc['status'],
          createdAt: doc['createdAt'],
        );
      }).toList();

      // store tasks in provider
      // Provider.of<TasksProvider>(context, listen: false).setTasks(tasks);

      // store tasks in provider
      final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
      tasksProvider.setTasks(tasks);

      // Print all tasks for debugging
      // tasksProvider.debugPrintTasks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching tasks: $e')),
      );
    }
  }

  /// get User data from Firestore & store it in state
  Future<void> _fetchUserData(BuildContext context, User firebaseUser) async {
    try {
      final docSnapShot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (docSnapShot.exists) {
        final userData = docSnapShot.data();
        // debugPrint('USER DATA: $userData');
        if (userData != null) {
          final userModel = UserModel(
            uid: firebaseUser.uid,
            username: userData['username'] ?? '',
            email: userData['email'] ?? '',
          );

          // store in provider
          Provider.of<UserProvider>(context, listen: false).setUser(userModel);

          await _fetchTasks(context, firebaseUser.uid);
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // loading
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          // user is authenticated
          _fetchUserData(context, snapshot.data!);

          return const Layout();
        } else {
          // user not authenticated
          return const AuthPage();
        }
      },
    );
  }
}
