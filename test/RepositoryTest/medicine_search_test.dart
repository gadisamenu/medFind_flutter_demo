import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/DataSource/medicine_search_data_source.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/Result.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/medicine_search_repository.dart';

late MedicineSearchRepository medicineSearchRepository =
    MedicineSearchRepository(MedicineSearchDataSource());
void main() async {
  Result<List<Pharmacy>> result = await medicineSearchRepository.getPharmacies(
      9.0474852, 38.7596047, "Aceon");
  group('MedicineSearchRepository', () {
    test('returns a list of pharmacies if search is successfull', () {
      if (!result.hasError) {
        greaterThanOrEqualTo(result.val!.length);
      }
    });

    test('returns error if pharmacy is not found', () {
      if (result.hasError) {
        expect(result.error, "cann't find the result");
      }
    });
  });
}
