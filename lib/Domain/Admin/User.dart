import 'package:medfind_flutter/Domain/Admin/APharamcy.dart';

class User {
  int? id;
  String firstName;
  String lastName;
  String email;
  String? role;
  String? password;
  String? oldPassword;
  String? newPassword;

  User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      this.role,
      this.id,
      this.oldPassword,
      this.newPassword,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"].toInt(),
      role: json["roles"][0]["name"],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
  factory User.fromQuery(Map<String, Object?> query) {
    return User(
      id: int.parse(query["id"].toString()),
      role: query["roles"].toString(),
      firstName: query['firstName'].toString(),
      lastName: query['lastName'].toString(),
      email: query['email'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json.addAll({
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role
    });

    if (oldPassword != null && newPassword != null) {
      json.addAll({'oldPassword': oldPassword, 'newPassword': newPassword});
    }
    if (password != null) {
      json.addAll({'password': password});
    }
    return json;
  }

  Map<String, Object?> toQuery() {
    Map<String, Object?> query = {};
    query.addAll({
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role
    });
    return query;
  }

  bool roleValidate(String role) {
    return ["ADMIN", "PHARMACY", "USER"].contains(role);
  }

  bool validate() {
    bool valid = true;
    valid = (firstName.length == 5) && (lastName.length >= 5) && valid;

    final exp = RegExp("[A-Za-z]@[A-Za-z].[A-Za-z]");
    valid = valid && exp.hasMatch(email);
    if (oldPassword != null && newPassword != null) {
      print("here valid");
      final pasExp = RegExp("[a-zA-Z0-9-!#]");
      valid = oldPassword!.contains(pasExp) &&
          newPassword!.contains(pasExp) &&
          valid;
      valid = valid && (newPassword!.length > 7);
    }
    return valid;
  }
}
