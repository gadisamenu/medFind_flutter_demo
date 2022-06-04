import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';

abstract class MedicineSearchState {
  get result => null;
}

class Loading extends MedicineSearchState {}

class SearchFound extends MedicineSearchState {
  List<Pharmacy> result;
  SearchFound(this.result);
}

class SearchNotFound extends MedicineSearchState {
  String error_message;
  SearchNotFound(this.error_message);
}
