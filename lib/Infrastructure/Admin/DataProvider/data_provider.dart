import '../../../Domain/Admin/User.dart';
import '../../../Domain/MedicineSearch/pharmacy.dart';

abstract class DataProvider {
  Future<List> loadUsers();
  Future<User> loadUser(int id);
  Future<User> updateUser(int id);
  Future<bool> deleteUser(int id);
  Future<bool> changeRole(String role);

  Future<List> loadPharmacies();
  Future<Pharmacy> loadPharmacy(int id);
  Future<Pharmacy> updatePharmacy(int id);
  Future<bool> deletePharmacy(int id);
}
