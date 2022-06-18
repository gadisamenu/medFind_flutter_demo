import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';

abstract class MedicineSearchState {
  get result => null;
  get medicineName => null;
}

class Loading extends MedicineSearchState {}

class SearchFound extends MedicineSearchState {
  List<Pharmacy> result;
  @override
  String medicineName;
  SearchFound(this.medicineName, this.result);
}

class MedPackSearchFound extends MedicineSearchState {
  List<Pharmacy> result;
  @override
  MedPackSearchFound(this.result);
}

class SearchNotFound extends MedicineSearchState {
  String error_message;
  SearchNotFound(this.error_message);
}
