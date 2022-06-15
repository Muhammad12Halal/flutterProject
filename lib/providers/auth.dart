import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/domain/user.dart';
import 'package:flutter_project/utility/App_url.dart';
import 'package:flutter_project/utility/Shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
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

  Future<FutureOr> register(String name, String email, String password) async {
    // ignore: non_constant_identifier_names
    final Map<String, dynamic> ApiBodyData = {
     'name': name,
     'email': email,
      'password': password,
    };
    print(ApiBodyData);
    return await post(AppUrl.register,
            body: jsonEncode(ApiBodyData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }


  notify(){
    notifyListeners();
  }

  static Future<FutureOr> onValue (Response response) async {
    var result ;

    final Map<String, dynamic> responseData = json.decode(response.body);

    print(responseData);

    if(response.statusCode == 200){

      var userData = responseData['data'];

      // now we will create a user model
      User authUser = User.fromJson(responseData);

      // now we will create shared preferences and save data
      UserPreferences().saveUser(authUser);

      result = {
        'status':true,
        'message':'Successfully registered',
        'data': authUser
      };

    }else{
      result = {
        'status':false,
        'message':'Successfully registered',
        'data': responseData
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {

    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password ,
    };

    _logInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      AppUrl.login,
      body: json.encode(loginData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
        'X-ApiKey' : 'abcdef12345'
      },
    );

    if (response.statusCode == 200) {

      final Map<String, dynamic> responseData = json.decode(response.body);

      print(responseData);

      var userData = responseData['Content'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _logInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};

    } else {
      _logInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
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
