class User {
  int userId;
  String username, email, phone, type, token, renewalToken;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
    required this.type,
    required this.token,
    required this.renewalToken,
  });

  //creater converter
  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'],
      username: responseData['username'],
      email: responseData['email'],
      phone: responseData['phone'],
      type: responseData['type'],
      token: responseData['token'],
      renewalToken: responseData['renewalToken'],
    );
  }
}
