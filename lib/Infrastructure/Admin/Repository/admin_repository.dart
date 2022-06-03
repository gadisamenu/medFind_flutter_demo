import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/data_provider.dart';

import '../../../Domain/Admin/User.dart';
import '../../../Domain/MedicineSearch/pharmacy.dart';
import '../../_Shared/return_data_type.dart';

class AdminRepository {
  AdminProvider dataProvider;

  AdminRepository(this.dataProvider);

  //______________users ___________________\\

  //get list of users
  Future<Return> getUsers() async {
    try {
      final List<User> users = await dataProvider.loadUsers();
      return Return(value: users);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  //get a user
  Future<Return> getUser(int id) async {
    try {
      final User user = await dataProvider.loadUser(id);
      return Return(value: user);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  //update a user
  Future<Return> updateUser(int id, User user) async {
    try {
      final User newUser = await dataProvider.updateUser(id, user);
      return Return(value: newUser);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  // delete a user
  Future<Return> removeUser(int id) async {
    try {
      final bool removed = await dataProvider.deleteUser(id);
      return Return(value: removed);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  // change role of a user
  Future<Return> changeRole(int id, String role) async {
    try {
      final bool changed = await dataProvider.changeRole(id, role);
      return Return(value: changed);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  //__________________pharmacies__________________\\
  // get list of pharmacies
  Future<Return> getPharmacies() async {
    try {
      final List<User> users = await dataProvider.loadUsers();
      return Return(value: users);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  //get a user
  Future<Return> getPharmacy(int id) async {
    try {
      final Pharmacy pharmacy = await dataProvider.loadPharmacy(id);
      return Return(value: pharmacy);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  //update a Pharmacy
  Future<Return> updatePharmacy(int id, Pharmacy pharmacy) async {
    try {
      final Pharmacy newPharmacy =
          await dataProvider.updatePharmacy(id, pharmacy);
      return Return(value: newPharmacy);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  // delete a Pharmacy
  Future<Return> removePharmacy(int id) async {
    try {
      final bool removed = await dataProvider.deletePharmacy(id);
      return Return(value: removed);
    } catch (exp) {
      return Return(error: exp);
    }
  }
}
