import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'model.dart';

@immutable
class Reservation {
  Reservation(
    this.id,
    @required this.pharmacy,
    @required this.user,
    @required this.medPacks,
  );

  final double id;
  final Pharmacy pharmacy;
  final User user;
  List<MedPack> medPacks;

  addMedpack( MedPack medPack ){
    medPacks.add(medPack);
  }
  removeMedPhack(MedPack medPack){
    medPacks.remove(medPack);
  }
}
