import 'dart:convert';

class User {
  String firstName;
  String lastName;
  String email;
  String password;
  String role;

  User(this.firstName, this.lastName, this.email, this.password, this.role);
  factory User.fromJson(Map<String, dynamic> userJson) {
    return User(userJson['firstName'], userJson['lastName'], userJson['email'],
        userJson['password'], userJson["roles"][0]["name"]);
  }
}
