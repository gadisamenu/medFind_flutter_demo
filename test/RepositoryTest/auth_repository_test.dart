import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Domain/Authentication/User.dart';
import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/DataSource/remote_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/Repository/auth_repository.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/DataSource/medicine_search_data_source.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/Result.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/medicine_search_repository.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/Repository/watchlist_repository.dart';

late AuthRepository authRepository = AuthRepository(AuthDataProvider());
void main() async {
  group('Authentication Repository Test', () {
    test('token has to be generated', () async {
      String result = await authRepository.authenticate(
          email: "kkmichaelstarkk@gmail.com", password: '12345678');
      expect(result, isA<String>());
    });

    test('Exception should be thrown', () {
      expect(() async {
        await authRepository.authenticate(
            email: "kkmichaelstarkk@gmail.com", password: '12345678io');
      }, throwsA(isA<Exception>()));
    });

    test('successfull signup', () async {
      expect(
          () async => authRepository.signUp(
              User("tony", "rogers", "tony@gmail.com", '12345678', "USER")),
          isA<void>());
    });

    test('Exception should be thrown', () {
      expect(
          () async => authRepository.signUp(
              User("bruce", "banner", "bruce@gmail.com", '12345678', "USER")),
          throwsA(isA<Exception>()));
    });
  });
}
