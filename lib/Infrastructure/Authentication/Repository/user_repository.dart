import 'package:medfind_flutter/Infrastructure/Authentication/DataSource/remote_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static SharedPreferences? _storage;
  final AuthDataProvider _dataProvider;

  UserRepository(this._dataProvider);

  Future<String> authenticate({
    required String email,
    required String password,
  }) async {
    final token = await _dataProvider.attemptLogin(email, password);
    return token;
  }

  Future<void> deleteToken() async {
    await _storage?.remove('token');
  }

  Future<void> persistToken(String token) async {
    _storage = await SharedPreferences.getInstance();
    await _storage?.setString('token', token);
  }

  Future<bool> hasToken() async {
    bool checkToken = _storage!.containsKey('token');
    return checkToken;
  }
}
