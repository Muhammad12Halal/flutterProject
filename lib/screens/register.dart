// ignore_for_file: unused_field
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/providers/auth.dart';
import 'package:flutter_project/utility/validate.dart';
import 'package:flutter_project/utility/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();

  late String name, email, password, confirmPassword;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final loading  = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
        ],
        );


    // ignore: prefer_function_declarations_over_variables
    var doRegister = (){
      print('on doRegister');

      final form = formkey.currentState;
      if(form!.validate()){

        form.save();

        auth.logInStatus= Status.Authenticating;
        auth.notify();

      }else{
        Flushbar(
          title: 'Invalid form',
          message: 'Please complete the form properly',
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
                        top: MediaQuery.of(context).size.height * 0.3,
                        right: 35,
                        left: 35),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 20.0),
                          const Text('Name',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            autofocus: false,
                            validator: (value) =>
                                value!.isEmpty ? 'Name is required' : null,
                            onSaved: (value) => name = value!,
                            decoration: buildInputDecoration(
                                'Enter your Name', Icons.email),
                          ),

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
                            onSaved: (value) => password = value!,
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
                            onSaved: (value) => confirmPassword = value!,
                            decoration: buildInputDecoration(
                                'Confirm password', Icons.lock),
                          ),
                          const SizedBox(height: 20.0),
                          if (auth.logInStatus == Status.Authenticating) loading else longButtons('Register', doRegister),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
