import 'dart:convert';

import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/data_provider.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/local_database.dart';

import '../../../Domain/Admin/APharamcy.dart';

class AdminLocalProvider extends SqliteDBProvider implements AdminProvider {
  @override
  Future<bool> changeRole(int id, String role) async {
    return true;
  }

  @override
  Future<bool> deletePharmacy(int id) async {
    try {
      await delete('pharmacies', id);
      return true;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteUser(int id) async {
    try {
      await delete('users', id);
      return true;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<List<APharmacy>> loadPharmacies() async {
    try {
      final rawpharmacies = await get("pharmacies");
      List<APharmacy> pharmacies = [];
      rawpharmacies.forEach((element) {
        try {
          pharmacies.add(APharmacy.fromQuery(element));
        } catch (exp) {
          print("decoding error " + exp.toString());
        }
      });
      return pharmacies;
    } catch (exp) {
      rethrow;
    }
  }

  @override
  Future<APharmacy> loadPharmacy(int id) async {
    try {
      final pharmacy = APharmacy.fromQuery(
          getById("pharmacies", id) as Map<String, Object?>);
      return pharmacy;
    } catch (exp) {
      print("Decoding err " + exp.toString());
      rethrow;
    }
  }

  @override
  Future<User> loadUser(int id) async {
    try {
      final user = User.fromQuery(getById('users', id) as Map<String, Object?>);
      return user;
    } catch (exp) {
      rethrow;
    }
  }

  @override
  Future<List<User>> loadUsers() async {
    try {
      final rawusers = await get("users");
      List<User> users = [];
      rawusers.forEach((element) {
        try {
          users.add(User.fromQuery(element));
        } catch (exp) {
          print("decoding error " + exp.toString());
        }
      });
      return users;
    } catch (exp) {
      rethrow;
    }
  }

  @override
  Future<APharmacy> updatePharmacy(APharmacy pharmacy) async {
    try {
      update("pharmacies", pharmacy.id, "name", pharmacy.name);
      update("pharmacies", pharmacy.id, "address", pharmacy.address);
      return APharmacy.fromQuery(jsonDecode(pharmacy.toString()));
    } catch (exp) {
      rethrow;
    }
  }

  @override
  Future<User> updateUser(User user) async {
    try {
      update("users", user.id!, "firstName", user.firstName);
      update("users", user.id!, "lastName", user.lastName);
      update("users", user.id!, "email", user.email);
      update("users", user.id!, "role", user.role);
    } catch (exp) {
      rethrow;
    }

    return user;
  }

  @override
  Future<User> addUser(User user) {
    try {
      insert('users', user.toJson() as Map<String, Object>);
      throw Exception("add by remote");
    } catch (exp) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteAll(String table) {
    try {
      return clearTable(table);
    } catch (err) {
      rethrow;
    }
  }
}
