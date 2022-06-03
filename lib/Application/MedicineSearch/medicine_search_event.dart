import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_state.dart';

abstract class MedicineSearchEvent {}

class Search extends MedicineSearchEvent {
  double latitude;
  double longitude;
  String medicineName;
  Search(this.latitude, this.longitude, this.medicineName);
}
