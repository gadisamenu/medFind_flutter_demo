import 'dart:convert';

import 'package:medfind_flutter/Domain/Authentication/User.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/DataSource/remote_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static SharedPreferences? _storage;
  final AuthDataProvider _dataProvider;

  AuthRepository(this._dataProvider);

  Future<String> authenticate({
    required String email,
    required String password,
  }) async {
    final token = await _dataProvider.attemptLogin(email, password);
    return token;
  }

  Future<void> signUp(User user) async {
    await _dataProvider.signUp(user);
  }

  Future<void> deleteToken() async {
    _storage = await getSharedPreference();
    await _storage?.remove('token');
  }

  Future<void> persistToken(String token) async {
    _storage = await getSharedPreference();
    await _storage?.setString('token', token);
  }

  Future<bool> hasToken() async {
    _storage = await getSharedPreference();
    bool checkToken = _storage!.containsKey('token');
    return checkToken;
  }

  Future<SharedPreferences> getSharedPreference() {
    return SharedPreferences.getInstance();
  }

  Future<String> getToken() async {
    var _refer = await getSharedPreference();
    String? token = _refer.getString('token');
    token ??= "";
    return "Bearer $token";
  }

  Future<User> getUser() async {
    String token = await getToken();
    var response = await _dataProvider.getUser(token);
    return User.fromJson(jsonDecode(response));
  }
}
