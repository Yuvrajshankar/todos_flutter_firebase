import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/components/Auth/my_button.dart';
import 'package:todos_flutter_firebase/components/Auth/my_textfield.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // register user method
  void register() async {
    setState(() {
      isLoading = true;
    });

    try {
      // showLoadingDialog(context);

      // Create user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user?.uid ?? '';

      // Store data in FireStore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'username': userNameController.text.trim(),
        'uid': uid,
        'email': emailController.text.trim(),
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // debugPrint('FirebaseAuthException: ${e.code}');

      switch (e.code) {
        case "email-already-in-use":
          errorMessage = "The email address is already in use.";
          break;
        case "invalid-email":
          errorMessage = "The email address is not valid.";
          break;
        case "weak-password":
          errorMessage = "The password is too weak.";
          break;
        default:
          errorMessage = "An unexpected error occurred.";
          break;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      print('Firestore error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save user data: $e')));
    } finally {
      // hideLoadingDialog(context);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username
        MyTextfield(
          controller: userNameController,
          hintText: "Username",
          obscureText: false,
        ),

        const SizedBox(height: 10),

        // Email
        MyTextfield(
          controller: emailController,
          hintText: "Email",
          obscureText: false,
        ),

        const SizedBox(height: 10),

        // Password
        MyTextfield(
          controller: passwordController,
          hintText: "Password",
          obscureText: true,
        ),

        const SizedBox(height: 25),

        // Button "Join now"
        MyButton(
          onTap: register,
          content: isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Joining...",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              : const Text(
                  "Join now",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ],
    );
  }
}
