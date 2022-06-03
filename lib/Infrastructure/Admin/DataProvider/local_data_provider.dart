import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/data_provider.dart';

class LocalDataProvider extends DataProvider {
  @override
  Future<bool> changeRole(String role) async {
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
  Future<List> loadPharmacies() async {
    return [];
  }

  @override
  Future<Pharmacy> loadPharmacy(int id) async {
    return Pharmacy(1, "th", "here");
  }

  @override
  Future<User> loadUser(int id) async {
    return User("email", "firstname", "lastname");
  }

  @override
  Future<List> loadUsers() async {
    return [];
  }

  @override
  Future<Pharmacy> updatePharmacy(int id) async {
    return Pharmacy(1, "updated ", "here");
  }

  @override
  Future<User> updateUser(int id) async {
    return User("email", "updated", "Here");
  }
}
