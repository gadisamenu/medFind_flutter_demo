import '../../../Domain/Admin/User.dart';
import '../../../Domain/MedicineSearch/pharmacy.dart';

abstract class AdminProvider {
  Future<List> loadUsers();
  Future<User> loadUser(int id);
  Future<User> updateUser(int id, User user);
  Future<bool> deleteUser(int id);
  Future<bool> changeRole(int id, String role);

  Future<List> loadPharmacies();
  Future<Pharmacy> loadPharmacy(int id);
  Future<Pharmacy> updatePharmacy(int id, Pharmacy pharmacy);
  Future<bool> deletePharmacy(int id);
}
