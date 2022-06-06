import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Application/Admin/admin_bloc.dart';
import 'package:medfind_flutter/Domain/Admin/APharamcy.dart';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/local_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Admin/Repository/admin_repository.dart';

void main() {
  // const idle = TypeMatcher<Idle>();
  const loading = TypeMatcher<Loading>();
  const usersloaded = TypeMatcher<UsersLoaded>();
  const userloaded = TypeMatcher<UserLoaded>();
  const userdeleted = TypeMatcher<UserDeleted>();
  const rolechanged = TypeMatcher<RoleChanged>();
  const pharmloaded = TypeMatcher<PharmacyLoaded>();
  const pharmdeleted = TypeMatcher<PharmacyDeleted>();
  const pharmsloaded = TypeMatcher<PharmaciesLoaded>();

  // WidgetsFlutterBinding.ensureInitialized();
  AdminRepository adminRepo = AdminRepository(AdminLocalProvider());
  AdminBloc adminBloc = AdminBloc(adminRepo);

  // setUp(() {
  //    = WatchListBloc();
  // });

  // tearDown(() {
  //   watchListBloc!.close();
  // });NormalState

  test('start with idle', () {
    expect(adminBloc.state, Idle);
  });

  test("load users", () async {
    adminBloc.add(LoadUsers());
    await expectLater(adminBloc.stream, emitsInOrder([loading, usersloaded]));
    final users = adminBloc.state as List<User>;
    expect(users.isNotEmpty, true);
  });

  test("load user", () async {
    adminBloc.add(LoadUsers());
    final users = adminBloc.state as List<User>;
    adminBloc.add(LoadUser(users[0].id!));
    await expectLater(adminBloc.stream, emitsInOrder([loading, userloaded]));
    expect(adminBloc.state, users[0]);
  });

  test("update user", () async {
    adminBloc.add(LoadUsers());
    final users = adminBloc.state as List<User>;
    users[0].firstName += "a";
    adminBloc.add(UpdateUser(users[0]));
    await expectLater(adminBloc.stream, emitsInOrder([loading, userloaded]));
    final user = adminBloc.state as User;
    expect(user.firstName, users[0].firstName);
  });

  test("delete user", () async {
    adminBloc.add(LoadUsers());
    final users = adminBloc.state as List<User>;
    adminBloc.add(DeleteUser(users[0].id!));
    await expectLater(adminBloc.stream, emitsInOrder([loading, userdeleted]));
    expect(adminBloc.state, users[0].id);
  });

  test("change role ", () async {
    adminBloc.add(LoadUsers());
    final users = adminBloc.state as List<User>;
    adminBloc.add(ChangerRole("ADMIN", users[0].id!));
    await expectLater(adminBloc.stream, emitsInOrder([loading, rolechanged]));
  });

  test("load pharmacies", () async {
    adminBloc.add(LoadPharmacies());
    await expectLater(adminBloc.stream, emitsInOrder([loading, pharmsloaded]));
    final pharmacies = adminBloc.state as List<APharmacy>;
    expect(pharmacies.isNotEmpty, true);
  });

  test("load pharmacy", () async {
    adminBloc.add(LoadPharmacies());
    final pharmacies = adminBloc.state as List<APharmacy>;
    adminBloc.add(LoadPharmacy(pharmacies[0].id));
    await expectLater(adminBloc.stream, emitsInOrder([loading, pharmloaded]));
    expect(adminBloc.state, pharmacies[0]);
  });

  test("update pharmacy", () async {
    adminBloc.add(LoadPharmacies());
    final pharmacies = adminBloc.state as List<APharmacy>;
    pharmacies[0].name += "a";
    adminBloc.add(UpdatePharmacy(pharmacies[0]));
    await expectLater(adminBloc.stream, emitsInOrder([loading, pharmloaded]));
    final pharamcy = adminBloc.state as APharmacy;
    expect(pharamcy.name, pharmacies[0].name);
  });

  test("delete pharmacy", () async {
    adminBloc.add(LoadPharmacies());
    final pharmacies = adminBloc.state as List<APharmacy>;
    adminBloc.add(DeletePharmacy(pharmacies[0].id));
    await expectLater(adminBloc.stream, emitsInOrder([loading, pharmdeleted]));
    expect(adminBloc.state, pharmacies[0].id);
  });
}
