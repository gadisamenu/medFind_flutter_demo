import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/DataSource/remote_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/Repository/auth_repository.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/api_constants.dart';

import '_watchlist_data_provider.dart';

class HttpRemoteWatchListDataProvider implements WatchListDataProvider {
  final authenRepo = AuthRepository(AuthDataProvider());
  String token =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJra21pY2hhZWxzdGFya2tAZ21haWwuY29tIiwiZXhwIjoxNjU0NDU2OTMyLCJpYXQiOjE2NTQ0Mzg5MzJ9.btDbTQ33q4v1ytYrAlhcyQA3-UkXTV857OacH3YKCigxLtfg8TDxpvsoI2KbNblPZV9p758cd_kXmzKr7NbZAw";

  @override
  Future<List<MedPack>?> getMedPacks() async {
    String token = await authenRepo.getToken();
    print(token);
    List<MedPack>? _medpacks = [];
    try {
      var url = Uri.parse(watchListEndpoint);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
        "Access-Control-Allow-Origin": "*",
      });
      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body)["medpacks"];
        // MedicineName.medicineList = jsonDecode(response.body)["medicines"];
        for (dynamic data in dataList) {
          _medpacks.add(MedPack.fromJson(data));
        }
      }
    } catch (error) {
      print(error);
      throw DisconnectedException("No internet connection");
    }

    if (_medpacks.isEmpty) {
      throw NoElementFoundException("No Medpacks in your watchlist");
    }
    return _medpacks;
  }

  @override
  Future<MedPack?> addNewMedpack(String description, {int? medpackId}) async {
    String token = await authenRepo.getToken();
    MedPack? _medpack;
    try {
      var url = Uri.parse(watchListEndpoint + medpackEndpoint);

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(<String, String>{
          'tag': description,
        }),
      );
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        _medpack = MedPack.fromJson(data);
      }
    } catch (error) {
      throw DisconnectedException("No internet connection");
    }
    return _medpack;
  }

  @override
  Future<void> removeMedpack(int medpackId) async {
    String token = await authenRepo.getToken();

    try {
      var url = Uri.parse(
          watchListEndpoint + medpackEndpoint + "?id=" + medpackId.toString());

      var response = await http.delete(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      });
      if (response.statusCode == 200) {}
    } catch (error) {
      throw DisconnectedException("No internet connection");
    }
  }

  @override
  Future<Pill?> addNewPill(
      int medpackId, MedicineName name, int strength, int amount,
      {int? pillId}) async {
    String token = await authenRepo.getToken();
    Pill? _pill;
    try {
      var url = Uri.parse(watchListEndpoint +
          medpackEndpoint +
          pillEndpoint +
          "?medpack_id=" +
          medpackId.toString());

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(<String, String>{
          'medicine_name': name.get(),
          'strength': strength.toString(),
          'amount': amount.toString()
        }),
      );
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        _pill = Pill.fromJson(data);
      }
    } catch (error) {
      throw DisconnectedException("No internet connection");
    }
    return _pill;
  }

  @override
  Future<void> removePill(int medpackId, int pillId) async {
    String token = await authenRepo.getToken();

    try {
      var url = Uri.parse(watchListEndpoint +
          medpackEndpoint +
          pillEndpoint +
          "?pill_id=" +
          pillId.toString() +
          "&medpack_id=" +
          medpackId.toString());

      var response = await http.delete(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      });
      if (response.statusCode == 200) {}
    } catch (error) {
      throw DisconnectedException("No internet connection");
    }
  }

  @override
  Future<MedPack?> updateMedpack(int medpackId, String tag) async {
    String token = await authenRepo.getToken();
    MedPack? _updatedMedpack;
    try {
      var url = Uri.parse(
          watchListEndpoint + medpackEndpoint + "?id=" + medpackId.toString());

      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(<String, String>{'tag': tag}),
      );
      int status = response.statusCode;

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        _updatedMedpack = MedPack.fromJson(data);
      }
    } catch (error) {
      throw DisconnectedException("No internet connection");
    }
    return _updatedMedpack;
  }

  @override
  Future<Pill?> updatePill(
      int medpackId, int pillId, int strength, int amount) async {
    String token = await authenRepo.getToken();
    Pill? _pill;
    try {
      var url = Uri.parse(watchListEndpoint +
          medpackEndpoint +
          pillEndpoint +
          "?pill_id=" +
          pillId.toString() +
          "&medpack_id=" +
          medpackId.toString());

      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(<String, String>{
          'strength': strength.toString(),
          'amount': amount.toString()
        }),
      );
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        _pill = Pill.fromJson(data);
      }
    } catch (error) {
      throw DisconnectedException("No internet connection");
    }
    return _pill;
  }
}
