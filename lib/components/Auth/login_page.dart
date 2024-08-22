import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/components/Auth/my_button.dart';
import 'package:todos_flutter_firebase/components/Auth/my_textfield.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // login user method
  void login() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // debugPrint('FirebaseAuthException: ${e.code}');

      switch (e.code) {
        case "invalid-credential":
          errorMessage = "Please check the credentials.";
          break;
        default:
          errorMessage = "An unexpected error occurred.";
          break;
      }

      // Display the error to the user
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          onTap: login,
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
                      "Signing in...",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              : const Text(
                  "Sign in",
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
