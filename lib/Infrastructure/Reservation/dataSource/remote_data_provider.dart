import 'dart:convert';

import 'package:medfind_flutter/Domain/Reservation/model.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/DataSource/remote_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/Repository/auth_repository.dart';
import 'data_source.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/api_constants.dart';
import 'package:http/http.dart' as http;

class HttpRemoteReservationDataProvider implements ReservationDataProvider {
  final AuthRepository authRepo = AuthRepository(AuthDataProvider());

  @override
  Future<List<Reservation>> getReservations() async {
    String token =
        "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJra21pY2hhZWxzdGFya2tAZ21haWwuY29tIiwiZXhwIjoxNjU0NDc2NjE5LCJpYXQiOjE2NTQ0NTg2MTl9.wCLZdntPMQ-KGiZW4WbyjZnpsQdi6iPorSVezA-ti8dakoockDg6K7WRegSDcg3VcSNuZ9qenwb3v2Qcd6oknw";
    // print(token);
    List<Reservation> reservations = [];
    final url = Uri.parse(ReservationEndpoint);
    var response = await http.get(url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final dataList = jsonDecode(response.body);
      // print(dataList);
      List<MedPack> med = [];
      dataList.forEach((element) {
        med.add(MedPack.fromJson(element['medpack'][0]));
      });
      reservations.add(Reservation(dataList[0]['id'], dataList[0]['pharmacy'],med));
      print('here');
      return reservations;
    } else {
      throw Exception("failed to load");
    }
  }

  @override
  Future<void> deleteMedPack(int medpack_id, {int? reservation_id}) async {
    try {
      var url = Uri.parse(ReservationEndpoint +
          medpackEndpoint +
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
      var url = Uri.parse(
          ReservationEndpoint + '?reserv_id' + reservation_id.toString());
      var response = await http.delete(url);
    } catch (error) {
      print(error.toString());
    }
  }

  // Future<Reservation> createReservation(
  //     [int? medpack_id, int? pharmacy_id, Reservation? reservation]) async {
  //   Reservation? reservation;
  //   var url = Uri.parse(ReservationEndpoint +
  //       "?medpack_id=" +
  //       medpack_id.toString() +
  //       "&pharm_id = " +
  //       pharmacy_id.toString());
  //   var response = await http.post(url);
  //   if (response.statusCode == 200) {
  //     dynamic data = jsonDecode(response.body);
  //     reservation = Reservation.fromJson(data);
  //     return reservation;
  //   } else {
  //     throw Exception("create reservation failed");
  //   }
  // }
}
