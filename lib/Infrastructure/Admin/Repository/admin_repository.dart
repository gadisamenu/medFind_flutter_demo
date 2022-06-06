import 'dart:convert';

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
      List<User>? users;
      try {
        users = await dataProvider.loadUsers();
      } catch (exp) {
        print(exp.toString());
      }

      if (users!.isEmpty) {
        print("remote");
        users = await remoteprovider.loadUsers();
        // users = jsonDecode(users.toString());
        // return Return(value: users);
        dataProvider.deleteAll("users");
        print(users.toString() + "_________________________");
        users.forEach((element) {
          try {
            dataProvider.addUser((element));
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
      User? user;
      try {
        user = await dataProvider.loadUser(id);
      } catch (exp) {
        print(exp.toString());
      }

      print("Here ______________________________________");

      if (user == null) {
        user = await remoteprovider.loadUser(id);
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
      User? created_user;
      created_user = await remoteprovider.addUser(user);

      try {
        dataProvider.addUser(created_user);
      } catch (exp) {
        print(exp.toString());
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
      try {
        dataProvider.updateUser(user);
      } catch (exp) {
        print("local update failed");
      }

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
        try {
          dataProvider.deleteUser(id);
        } catch (exp) {
          print("local update failed");
        }
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
        try {
          dataProvider.changeRole(id, role);
        } catch (exp) {
          print("local update failed");
        }
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
      APharmacy? pharmacy;
      try {
        pharmacy = await dataProvider.loadPharmacy(id);
      } catch (exp) {
        print("local update failed");
      }

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
      try {
        dataProvider.updatePharmacy(pharmacy);
      } catch (exp) {
        print("local update failed");
      }

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
