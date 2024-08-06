import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class DeleteProfile extends StatelessWidget {
  const DeleteProfile({super.key});

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
                onPressed: () {},
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Background color
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
