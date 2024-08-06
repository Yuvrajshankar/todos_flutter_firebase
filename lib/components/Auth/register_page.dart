import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/components/Auth/my_button.dart';
import 'package:todos_flutter_firebase/components/Auth/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // register user method
  void register() {}

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
          text: "Join now",
        ),
      ],
    );
  }
}
