import 'package:flutter/material.dart';
import 'package:flutter_project/utility/Shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text("DASHBOARD PAGE"),
        elevation: 0.1,
      ),
      body: Column(
        children:  [
          const SizedBox(
            height: 100,
          ),
          const Center(child: 
          Text('Welcome to Dashboard Page', style: TextStyle(fontSize: 20),),
          ),
          const SizedBox(height: 100),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
              UserPreferences().removeUser();
              Navigator.pushReplacementNamed(context, '/login');
            },
            color: Colors.lightBlueAccent,
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
  }

