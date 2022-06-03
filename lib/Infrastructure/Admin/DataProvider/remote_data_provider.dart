import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/data_provider.dart';

class RemoteDataProvider extends DataProvider {
  @override
  Future<bool> changeRole(String role) {
    // TODO: implement changeRole
    throw UnimplementedError();
  }

  @override
  Future<bool> deletePharmacy(int id) {
    // TODO: implement deletePharmacy
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<List> loadPharmacies() {
    // TODO: implement loadPharmacies
    throw UnimplementedError();
  }

  @override
  Future<Pharmacy> loadPharmacy(int id) {
    // TODO: implement loadPharmacy
    throw UnimplementedError();
  }

  @override
  Future<User> loadUser(int id) {
    // TODO: implement loadUser
    throw UnimplementedError();
  }

  @override
  Future<List> loadUsers() {
    // TODO: implement loadUsers
    throw UnimplementedError();
  }

  @override
  Future<Pharmacy> updatePharmacy(int id) {
    // TODO: implement updatePharmacy
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(int id) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
