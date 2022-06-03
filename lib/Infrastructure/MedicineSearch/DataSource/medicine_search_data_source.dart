import 'dart:convert';

import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:http/http.dart' as http;

class MedicineSearchDataSource {
  Future<http.Response> getPharmacy(
      double latitude, double longitude, String medicineName) async {
    http.Response result = await http.post(
      Uri.parse('http://192.168.43.190:8080/api/v1/search'),
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
}
