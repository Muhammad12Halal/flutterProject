import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/domain/user.dart';
import 'package:flutter_project/utility/App_url.dart';
import 'package:flutter_project/utility/Shared_preferences.dart';
import 'package:http/http.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  LoggedOut,
}

class AuthProvider extends ChangeNotifier {
  Status _logInStatus = Status.NotLoggedIn;
  Status _registerStatus = Status.NotRegistered;

  Status get logInStatus => _logInStatus;

  set logInStatus(Status value) {
    _logInStatus = value;
  }

  Status get registerStatus => _registerStatus;

  set registerStatus(Status value) {
    _registerStatus = value;
  }

  Future<FutureOr> register(String email, String password) async {
    // ignore: non_constant_identifier_names
    final Map<String, dynamic> ApiBodyData = {
      'email': email,
      'password': password,
    };

    return await post(AppUrl.register,
            body: jsonEncode(ApiBodyData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  static Future<FutureOr> onValue(Response response) async {
    // ignore: prefer_typing_uninitialized_variables
    var result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    print(responseData);

    if (response.statusCode == 200) {
      
      var userData = responseData['date'];

      //create User Model
      User authUser = User.fromJson(responseData);

      //now create shared preferences and save data
      UserPreferences().saveUser(authUser);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser,
      };
    }else {
      result = {
        'status': false,
        'message': 'Failed to register',
        'data': responseData,
      };
    }
    return result;
  }

  static onError(error){
    print('the error is ${error.detail}');
    return {
      'status':false,
      'message':'Unsuccessful Request',
      'data':error
    };
  }
}
