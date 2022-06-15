// ignore_for_file: deprecated_member_use

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/domain/user.dart';
import 'package:flutter_project/providers/auth.dart';
import 'package:flutter_project/providers/user.dart';
import 'package:flutter_project/utility/validate.dart';
import 'package:flutter_project/utility/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formkey = GlobalKey<FormState>();
  // ignore: unused_field
  late String email, password;

  @override
  Widget build(BuildContext context) {
     AuthProvider auth = Provider.of<AuthProvider>(context);

    // ignore: prefer_function_declarations_over_variables
    var doLogin = () {
      final form = formkey.currentState;
      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> response =
            auth.login(email, password);
          response.then((response) {
          if (response['status']) {

            // ignore: unused_local_variable
            User user = response['user'];

            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.pushReplacementNamed(context, '/dashboard');
      }
      }
      );
      } else {
        Flushbar(
          title: 'Login Failed',
          message: 'Please complete the form',
          duration: const Duration(seconds: 10),
        ).show(context);
      }
    };

    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text(" Login ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: const EdgeInsets.all(0.0),
          child: const Text("Forgot password?",
              style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        FlatButton(
          padding: const EdgeInsets.only(left: 0.0),
          child: const Text("Sign up",
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
        ),
      ],
    );

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login.png'),
          fit: BoxFit.cover,
        ),
      ),
          child: Scaffold(              
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              Container(
                padding: const EdgeInsets.only(left: 30, top: 120),
                child: const Text(
                  'Welcome\nAdministrator',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                  right: 35,
                  left: 35),
              child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      const Text('Email',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),

                      const SizedBox(height: 20.0),
                      TextFormField(
                        autofocus: false,
                        validator: validateEmail,
                        onSaved: (value) => email = value!,
                        decoration: buildInputDecoration(
                            'Enter your email', Icons.email),
                      ),
                      const SizedBox(height: 20.0),
                      const Text('Password',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        autofocus: false,
                        obscureText: true,
                        validator: (value) =>
                            value!.isEmpty ? 'Password is required' : null,
                        onSaved: (value) => password = value!,
                        decoration: buildInputDecoration(
                            'Enter your password', Icons.lock),
                      ),

                      const SizedBox(height: 20.0),
                      auth.logInStatus == Status.Authenticating ?loading
                      :longButtons('Login', doLogin),
                      const SizedBox(height: 20.0),
                      forgotLabel

                    ],
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
