import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Domain/Admin/APharamcy.dart';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/local_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Admin/Repository/admin_repository.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/return_data_type.dart';

final AdminRepository adminRepo = AdminRepository(AdminLocalProvider());
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('testing load users', loadUsersTest);
  test('testing load user', loadUserTest);

  test('testing update user', updateUserTest);
  test('testing delete user', deleteUserTest);

  test('testing change role', changeRoleTest);
  test('testing load pharmacies', loadPharmacysTest);
  test('testing update pharmacy', loadPharmacyTest);
  test('testing delete pharmacy', updatePharmacyTest);
  test('testing load pharmacy', deletePharmacyTest);
}

User createUser() {
  return User(
    email: "gman@here.com",
    firstName: "gman",
    lastName: "here",
    role: "USER",
    password: "12345678",
  );
}

loadUsersTest() async {
  User user = createUser();
  Return data = await adminRepo.addUser(user);
  Return users = await adminRepo.getUsers();

  final listUsers = users.value as List<User>;
  expect(true, listUsers.contains(data.value as User));
}

loadUserTest() async {
  Return data = await adminRepo.addUser(createUser());
  final userN = data.value as User;
  data = await adminRepo.getUser(userN.id!);
  final userR = data.value as User;

  expect(userN.id!, userR.id!);
}

updateUserTest() async {
  adminRepo.addUser(createUser());
  Return data = await adminRepo.getUsers();
  final userList = data.value as List<User>;
  userList[0].firstName += "a";
  data = await adminRepo.updateUser(userList[0]);

  final userR = data.value as User;

  expect(userList[0].firstName, userR.firstName);
}

deleteUserTest() async {
  adminRepo.addUser(createUser());
  Return data = await adminRepo.getUsers();
  final userList = data.value as List<User>;
  data = await adminRepo.removeUser(userList[0].id!);
  final state = data.value as bool;
  expect(true, state);
}

changeRoleTest() async {
  adminRepo.addUser(createUser());
  Return data = await adminRepo.getUsers();
  final userList = data.value as List<User>;
  data = await adminRepo.changeRole(userList[0].id!, "ADMIN");
  expect(userList[0].role, "ADMIN");
}

loadPharmacysTest() async {
  Return pharmacy = await adminRepo.getPharmacies();
  final listPharmacy = pharmacy.value as List<APharmacy>;
  assert(listPharmacy.isNotEmpty);
}

loadPharmacyTest() async {
  Return data = await adminRepo.getPharmacies();
  final pharmacyN = data.value as List<APharmacy>;
  data = await adminRepo.getPharmacy(pharmacyN[0].id);
  final pharmacyR = data.value as APharmacy;
  expect(pharmacyN[0].id, pharmacyR.id);
}

updatePharmacyTest() async {
  Return data = await adminRepo.getPharmacies();
  final pharmacyN = data.value as List<APharmacy>;
  pharmacyN[0].name += "a";
  data = await adminRepo.updatePharmacy(pharmacyN[0]);
  final pharmacyR = data.value as APharmacy;
  expect(pharmacyN[0].name, pharmacyR.name);
}

deletePharmacyTest() async {
  Return data = await adminRepo.getPharmacies();
  final pharmacyList = data.value as List<APharmacy>;
  data = await adminRepo.removePharmacy(pharmacyList[0].id);
  final state = data.value as bool;
  expect(true, state);
}
