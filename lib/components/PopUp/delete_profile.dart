import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class DeleteProfile extends StatelessWidget {
  const DeleteProfile({super.key});

  Future<void> _deleteUserAndTasks(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final uid = user.uid;

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Delete all tasks associated with the user
      final tasksQuerySnapshot = await FirebaseFirestore.instance
          .collection('todos')
          .where('uid', isEqualTo: uid)
          .get();

      for (var doc in tasksQuerySnapshot.docs) {
        await doc.reference.delete();
      }

      // Delete user profile from Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();

      // Delete the user from Firebase Authentication
      await user.delete();

      // Close loading indicator
      Navigator.of(context).pop();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile and tasks deleted successfully')),
      );

      // Navigate to a different screen if needed
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      // Close loading indicator
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Are you sure you want to delete your profile with all created tasks?",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _deleteUserAndTasks(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Background color
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
