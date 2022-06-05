import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/remote_data_provider.dart';

import '../../../Domain/Admin/APharamcy.dart';
import '../../../Domain/Admin/User.dart';
import '../../_Shared/return_data_type.dart';

class AdminRepository {
  AdminProvider dataProvider;
  AdminProvider remoteprovider = AdminRemoteProvider();

  AdminRepository(this.dataProvider);

  //______________users ___________________\\

  //get list of users
  Future<Return> getUsers() async {
    try {
      List<User> users = await dataProvider.loadUsers();
      if (users.isEmpty) {
        print("here");
        users = await remoteprovider.loadUsers();
        dataProvider.deleteAll("users");
        users.forEach((element) async {
          try {
            await dataProvider.addUser(element);
          } catch (exp) {
            print(exp.toString());
          }
        });
      }

      return Return(value: users);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  //get a user
  Future<Return> getUser(int id) async {
    try {
      User user = await dataProvider.loadUser(id);
      print(user.toString());
      if (user == null) {
        User user = await remoteprovider.loadUser(id);
        dataProvider.updateUser(user);
      }
      print(user.firstName);
      return Return(value: user);
    } catch (exp) {
      print(exp.toString());
      return Return(error: exp);
    }
  }

  Future<Return> addUser(User user) async {
    try {
      User created_user = await remoteprovider.addUser(user);
      if (created_user != null) {
        dataProvider.addUser(created_user);
      }
      return Return(value: user);
    } catch (exp) {
      print(exp.toString());
      return Return(error: exp);
    }
  }

  //update a user
  Future<Return> updateUser(User user) async {
    try {
      User newUser = await remoteprovider.updateUser(user);
      dataProvider.updateUser(user);

      return Return(value: newUser);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  // delete a user
  Future<Return> removeUser(int id) async {
    try {
      final bool removed = await remoteprovider.deleteUser(id);
      if (removed) {
        dataProvider.deleteUser(id);
      }

      return Return(value: removed);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  // change role of a user
  Future<Return> changeRole(int id, String role) async {
    try {
      final bool changed = await remoteprovider.changeRole(id, role);
      if (changed) {
        dataProvider.changeRole(id, role);
      }

      return Return(value: changed);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  //__________________pharmacies__________________\\
  // get list of pharmacies
  Future<Return> getPharmacies() async {
    try {
      List<APharmacy> users = await dataProvider.loadPharmacies();
      if (users.isEmpty) {
        users = await remoteprovider.loadPharmacies();
        users.forEach((element) {
          dataProvider.updatePharmacy(element);
        });
      }

      return Return(value: users);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  //get a user
  Future<Return> getPharmacy(int id) async {
    try {
      APharmacy? pharmacy = await dataProvider.loadPharmacy(id);
      if (pharmacy == null) {
        pharmacy = await remoteprovider.loadPharmacy(id);
        dataProvider.updatePharmacy(pharmacy);
      }
      return Return(value: pharmacy);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  //update a Pharmacy
  Future<Return> updatePharmacy(APharmacy pharmacy) async {
    try {
      final APharmacy newPharmacy =
          await remoteprovider.updatePharmacy(pharmacy);
      dataProvider.updatePharmacy(pharmacy);
      return Return(value: newPharmacy);
    } catch (exp) {
      return Return(error: exp);
    }
  }

  // delete a Pharmacy
  Future<Return> removePharmacy(int id) async {
    try {
      final bool removed = await remoteprovider.deletePharmacy(id);

      if (removed) {
        dataProvider.deletePharmacy(id);
      }
      return Return(value: removed);
    } catch (exp) {
      return Return(error: exp);
    }
  }
}
