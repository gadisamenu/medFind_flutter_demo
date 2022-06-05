import 'dart:convert';

import 'package:medfind_flutter/Domain/Reservation/model.dart';
import 'data_source.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/api_constants.dart';
import 'package:http/http.dart' as http;

class HttpRemoteReservationDataProvider implements ReservationDataProvider {
  @override
  Future<List<Reservation>> getReservations() async {
    List<Reservation> reservations = [];
    final url = Uri.parse(ApiConstants.ReservationEndpoint);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      for (dynamic data in dataList) {
        reservations.add(Reservation.fromJson(data));
      }
      return reservations;
    } else {
      throw Exception("failed to load");
    }
  }

  @override
  Future<void> deleteMedPack(int medpack_id, {int? reservation_id}) async {
    try {
      var url = Uri.parse(ApiConstants.ReservationEndpoint +
          ApiConstants.medpackEndpoint +
          "?medpack_id=" +
          medpack_id.toString() +
          "&reserv_id=" +
          reservation_id.toString());
      var response = await http.delete(url);
      if (response.statusCode == 200) {}
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Future<void> deleteReservation(int reservation_id) async {
    try {
      var url = Uri.parse(ApiConstants.ReservationEndpoint +
          '?reserv_id' +
          reservation_id.toString());
      var response = await http.delete(url);
    } catch (error) {
      print(error.toString());
    }
  }
}
