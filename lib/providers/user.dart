import 'package:flutter/cupertino.dart';
import 'package:flutter_project/domain/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: id,
      name: name,
      email: email,
     );

  User get user => _user;
  
  static get id => null;
  static get name => null;
  static get email => null;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
