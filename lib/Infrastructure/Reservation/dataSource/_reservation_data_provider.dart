import 'package:medfind_flutter/Domain/Reservation/model.dart';

abstract class ReservationDataProvider {
  Future<List<Reservation>> getReservations();
  Future<Reservation> createReservation([int medpack_id, int pharmacy_id ,Reservation reservation]);
  Future<void> deleteMedPack(int medpack_id, {int? reservation_id});
  Future<void> deleteReservation(int reservation_id);
}
