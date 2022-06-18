import 'dart:convert';

import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/DataSource/medicine_search_data_source.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/Result.dart';

class MedicineSearchRepository {
  final MedicineSearchDataSource medicineSearchDataProvider;
  List<Pharmacy> pharmacies = [];
  MedicineSearchRepository(this.medicineSearchDataProvider);
  Future<Result<List<Pharmacy>>> getPharmacies(
      double latitude, double longitude, String medicineName) async {
    try {
      final result = await medicineSearchDataProvider.getPharmacy(
          latitude, longitude, medicineName);
      jsonDecode(result.body).forEach((p) {
        if (p == null) {
        } else if (p['id'] == null ||
            p['name'] == null ||
            p['address'] == null) {
        } else {
          pharmacies.add(Pharmacy.fromJson(p));
        }
      });
      return Result(val: pharmacies);
    } catch (e) {
      return Result(error: "No Pharmacy Found");
    }
  }


    Future<Result<List<Pharmacy>>> getPharmaciesByMedPack(
      double latitude, double longitude, int medPackId) async {
    try {
      final result = await medicineSearchDataProvider.getPharmacyByMedPack(
          latitude, longitude, medPackId);
      jsonDecode(result.body).forEach((p) {
        if (p == null) {
        } else if (p['id'] == null ||
            p['name'] == null ||
            p['address'] == null) {
        } else {
          pharmacies.add(Pharmacy.fromJson(p));
        }
      });
      return Result(val: pharmacies);
    } catch (e) {
      return Result(error: "No Pharmacy Found");
    }
  }
}
