import 'dart:convert';

import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/data_provider.dart';

import '../../../Domain/Admin/APharamcy.dart';

class AdminLocalProvider extends AdminProvider {
  @override
  Future<bool> changeRole(int id, String role) async {
    return true;
  }

  @override
  Future<bool> deletePharmacy(int id) async {
    return false;
  }

  @override
  Future<bool> deleteUser(int id) async {
    return false;
  }

  @override
  Future<List<APharmacy>> loadPharmacies() async {
    return [];
  }

  @override
  Future<APharmacy> loadPharmacy(int id) async {
    return APharmacy(
      1,
      "updated ",
      "me",
      "here",
    );
  }

  @override
  Future<User> loadUser(int id) async {
    return User(
        role: "role",
        email: "email",
        firstName: "firstname",
        lastName: "lastname");
  }

  @override
  Future<List<User>> loadUsers() async {
    return [];
  }

  @override
  Future<APharmacy> updatePharmacy(APharmacy pharmacy) async {
    return APharmacy.fromJson(jsonDecode(pharmacy.toString()));
  }

  @override
  Future<User> updateUser(User user) async {
    return user;
  }
}
