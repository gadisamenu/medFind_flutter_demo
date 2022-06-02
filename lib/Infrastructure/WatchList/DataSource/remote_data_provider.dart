import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';

import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Infrastructure/Shared/api_constants.dart';

abstract class RemoteWatchListDataProvider {
  Future<List<MedPack>?> getMedPacks();
  Future<MedPack?> addNewMedpack(String description);
  Future<void> removeMedpack(int medpackId);
}

class HttpRemoteWatchListDataProvider implements RemoteWatchListDataProvider {
  @override
  Future<List<MedPack>?> getMedPacks() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.watchlistEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // List<MedPack> _medpacks = MedPack.fromJson(response.body);
        // return _medpacks;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<MedPack?> addNewMedpack(String description) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.watchlistEndpoint);

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'tag': description,
        }),
      );
      if (response.statusCode == 200) {
        MedPack _medpack = MedPack.fromJson(response.body);
        return _medpack;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<void> removeMedpack(int medpackId) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.watchlistEndpoint);

      var response = await http.delete(url);
      if (response.statusCode == 200) {}
    } catch (error) {
      print(error.toString());
    }
  }
}
