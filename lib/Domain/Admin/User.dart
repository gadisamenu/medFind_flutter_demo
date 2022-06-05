import 'package:medfind_flutter/Domain/Admin/APharamcy.dart';

class User {
  int? id;
  String firstName;
  String lastName;
  String email;
  String role;
  String? password;
  String? oldPassword;
  String? newPassword;

  User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.role,
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
      'email': email
    });

    if (oldPassword != null && newPassword != null) {
      json.addAll({'oldPassword': oldPassword, 'newPassword': newPassword});
    }
    if (password != null) {
      json.addAll({'password': password});
    }
    return json;
  }

  bool roleValidate(String role) {
    return ["ADMIN", "PHARMACY", "USER"].contains(role);
  }

  bool validate() {
    bool valid = true;
    valid = (firstName.length > 5) && (lastName.length > 5) && valid;
    final exp = RegExp(r'^[a-zA-Z0-9-$*!]{5,50}@[a-zA-Z]{3,4}.[a-zA-Z]{3,5}$');
    valid = valid && exp.hasMatch(email);
    if (oldPassword != null && newPassword != null) {
      final pasExp = RegExp(r'[a-zA-Z0-9-$!#]');
      valid = oldPassword!.contains(pasExp) &&
          newPassword!.contains(pasExp) &&
          valid;
    }
    return valid;
  }
}
