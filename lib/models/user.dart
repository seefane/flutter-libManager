import 'dart:convert';

class User {
  String token;
  String user_id;
  String email;
  String isAdmin;
  String first_name;
  String last_name;
  User({
    required this.token,
    required this.user_id,
    required this.email,
    required this.isAdmin,
    required this.first_name,
    required this.last_name,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      token: map['token'],
      user_id: map['user_id'].toString(),
      email: map['email'],
      isAdmin: map['isAdmin'],
      first_name: map['first_name'],
      last_name: map['last_name'],
    );
  }
}
