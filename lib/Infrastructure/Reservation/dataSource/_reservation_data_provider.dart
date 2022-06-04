import 'package:medfind_flutter/Domain/Reservation/model.dart';

abstract class ReservationDataProvider {
  Future<List<Reservation>> getReservations();
  // Future<Reservation?> createReservation(List medpacks, int pharmacyId,
  //     {Map<String, dynamic> data});
  Future<void> deleteMedPack(double medpack_id,double? reservation_id );
  // Future<void> addMedPack( MedPack medpacks,double reservation_id);
  Future<void> deleteReservation(double reservation_id);
}
