import 'dart:async';
import 'dart:math';

import 'package:medfind_flutter/Application/Reservation/reservation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Domain/Reservation/model.dart';
import "package:medfind_flutter/Infrastructure/Reservation/Repository/reservation_repository.dart";

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository repo = ReservationRepository();
  late ReservationState reservationState;
  ReservationBloc() : super(ReservationLoading()) {
    on<LoadReservation>(_getReservations);
    on<DeleteReservation>(_deleteReservations);
    on<MedPackDelete>(_deleteMedPack);
    on<ReservationCreate>(_createReservation);
  }
  Future<void> _getReservations(LoadReservation event, Emitter emit) async {
    emit(ReservationLoading());
    try {
      List<Reservation>? reservations = await repo.getReservations();
      emit(ReservationLoadSuccess(reservations));
    } catch (error) {
      emit(ReservationFailure("Reservation load failer"));
    }
  }

  Future<void> _deleteReservations(
      DeleteReservation event, Emitter emit) async {
    try {
      await repo.deleteReservation(event.reservation_id.toInt());
      List<Reservation>? reservations = await repo.getReservations();
      emit(ReservationLoadSuccess(reservations));
    } catch (error) {
      emit(ReservationFailure("Delete reservation is failed"));
    }
  }

  Future<void> _createReservation(ReservationCreate event, Emitter emit) async {
    try {
      await repo.createReservation(
          event.medpack_id.toInt(), event.pharmacy_id.toInt());
      List<Reservation>? reservations = await repo.getReservations();
      emit(ReservationLoadSuccess(reservations));
    } catch (error) {
      emit(ReservationFailure("delete medpack is failed"));
    }
  }

  Future<void> _deleteMedPack(MedPackDelete event, Emitter emit) async {
    print("here");
    try {
      await repo.deleteMedPack(event.medpack_id.toInt());
      List<Reservation>? reservations = await repo.getReservations();
      emit(ReservationLoadSuccess(reservations));
    } catch (error) {
      emit(ReservationFailure("delete medpack is failed"));
    }
  }
}
