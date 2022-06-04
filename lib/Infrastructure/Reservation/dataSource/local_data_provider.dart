import 'package:flutter/material.dart';
import 'package:medfind_flutter/Infrastructure/Reservation/dataSource/data_source.dart';
import 'package:medfind_flutter/Domain/Reservation/model.dart';
import 'package:sqflite/sqflite.dart';

class SqlfliteDatasource implements ReservationProvider {
  final Database _db;
  const SqlfliteDatasource(@required Database db) : _db = db;

  @override
  Future<List<Reservation>?> getReservations() async{
    var listOfMaps = await _db.query()
  }
  Future<Reservation?> createReservation(){}
  Future<MedPack> deleteMedPack(double reservation_id, double medpack_id){}
  Future<MedPack> addMedPack(double reservation_id, double medpack_id){}
  Future<Reservation> DeleteReservation(double reservation_id){}
}
