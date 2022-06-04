import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';

import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/api_constants.dart';

import '_watchlist_data_provider.dart';

class HttpRemoteWatchListDataProvider implements WatchListDataProvider {
  String token =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJra21pY2hhZWxzdGFya2tAZ21haWwuY29tIiwiZXhwIjoxNjU0MzQ3NDI2LCJpYXQiOjE2NTQzMjk0MjZ9.08jNICcEMovUKDAdiEUHmudYYvd_LspN_Y8JQCe-0-Iy3crQhpABx80Pk1ADgnAT6e6q5jvAwXd47c9RFm8Pig";

  Future<List<Pharmacy>?> searchMedicines(int medpackId) async {
    List<Pharmacy>? _pharmacies;

    double userlat = 30.34034;
    double userlon = 27.02334;

    try {
      var url = Uri.parse(ApiConstants.watchListEndpoint +
          ApiConstants.searchEndpoint +
          "?medpack_id=" +
          medpackId.toString());

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(<String, String>{
          'userlat': userlat.toString(),
          'userlong': userlon.toString()
        }),
      );
      if (response.statusCode == 200) {
        List<Pharmacy> _pharmacies = [];
        List<dynamic> dataList = jsonDecode(response.body);
        for (dynamic data in dataList) {
          _pharmacies.add(Pharmacy.fromJson(data));
        }
        return _pharmacies;
      }
    } catch (error) {
      print(error.toString());
    }
    return _pharmacies;
  }

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
        List<dynamic> dataList = jsonDecode(response.body);
        for (dynamic data in dataList) {
          _medpacks.add(MedPack.fromJson(data));
        }
      }
    } catch (error) {
      print(error.toString());
    }
    return _medpacks;
  }

  @override
  Future<MedPack?> addNewMedpack(String description, {int? medpackId}) async {
    MedPack? _medpack;
    try {
      var url = Uri.parse(
          ApiConstants.watchListEndpoint + ApiConstants.medpackEndpoint);
      print(token);
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
      print(error.toString());
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
      print(error.toString());
    }
  }

  @override
  Future<Pill?> addNewPill(
      int medpackId, MedicineName name, int strength, int amount,
      {int? pillId}) async {
    Pill? _pill;
    try {
      var url = Uri.parse(ApiConstants.watchListEndpoint +
          ApiConstants.medpackEndpoint+
          ApiConstants.pillEndpoint+
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
      print(error.toString());
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
      print(error.toString());
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
      print(status);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        _updatedMedpack = MedPack.fromJson(data);
        print(_updatedMedpack);
      }
    } catch (error) {
      print(error.toString());
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
      print(error.toString());
    }
    return _pill;
  }
}
