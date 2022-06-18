import "package:flutter/material.dart";
import 'package:medfind_flutter/Application/Reservation/reservation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/app_bar.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/card.dart';
import '../../_Shared/Widgets/bottom_navigation_bar.dart';
import '../../_Shared/Widgets/custom_button.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
          if (state is ReservationLoading) {
            return Center(child: CircularProgressIndicator(value: 10));
          }
          if (state is ReservationFailure) {
            return Center(child: Text('Reservation Loading failed'));
          }
          if (state is ReservationLoadSuccess) {
            final reservations = state.reservations;
            return Center(child: getCard(300, 400, display(reservations)));
          }

          return SizedBox();
        },
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  Widget display(reservations) {
    return ListView.builder(
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  color: Colors.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Reserved in ${reservation.pharmacyName}"),
                      SizedBox(
                        height: 20,
                        width: 40,
                        child: Container(
                          color: Colors.blueGrey,
                          child: ElevatedButton(
                              child: Center(child: Icon(Icons.remove)),
                              onPressed: () {
                                final reservation_bloc =
                                    BlocProvider.of<ReservationBloc>(context);
                                reservation_bloc
                                    .add(DeleteReservation(reservation.id));
                              }),
                        ),
                      )
                    ],
                  ),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: reservation.medPacks.length,
              itemBuilder: (context, mIdex) {
                final medpack = reservation.medPacks[mIdex];
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('${medpack.description}'),
                            SizedBox(
                              height: 25,
                              width: 40,
                              child: Container(
                                color: Colors.blueGrey,
                                child: ElevatedButton(
                                    child: Center(child: Icon(Icons.remove)),
                                    onPressed: () {
                                      final reservation_blo =
                                          BlocProvider.of<ReservationBloc>(
                                              context);

                                      reservation_blo.add(
                                        MedPackDelete(
                                          medpack.id.toInt(),
                                          reservation.id.toInt(),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: medpack.getPills().length,
                          itemBuilder: (context, pIdex) {
                            final pill = medpack.getPills()[pIdex];

                            return ListTile(
                              leading: Icon(Icons.add),
                              title:
                                  Text("Medicine Name:   ${pill.name.get()}"),
                              subtitle: Text(
                                  "Strength :   ${pill.strength}     amount:   ${pill.amount}"),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
