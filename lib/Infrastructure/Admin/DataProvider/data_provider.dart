import '../../../Domain/Admin/APharamcy.dart';
import '../../../Domain/Admin/User.dart';

abstract class AdminProvider {
  Future<List<User>> loadUsers();
  Future<User> loadUser(int id);
  Future<User> updateUser(User user);
  Future<bool> deleteUser(int id);
  Future<bool> changeRole(int id, String role);

  Future<List<APharmacy>> loadPharmacies();
  Future<APharmacy> loadPharmacy(int id);
  Future<APharmacy> updatePharmacy(APharmacy pharmacy);
  Future<bool> deletePharmacy(int id);
}
