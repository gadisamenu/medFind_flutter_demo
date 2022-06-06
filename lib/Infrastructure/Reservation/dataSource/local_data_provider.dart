import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medfind_flutter/Infrastructure/Reservation/dataSource/data_source.dart';
import 'package:medfind_flutter/Domain/Reservation/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/local_database.dart';

// class SqlfliteDatasource implements ReservationProvider {
//   final Database _db;
//   const SqlfliteDatasource(@required Database db) : _db = db;

//   @override
//   Future<List<Reservation>?> getReservations() async{
//     var listOfMaps = await _db.query()
//   }
//   Future<Reservation?> createReservation(){}
//   Future<MedPack> deleteMedPack(double reservation_id, double medpack_id){}
//   Future<MedPack> addMedPack(double reservation_id, double medpack_id){}
//   Future<Reservation> DeleteReservation(double reservation_id){}
// }
class LocalReservationDataProvider extends SqliteDBProvider
    implements ReservationDataProvider {
  @override
  Future<List<Reservation>> getReservations() async {
    final List<Map<String, dynamic?>> queryResult = await get('reservations');
    return queryResult.map((e) => Reservation.fromJson(e)).toList();
  }

  // @override
  // Future<Reservation> createReservation(
  //     [int? medpack_id, int? pharmacy_id, Reservation? reservation]) async {
  //   // insert("reservations", reservation!.toJson());
  //   return reservation;
  // }
 
  @override
  Future<void> deleteMedPack(int medpack_id, {int? reservation_id}) async {
    delete('medpacks', medpack_id);
  }

  @override
  Future<void> deleteReservation(int reservation_id) async {
    delete("reservations", reservation_id);
  }
  // @override
  // Future<void> addMedPack(List<MedPack> medpack, int reservation_id) async {
  //   updateFields("reservations", reservation_id, medPacks, medpack);
  // }

  // Future<void> addMedPack( MedPack medpacks,double reservation_id);
  // Future<Reservation?> createReservation(List medpacks, int pharmacyId,){}

}
