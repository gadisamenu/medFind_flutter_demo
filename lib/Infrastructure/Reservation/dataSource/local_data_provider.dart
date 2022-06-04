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
    final db = await initializeDB();

    final List<Map<String, Object?>> queryResult = await db.query('reservations');
    return queryResult.map((e) => Reservation.fromJson(e)).toList();
  }
@override
  Future<List<MedPack>?> getMedPacks() async {
    final db = await initializeDB();

    final List<Map<String, Object?>> queryResult = await db.query('medpacks');
    return queryResult.map((record) => MedPack.fromJson(record)).toList();
  }
  @override
  Future<void> deleteMedPack(double medpack_id, double? reservation_id) async {
    final db = await initializeDB();
    db.delete('medpacks', where: 'id = ?', whereArgs: [medpack_id]);
  }

  @override
  Future<void> addMedPack(MedPack medpack, double reservation_id) async {
    final db = await initializeDB();
    db.insert("reservations", {"medpack": medpack.toJson()});
  }

  @override
  Future<void> deleteReservation(double reservation_id) async {
    final db = await initializeDB();
    db.delete("reservations", where: 'id = ?', whereArgs: [reservation_id]);
  }
    // Future<void> addMedPack( MedPack medpacks,double reservation_id);
    // Future<Reservation?> createReservation(List medpacks, int pharmacyId,){}


}
