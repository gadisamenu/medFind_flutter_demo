import 'package:equatable/equatable.dart';
import 'package:medfind_flutter/Domain/Reservation/model.dart';

class ReservationState extends Equatable {
  const ReservationState();
  @override
  List<Object> get props => [];
}

class ReservationLoading extends ReservationState {
  const ReservationLoading();
  @override
  List<Object> get props => [];
}

class ReservationLoadSuccess extends ReservationState {
  final List<Reservation> reservations;
  ReservationLoadSuccess([this.reservations = const []]);

  @override
  List<Object> get props => [];
}

class ReservationLoadFailure extends ReservationState {
  final String message; 
  const ReservationLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
class MedPackLoadSuccess extends ReservationState {}

// class DeleteReservationsFailure extends ReservationState {
//   final String message;
//   DeleteReservationsFailure(this.message);

//   @override
//   List<Object> get props => [message];

// }
