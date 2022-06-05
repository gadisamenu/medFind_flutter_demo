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

class MedPackDelete extends ReservationEvent {
  final int medpack_id;
  final int reservation_id;
  MedPackDelete(this.medpack_id, this.reservation_id);

  @override
  List<Object> get props => [medpack_id, reservation_id];

  @override
  String toString() =>
      "ReservationUpdated with {reservation_id: $reservation_id} by deleting  medpack{medpack_id : $medpack_id";
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
  final int reservation_id;

  DeleteReservation(this.reservation_id);

  List<Object> get props => [reservation_id];

  @override
  String toString() => 'Reservation Deleted {reservation_id: $reservation_id}';
}
