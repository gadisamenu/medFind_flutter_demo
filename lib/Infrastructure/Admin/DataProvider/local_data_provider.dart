import 'dart:convert';

import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/data_provider.dart';

class LocalDataProvider extends AdminProvider {
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
  Future<List<Pharmacy>> loadPharmacies() async {
    return [];
  }

  @override
  Future<Pharmacy> loadPharmacy(int id) async {
    return Pharmacy(1, "updated ", "here");
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
  Future<Pharmacy> updatePharmacy(int id, Pharmacy pharmacy) async {
    return Pharmacy.fromJson(jsonDecode(pharmacy.toString()));
  }

  @override
  Future<User> updateUser(int id, User user) async {
    return user;
  }
}
