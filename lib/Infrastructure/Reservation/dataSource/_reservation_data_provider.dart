import 'package:medfind_flutter/Domain/Reservation/model.dart';

abstract class ReservationProvider {
  Future<List<Reservation>?> getReservations();
  Future<Reservation?> createReservation();
  Future<MedPack> deleteMedPack(double reservation_id, double medpack_id);
  Future<MedPack> addMedPack(double reservation_id, double medpack_id);
  Future<Reservation> DeleteReservation(double reservation_id);
  
}
