import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/DataSource/medicine_search_data_source.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/Result.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/medicine_search_repository.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/Repository/watchlist_repository.dart';

late MedicineSearchRepository medicineSearchRepository =
    MedicineSearchRepository(MedicineSearchDataSource());
void main() async {
  Result<List<Pharmacy>> result = await medicineSearchRepository.getPharmacies(
      9.0474852, 38.7596047, "Aceon");
  group('MedicineSearchRepository', () {
    test('the list has to be returned', () {
      if (!result.hasError) {
        greaterThanOrEqualTo(result.val!.length);
      }
    });

    test('error has to be returned', () {
      if (result.hasError) {
        expect(result.error, "cann't find the result");
      }
    });
  });
}
