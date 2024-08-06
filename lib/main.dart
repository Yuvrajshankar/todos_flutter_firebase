import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todos_flutter_firebase/layout/layout.dart';
import 'package:todos_flutter_firebase/pages/auth_page.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: navColor),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos.',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const AuthPage(),
    );
  }
}
