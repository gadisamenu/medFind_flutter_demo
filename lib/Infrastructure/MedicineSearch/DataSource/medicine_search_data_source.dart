import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medfind_flutter/Infrastructure/_Shared/api_constants.dart';

class MedicineSearchDataSource {
  Future<http.Response> getPharmacy(
      double latitude, double longitude, String medicineName) async {
    http.Response result = await http.post(
      Uri.parse(medsearchEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userlat': "$latitude",
        'userlong': "$longitude",
        'medicineName': medicineName
      }),
    );
    return result;
  }

  Future<http.Response> getPharmacyByMedPack(
      double latitude, double longitude, int medPackId) async {
    http.Response result = await http.post(
      Uri.parse("${baseUrl}watchlist/search?medPackId=${medPackId}"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userlat': "$latitude",
        'userlong': "$longitude",
      }),
    );
    return result;
  }
}
