import 'dart:convert';

import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/DataSource/medicine_search_data_source.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/Result.dart';

class MedicineSearchRepository {
  final MedicineSearchDataSource medicineSearchDataProvider;
  // final Result Result;
  List<Pharmacy> pharmacies = [];
  MedicineSearchRepository(this.medicineSearchDataProvider);
  Future<Result<List<Pharmacy>>> getPharmacies(
      double latitude, double longitude, String medicineName) async {
    try {
      final result = await medicineSearchDataProvider.getPharmacy(
          latitude, longitude, medicineName);
      jsonDecode(result.body).forEach(
          (p) => pharmacies.add(Pharmacy.fromJson(p)));
      return Result(val: pharmacies);
    } catch (e) {
      return Result(error: "cann't find the result");
    }
  }
}
