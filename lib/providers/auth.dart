import 'package:flutter/material.dart';


enum  Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  LoggedOut,
}

class AuthProvider extends ChangeNotifier{

  Status _logInStatus = Status.NotLoggedIn;
  Status _registerStatus = Status.NotRegistered;

  Status get logInStatus => _logInStatus;

  set logInStatus( Status value){
    _logInStatus = value;
  }

  Status get registerStatus => _registerStatus;

  set registerStatus( Status value){
    _registerStatus = value;
  }
}