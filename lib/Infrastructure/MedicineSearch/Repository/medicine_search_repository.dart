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
      // jsonDecode(result.body).forEach((p) => print(p));
      jsonDecode(result.body).forEach((p) {
        if (p == null) {
          print("null value");
        } else if (p['id'] == null ||
            p['name'] == null ||
            p['address'] == null) {
          print("found null value $p");
        } else {
          pharmacies.add(Pharmacy.fromJson(p));
        }
      });
      // print(pharmacies);
      return Result(val: pharmacies);
    } catch (e) {
      return Result(error: "cann't find the result");
    }
  }
}
