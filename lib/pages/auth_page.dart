import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  bool isLoading = false;

  // toggle between login & register page
  void togglePage() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  // Google sign-in method
  Future<void> google() async {
    setState(() {
      isLoading = true;
    });

    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      // the email popup
      await googleSignIn.signOut();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // If the user cancels the sign-in process, hide the loading dialog

        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Google
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get user info
      User? user = userCredential.user;
      String uid = user?.uid ?? '';
      String displayName = user?.displayName ?? '';
      String email = user?.email ?? '';

      // Store data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'username': displayName,
        'email': email,
      });
    } catch (e) {
      // Handle errors and display a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Google: $e')),
      );
    } finally {
      // Ensure that the loading dialog is hidden at the end of the process
      setState(() {
        isLoading = false;
      });
    }
  }

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
                onTap: isLoading ? null : google,
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
                      if (isLoading)
                        const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2.0,
                          ),
                        )
                      else ...[
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
