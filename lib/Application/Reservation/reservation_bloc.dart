import 'dart:math';

import 'package:medfind_flutter/Application/Reservation/reservation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Domain/Reservation/model.dart';
import "package:medfind_flutter/Infrastructure/Reservation/Repository/reservation_repository.dart";

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository repo;
  ReservationBloc(this.repo) : super(ReservationLoading());

  @override
  Stream<ReservationState> mapEventToState(ReservationEvent event) async* {
    if (event is LoadReservation) {
      yield ReservationLoading();
      try {
        List<Reservation> reservations =
            await ReservationRepository().getReservations();
        yield ReservationLoadSuccess(reservations);
      } catch (error) {
        yield const ReservationFailure("reservation is not loaded");
      }
    }
    if (event is DeleteReservation) {
      try {
        await ReservationRepository()
            .deleteReservation(event.reservation_id.toInt());
        List<Reservation> reservations =
            await ReservationRepository().getReservations();
        yield ReservationLoadSuccess(reservations);
      } catch (error) {
        yield const ReservationFailure("Delete reservation is failed");
      }
    }
    if (event is MedPackDelete) {
      try {
        await ReservationRepository().deleteMedPack(event.medpack_id.toInt(),
            reservation_id: event.reservation_id.toInt());
        List<Reservation> reservations =
            await ReservationRepository().getReservations();
        yield ReservationLoadSuccess(reservations);
      } catch (error) {
        yield const ReservationFailure("delete medpack is failed");
      }
    }
  }
}
