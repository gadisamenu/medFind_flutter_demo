import 'package:bloc/bloc.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_event.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_state.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/Result.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/medicine_search_repository.dart';

import '../../Domain/MedicineSearch/pharmacy.dart';

class MedicineSearchBloc extends Bloc<Search, MedicineSearchState> {
  final MedicineSearchRepository medicineSearchRepository;
  MedicineSearchBloc(this.medicineSearchRepository)
      : super(SearchFound("", [])) {
    on<Search>(_onSearch);
  }

  _onSearch(Search event, Emitter emit) async {
    emit(Loading());
    final Result<List<Pharmacy>> pharmacies = await medicineSearchRepository
        .getPharmacies(event.latitude, event.longitude, event.medicineName);
    if (pharmacies.hasError) {
      emit(SearchNotFound(pharmacies.error!));
    }
    emit(SearchFound(event.medicineName, pharmacies.val!));
  }
}
