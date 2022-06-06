import "package:flutter/material.dart";
import 'package:medfind_flutter/Application/Reservation/reservation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Reservations')),
        body: BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
          if (state is ReservationFailure) {
            return Text('Reservation Loading failed');
          }
          if (state is ReservationLoadSuccess) {
            final reservations = state.reservations;
            // print("object");

            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: reservations.length,
                itemBuilder: (context, index) => Container(
                      child: Container(
                          color: Color.fromARGB(255, 240, 89, 89),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                    "Reserved in ${reservations[index].pharmacyName}"),
                              ),
                              ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      reservations[index].medPacks.length,
                                  itemBuilder: (context, mIdex) => Container(
                                          child: Container(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  child: Text(
                                                      '${reservations[index].medPacks[mIdex].description}')),
                                              Container(
                                                  child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: reservations[index]
                                                    .medPacks[mIdex].getPills()
                                                    .length,
                                                itemBuilder: (context, pIdex) =>
                                                    Column(
                                                  children: [
                                                    Container(
                                                        child: Text(
                                                            "Medicine Name:   ${reservations[index].medPacks[mIdex].getPills()[pIdex].name}")),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                        child: Text(
                                                            "Medicine Name:   ${reservations[index].medPacks[mIdex].getPills()[pIdex].strength}")),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                        child: Text(
                                                            "Medicine Name:   ${reservations[index].medPacks[mIdex].getPills()[pIdex].amount}")),
                                                  ],
                                                ),
                                              ))
                                            ]),
                                      )))
                            ],
                          )),
                    ));
          }
          BlocProvider.of<ReservationBloc>(context).add(LoadReservation());
          return SizedBox();
          // return CircularProgressIndicator();
        }));
  }
}
