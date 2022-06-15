import 'package:flutter/material.dart';
import 'package:flutter_project/domain/user.dart';
import 'package:flutter_project/providers/auth.dart';
import 'package:flutter_project/providers/user.dart';
import 'package:flutter_project/screens/Dashboard.dart';
import 'package:flutter_project/screens/Login.dart';
import 'package:flutter_project/screens/register.dart';
import 'package:flutter_project/utility/Shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider())
        ],
        child: MaterialApp(
          title: 'Administrator',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Login(),
          routes: {
            '/login': (context) => const Login(),
            '/register': (context) => const RegisterPage(),
            '/dashboard': (context) => const Dashboard(),
          },
        ));
  }
}
