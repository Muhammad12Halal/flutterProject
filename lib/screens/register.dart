// ignore_for_file: unused_field
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utility/validate.dart';
import 'package:flutter_project/utility/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();

  late String _email, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_function_declarations_over_variables
    var doRegister = () {
      // ignore: avoid_print
      print('on Do Register');

      final form = formkey.currentState;
      if (form!.validate()) {
        form.save();
        print('Email: $_email');
        print('Password: $_password');
        print('Confirm Password: $_confirmPassword');

        if (_password.endsWith(_confirmPassword)) {
          print('Password match');
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          Flushbar(
            title: 'Password not match',
            message: 'Please check your password',
            duration: const Duration(seconds: 10),
          ).show(context);
        }
      } else {
        Flushbar(
          title: 'Form not valid',
          message: 'Please check your form',
          duration: const Duration(seconds: 10),
        ).show(context);
      }
    };

    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30, top: 120),
                  child: const Text(
                    'Sign Up\nAdministrator',
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
                            onSaved: (value) => _email = value!,
                            decoration: buildInputDecoration(
                                'Enter your Email', Icons.email),
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
                            onSaved: (value) => _password = value!,
                            decoration: buildInputDecoration(
                                'Enter your password', Icons.lock),
                          ),
                          const SizedBox(height: 20.0),
                          const Text('Confirm Password',
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
                            onSaved: (value) => _confirmPassword = value!,
                            decoration: buildInputDecoration(
                                'Confirm password', Icons.lock),
                          ),
                          const SizedBox(height: 20.0),
                          longButtons('Register', doRegister),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
