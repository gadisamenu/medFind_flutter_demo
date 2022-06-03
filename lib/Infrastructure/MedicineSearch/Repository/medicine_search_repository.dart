import 'dart:convert';

import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/DataSource/medicine_search_data_source.dart';

class MedicineSearchRepository {
  final MedicineSearchDataSource medicineSearchDataProvider;
  List<Pharmacy> pharmacies = [];
  MedicineSearchRepository(this.medicineSearchDataProvider);
  Future<List<Pharmacy>> getPharmacies(
      double latitude, double longitude, String medicineName) async {
    final result = await medicineSearchDataProvider.getPharmacy(
        latitude, longitude, medicineName);
    jsonDecode(result.body).forEach(
        (p) => pharmacies.add(Pharmacy(p['id'], p['name'], p['address'])));
    return pharmacies;
  }
}
