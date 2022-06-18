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
    String token = await authRepo.getToken();

    // print(token);
    List<Reservation> reservations = [];
    final url = Uri.parse(ReservationEndpoint);
    var response = await http.get(url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final dataList = jsonDecode(response.body);
      dataList.forEach(
        (element) {
          List<MedPack> med = [];
          element['medpack'].forEach(
            (pack) {
              try {
                med.add(MedPack.fromJson(pack));
              } catch (exp) {
                print("decoding medpack error");
              }
            },
          );

          reservations.add(Reservation(int.parse(element["id"].toString()),
              element["pharmacy"].toString(), med));
        },
      );
      return reservations;
    } else {
      throw Exception("failed to load");
    }
  }

  @override
  Future<void> deleteMedPack(int medpack_id, {int? reservation_id}) async {
    String token = await authRepo.getToken();
    try {
      var url = Uri.parse(ReservationEndpoint +
          medpackEndpoint +
          "?medpack_id=" +
          medpack_id.toString() +
          "&reserv_id=" +
          reservation_id.toString());
      var response = await http.delete(url, headers: {
        "Authorization": token,
        "Content-Type": "application/json"
      });
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

  Future<Reservation> createReservation(
      [int? medpack_id, int? pharmacy_id, Reservation? reservation]) async {
    Reservation? reservation;
    var url = Uri.parse(ReservationEndpoint +
        "?medpack_id=" +
        medpack_id.toString() +
        "&pharm_id = " +
        pharmacy_id.toString());
    var response = await http.post(url);
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      reservation = Reservation.fromJson(data);
      return reservation;
    } else {
      throw Exception("create reservation failed");
    }
  }
}
