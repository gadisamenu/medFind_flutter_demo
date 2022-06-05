import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medfind_flutter/Domain/Authentication/User.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/Repository/auth_repository.dart';

class AuthDataProvider {
  static const String _baseUrl = "http://192.168.43.190:8080/api/v1";

  Future<String> attemptLogin(String email, String password) async {
    final response = await http.post(Uri.parse("$_baseUrl/authenticate"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"username": email, "password": password}));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Authentication Failed");
    }
  }

  Future<String> signUp(User user) async {
    final response = await http.post(Uri.parse("$_baseUrl/register"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": user.email,
          "password": user.password,
          "firstName": user.firstName,
          "lastName": user.lastName
        }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Registration Failed");
    }
  }

  Future<String> getUser(String token) async {
    final response = await http.get(
        Uri.parse("http://192.168.43.190:8080/api/v1/user"),
        headers: {"Authorization": token, "Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(response.body);
    }
  }
}
