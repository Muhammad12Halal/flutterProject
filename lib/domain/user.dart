class User {
  int id;
  String name, email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  //creater converter
  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      id: responseData['id'],
      name: responseData['name'],
      email: responseData['email'],
    );
  }
}
