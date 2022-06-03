import 'dart:convert';

import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/data_provider.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:medfind_flutter/Infrastructure/_Shared/token.dart';

class RemoteDataProvider extends AdminProvider {
  //User

  //fetch all users
  @override
  Future<List<User>> loadUsers() async {
    final response = await http.get(
      Uri.parse(ApiConstants.adminEndpoint + ApiConstants.usersEndpoint),
    );

    if (response.statusCode == 200) {
      List respon = jsonDecode(response.body);
      List<User> users =
          respon.map((e) => User.fromJson(jsonDecode(e))).toList();
      return users;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<User> loadUser(int id) async {
    final response = await http.get(Uri.parse(
        ApiConstants.adminEndpoint + ApiConstants.usersEndpoint + "?id=$id"));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<User> updateUser(int id, User user) async {
    final response = await http.post(
        Uri.parse(ApiConstants.adminEndpoint +
            ApiConstants.usersEndpoint +
            "?id=${user.id}"),
        headers: {"Authorization": Token().token},
        body: jsonEncode(user));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<bool> deleteUser(int id) async {
    final response = await http.delete(Uri.parse(
        ApiConstants.adminEndpoint + ApiConstants.usersEndpoint + "?id=$id"));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<bool> changeRole(int id, String role) async {
    final response = await http.post(
        Uri.parse(ApiConstants.adminEndpoint +
            ApiConstants.usersEndpoint +
            "?id=$id"),
        body: {"role": role});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.body);
    }
  }

  // Pharmacy
  @override
  Future<List<Pharmacy>> loadPharmacies() async {
    final response = await http.get(
        Uri.parse(ApiConstants.adminEndpoint + ApiConstants.pharmacyEndpoint));

    if (response.statusCode == 200) {
      List respon = jsonDecode(response.body);
      List<Pharmacy> pharmacies =
          respon.map((e) => Pharmacy.fromJson(jsonDecode(e))).toList();
      return pharmacies;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<Pharmacy> loadPharmacy(int id) async {
    final response = await http.get(Uri.parse(ApiConstants.adminEndpoint +
        ApiConstants.pharmacyEndpoint +
        "?id=$id"));

    if (response.statusCode == 200) {
      return Pharmacy.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<Pharmacy> updatePharmacy(int id, Pharmacy pharmacy) async {
    final response = await http.post(
        Uri.parse(ApiConstants.adminEndpoint +
            ApiConstants.usersEndpoint +
            "?id=${pharmacy.pharmacyId}"),
        headers: {"Authorization": Token().token},
        body: jsonEncode(pharmacy));

    if (response.statusCode == 200) {
      return Pharmacy.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<bool> deletePharmacy(int id) async {
    final response = await http.delete(Uri.parse(ApiConstants.adminEndpoint +
        ApiConstants.pharmacyEndpoint +
        "?id=$id"));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.body);
    }
  }
}
