import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Login.dart';
import 'package:flutter_project/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Administrator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),

      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}

