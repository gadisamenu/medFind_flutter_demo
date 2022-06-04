import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medfind_flutter/Domain/Reservation/model.dart';

abstract class ReservationEvent extends Equatable {
  ReservationEvent();
}

class LoadReservation extends ReservationEvent {
  LoadReservation();
  @override
  List<Object> get props => [];
}

class ReservationUpdate extends ReservationEvent {
  final Reservation reservation;
  ReservationUpdate(this.reservation);

  @override
  List<Object> get props => [reservation];

  @override
  String toString() => "ReservationUpdate {reservation: $reservation}";
}

class ReservationCreate extends ReservationEvent {
  final Reservation reservation;

  ReservationCreate(this.reservation);

  @override
  List<Object> get props => [reservation];

  @override
  String toString() => 'Reservation Created {reservation : reservation}';
}

class DeleteReservation extends ReservationEvent {
  final Reservation reservation;

  DeleteReservation(this.reservation);

  List<Object> get props => [reservation];

  @override
  String toString() => 'Reservation Deleted {reservation: $reservation}';
}

// class DeleteMedPack extends ReservationEvent {
//   final MedPack medPack;
//   DeleteMedPack(this.medPack);

//   @override
//   List<MedPack> get props => [medPack];
// }
