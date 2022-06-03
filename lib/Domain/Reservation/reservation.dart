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
  final VOPharmacy pharmacy;
  List<VOMedPack> medPacks;

  addMedpack(VOMedPack medPack) {
    medPacks.add(medPack);
  }

  removeMedPhack(VOMedPack medPack) {
    medPacks.remove(medPack);
  }
}
