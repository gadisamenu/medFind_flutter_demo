import 'package:medfind_flutter/Domain/Reservation/model.dart';
import 'package:medfind_flutter/Infrastructure/Reservation/dataSource/data_source.dart';

class ReservationRepository {
  final HttpRemoteReservationDataProvider dataProvider =
      HttpRemoteReservationDataProvider();

  final ReservationDataProvider localDataProvider =
      LocalReservationDataProvider();

  Future<List<Reservation>> getReservations() async {
    List<Reservation> fromLocal = await localDataProvider.getReservations();
    if (fromLocal == null) {
      var fromRemote = await dataProvider.getReservations();
      return fromRemote;
    }
    return fromLocal;
  }

  Future<void> createReservation(int medpack_id, int pharmacy_id) async {
    Reservation reservation =
        await dataProvider.createReservation(medpack_id, pharmacy_id);
    await localDataProvider.createReservation(  medpack_id,  pharmacy_id , reservation);
  }

  Future<void> deleteMedPack(int medpack_id, {int? reservation_id}) async {
    try {
      await localDataProvider.deleteMedPack(medpack_id, reservation_id: null);
      await dataProvider.deleteMedPack(medpack_id,
          reservation_id: reservation_id);
    } catch (error) {
      return;
    }
  }

  Future<void> deleteReservation(int reservation_id) async {
    await localDataProvider.deleteReservation(reservation_id);
    await dataProvider.deleteReservation(reservation_id);
  }
}
