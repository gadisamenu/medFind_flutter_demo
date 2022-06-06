import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medfind_flutter/Infrastructure/Reservation/dataSource/data_source.dart';
import 'package:medfind_flutter/Domain/Reservation/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/local_database.dart';


class LocalReservationDataProvider extends SqliteDBProvider
    implements ReservationDataProvider {
  @override
  Future<List<Reservation>> getReservations() async {
    final List<Map<String, dynamic?>> queryResult = await get('reservations');
    return queryResult.map((e) => Reservation.fromJson(e)).toList();
  }

  @override
  Future<Reservation> createReservation(
      [int? medpack_id, int? pharmacy_id, Reservation? reservation]) async {
    insert("reservations", reservation!.toJson());
    return reservation;
  }
 
  @override
  Future<void> deleteMedPack(int medpack_id, {int? reservation_id}) async {
    await delete('medpacks', medpack_id);
  }

  @override
  Future<void> deleteReservation(int reservation_id) async {
    delete("reservations", reservation_id);
  }
  
}
