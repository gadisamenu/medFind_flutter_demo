import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_bloc.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_event.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_state.dart';
import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/DataSource/medicine_search_data_source.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/Result.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/medicine_search_repository.dart';

import '../RepositoryTest/medicine_search_test.dart';

void main() async {
  group('Authentication Repository Test', () {
    late MedicineSearchBloc searchBloc;
    late MedicineSearchRepository searchRepo;

    const loading = TypeMatcher<Loading>();
    const searchFound = TypeMatcher<SearchFound>();
    const searchNotFound = TypeMatcher<SearchNotFound>();

    setUp(() {
      searchRepo = MedicineSearchRepository(MedicineSearchDataSource());
      searchBloc = MedicineSearchBloc(searchRepo);
    });
    test('initial state is SearchFound', () {
      expect(searchBloc.state, searchFound);
    });

    test('emits [Loading, SearchFound] when searching is succesfull', () async {
      searchBloc.add(Search(9.0474852, 38.7596047, "Aceon"));
      await expectLater(
          searchBloc.stream, emitsInOrder([loading, searchFound]));
    });

    test('emits [Loading, SearchNotFound] when searching is unsuccesfull',
        () async {
      searchBloc
          .add(Search(965786759.7765467890474852, 376578.7596047, "Aceon"));
      await expectLater(
          searchBloc.stream, emitsInOrder([loading, searchNotFound]));
    });
  });
}
