import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/api_constants.dart';

import '_watchlist_data_provider.dart';

class HttpRemoteWatchListDataProvider implements WatchListDataProvider {
  String token =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJra21pY2hhZWxzdGFya2tAZ21haWwuY29tIiwiZXhwIjoxNjU0NDI4NzY1LCJpYXQiOjE2NTQ0MTA3NjV9.vw7zpaojKxKBoKmO0sTtA8Apm7CM4oEuN0_IqbUyvM2jHXXt-hEtWY_FhXxkWfMTIe-JVJWmGOrYunT8eR9vAA";

  @override
  Future<List<MedPack>?> getMedPacks() async {
    List<MedPack>? _medpacks = [];
    try {
      var url = Uri.parse(ApiConstants.watchListEndpoint);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      });
      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body)["medpacks"];
        // MedicineName.medicineList = jsonDecode(response.body)["medicines"];
        for (dynamic data in dataList) {
          _medpacks.add(MedPack.fromJson(data));
        }
      }
    } catch (error) {
      throw DisconnectedException("No internet connection");
    }

    if (_medpacks.isEmpty) {
      throw NoElementFoundException("No Medpacks in your watchlist");
    }
    return _medpacks;
  }

  @override
  Future<MedPack?> addNewMedpack(String description, {int? medpackId}) async {
    MedPack? _medpack;
    try {
      var url = Uri.parse(
          ApiConstants.watchListEndpoint + ApiConstants.medpackEndpoint);

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
    try {
      var url = Uri.parse(ApiConstants.watchListEndpoint +
          ApiConstants.medpackEndpoint +
          "?id=" +
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
  Future<Pill?> addNewPill(
      int medpackId, MedicineName name, int strength, int amount,
      {int? pillId}) async {
    Pill? _pill;
    try {
      var url = Uri.parse(ApiConstants.watchListEndpoint +
          ApiConstants.medpackEndpoint +
          ApiConstants.pillEndpoint +
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
    try {
      var url = Uri.parse(ApiConstants.watchListEndpoint +
          ApiConstants.medpackEndpoint +
          ApiConstants.pillEndpoint +
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
    MedPack? _updatedMedpack;
    try {
      var url = Uri.parse(ApiConstants.watchListEndpoint +
          ApiConstants.medpackEndpoint +
          "?id=" +
          medpackId.toString());

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
    Pill? _pill;
    try {
      var url = Uri.parse(ApiConstants.watchListEndpoint +
          ApiConstants.medpackEndpoint +
          ApiConstants.pillEndpoint +
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
