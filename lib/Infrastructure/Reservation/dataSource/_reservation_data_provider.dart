import 'package:medfind_flutter/Domain/Reservation/model.dart';

abstract class ReservationDataProvider {
  Future<List<Reservation>> getReservations();
  // Future<Reservation?> createReservation(List medpacks, int pharmacyId,
  //     {Map<String, dynamic> data});
  Future<void> deleteMedPack(int medpack_id, {int? reservation_id});
  // Future<void> addMedPack( MedPack medpacks,int reservation_id);
  Future<void> deleteReservation(int reservation_id);
}
