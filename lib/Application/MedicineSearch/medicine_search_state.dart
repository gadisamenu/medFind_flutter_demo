import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';

abstract class MedicineSearchState {
  get result => null;
  get medicineName => null;

  get medPackId => null;
}

class Loading extends MedicineSearchState {}

class SearchFound extends MedicineSearchState {
  List<Pharmacy> result;
  @override
  String? medicineName;
  int? medPackId;
  SearchFound(this.result, {this.medicineName = null, this.medPackId = null});
}

class SearchNotFound extends MedicineSearchState {
  String error_message;
  SearchNotFound(this.error_message);
}
