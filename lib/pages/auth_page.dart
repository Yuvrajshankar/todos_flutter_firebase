import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/components/Auth/login_page.dart';
import 'package:todos_flutter_firebase/components/Auth/register_page.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // page state
  bool isLogin = true;

  // toggle between login & register page
  void togglePage() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  // Google button
  void google() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LOGO
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'lib/images/logo.png',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 30),

              // CREATE ACCOUNT / SIGN IN
              Text(
                isLogin ? 'Sign in' : 'Create account',
                style: const TextStyle(
                  color: textColor,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 25),

              // LOGIN / REGISTER PAGE
              isLogin ? const LoginPage() : const RegisterPage(),

              const SizedBox(height: 20),

              // Don't have an account? Create / Already on Todos? Sign in
              // GestureDetector(
              //   onTap: togglePage, // Toggle the page on tap
              //   child: Text(
              //     isLogin
              //         ? 'Already on Todos? Sign in'
              //         : 'Don\'t have an account? Create',
              //     style: const TextStyle(
              //       color: Colors.blue,
              //       decoration: TextDecoration.underline,
              //     ),
              //   ),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin ? "Don't have an account? " : "Already on Todos? ",
                    style: const TextStyle(
                      color: descColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: togglePage,
                    child: Text(
                      isLogin ? "Create" : "Sign in",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectColor,
                      ),
                    ),
                  )
                ],
              ),

              // ----------------------- OR -----------------------

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              // GOOGLE AUTH
              GestureDetector(
                onTap: google,
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/images/google.png',
                        height: 25,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Continue with Google",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
