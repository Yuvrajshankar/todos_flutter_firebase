import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/components/Auth/my_button.dart';
import 'package:todos_flutter_firebase/components/Auth/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // register user method
  void login() {}

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
          text: "Sign in",
        ),
      ],
    );
  }
}
