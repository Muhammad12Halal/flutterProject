import 'package:flutter_project/domain/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('id', user.id);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);

    // ignore: deprecated_member_use
    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt('id');
    String name = prefs.getString('name');
    String email = prefs.getString('email');

    return User(
      id: id,
      name: name,
      email: email,
    );
  }

  void removeUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');

  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
