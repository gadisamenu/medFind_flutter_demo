import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class Reservation {
  Reservation(
    this.id,
    @required this.pharmacy,
    @required this.medPacks,
  );

  final double id;
  final Pharmacy pharmacy;
  List<VOMedPack> medPacks;

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
    List<dynamic> medPacks = reservationJson['medPacks'];
    Map<int, VOMedPack> medPackss = {};
    for (dynamic medPack in medPacks) {
      VOMedPack parsedVOMedPack = VOMedPack(MedPack.fromJson(medPack));
      medPackss.putIfAbsent(parsedVOMedPack.get().medpackId, () => parsedVOMedPack);
    }
    Pharmacy pharm = reservationJson['pharmacy'];
    double reservation_id = reservationJson['reservation_id'];
    return Reservation(reservation_id, pharm, medPackss.values.toList());
  }

  Map<String, Object> toJson() {
    List<String> medPackMaps = [];
    for (VOMedPack medPack in medPacks) {
      medPackMaps.add(medPack.toString());
    }
    return {
      'id': id,
      'pharmacy': pharmacy,
      'medPacks': {medPackMaps.toString()},
    };
  }
}
