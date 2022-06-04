import 'dart:convert';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/data_provider.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:medfind_flutter/Infrastructure/_Shared/token.dart';

import '../../../Domain/Admin/APharamcy.dart';

class AdminRemoteProvider extends AdminProvider {
  //User

  //fetch all users
  @override
  Future<List<User>> loadUsers() async {
    final response = await http.get(
        Uri.parse(ApiConstants.adminEndpoint + ApiConstants.usersEndpoint),
        headers: {
          "Authorization": Token().token,
          "Content-Type": "application/json"
        });

    print(response.statusCode);

    if (response.statusCode == 200) {
      final respon = jsonDecode(response.body);
      // print(respon);

      List<User> users = [];
      respon.forEach((element) {
        try {
          users.add(User.fromJson(element));
        } catch (erro) {
          print("decoding errro " + erro.toString());
        }
      });
      print('passed');
      return users;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<User> loadUser(int id) async {
    final response = await http.get(
        Uri.parse(ApiConstants.adminEndpoint +
            ApiConstants.usersEndpoint +
            "?id=$id"),
        headers: {
          "Authorization": Token().token,
          "Content-Type": "application/json"
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<User> updateUser(User user) async {
    final response = await http.put(
        Uri.parse(ApiConstants.adminEndpoint +
            ApiConstants.usersEndpoint +
            "?id=${user.id}"),
        headers: {
          "Authorization": Token().token,
          "Content-Type": "application/json"
        },
        body: jsonEncode(user.toJson()));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<bool> deleteUser(int id) async {
    final response = await http.delete(
        Uri.parse(ApiConstants.adminEndpoint +
            ApiConstants.usersEndpoint +
            "?id=$id"),
        headers: {
          "Authorization": Token().token,
          "Content-Type": "application/json"
        });

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
        headers: {
          "Authorization": Token().token,
          "Content-Type": "application/json"
        },
        body: {
          "role": role
        });

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.body);
    }
  }

  // Pharmacy
  @override
  Future<List<APharmacy>> loadPharmacies() async {
    final response = await http.get(
        Uri.parse(ApiConstants.adminEndpoint + ApiConstants.pharmacyEndpoint),
        headers: {
          "Authorization": Token().token,
          "Content-Type": "application/json"
        });

    if (response.statusCode == 200) {
      List respon = jsonDecode(response.body);
      List<APharmacy> pharmacies = [];
      respon.forEach((element) {
        try {
          pharmacies.add(APharmacy.fromJson(element));
        } catch (erro) {
          print("Decoding error" + erro.toString());
        }
      });
      return pharmacies;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<APharmacy> loadPharmacy(int id) async {
    final response = await http.get(
        Uri.parse(ApiConstants.adminEndpoint +
            ApiConstants.pharmacyEndpoint +
            "?id=$id"),
        headers: {
          "Authorization": Token().token,
          "Content-Type": "application/json"
        });

    if (response.statusCode == 200) {
      return APharmacy.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<APharmacy> updatePharmacy(APharmacy pharmacy) async {
    final response = await http.put(
        Uri.parse(ApiConstants.adminEndpoint +
            ApiConstants.pharmacyEndpoint +
            "?id=${pharmacy.id}"),
        headers: {
          "Authorization": Token().token,
          "Content-Type": "application/json"
        },
        body: jsonEncode(pharmacy.toJson()));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return APharmacy.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<bool> deletePharmacy(int id) async {
    final response = await http.delete(
        Uri.parse(ApiConstants.adminEndpoint +
            ApiConstants.pharmacyEndpoint +
            "?id=$id"),
        headers: {
          "Authorization": Token().token,
          "Content-Type": "application/json"
        });

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.body);
    }
  }
}
