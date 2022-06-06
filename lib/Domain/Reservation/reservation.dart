import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class Reservation {
  final int id;
  final String pharmacyName;
  List<MedPack> medPacks;
  Reservation(
    this.id,
    this.pharmacyName,
    this.medPacks,
  );

  // getPharmacyName(Pharmacy pharm) {
  //   return pharm.pharmacyName;
  // }

  // getMedPacks() {
  //   return this.medPacks;
  // }

  // addMedpack(VOMedPack medPack) {
  //   medPacks.add(medPack);
  // }

  // removeMedPhack(VOMedPack medPack) {
  //   medPacks.remove(medPack);
  // }

  factory Reservation.fromJson(Map<String, dynamic> reservationJson) {
    print(reservationJson['id']);
    print(reservationJson["medPack"]);
    print(reservationJson["pharmacy"]);
    return Reservation(
        reservationJson['id'].toInt(),
        reservationJson['pharmacy'],
        reservationJson["medpack"]);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json.addAll({
      'id': id.toString(),
      'pharmacy': pharmacyName.toString(),
      'medPack': medPacks
    });

    return json;
//
  }
}
