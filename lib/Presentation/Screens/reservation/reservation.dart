import "package:flutter/material.dart";
import 'package:medfind_flutter/Application/Reservation/reservation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/app_bar.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/card.dart';
import '../../_Shared/Widgets/bottom_navigation_bar.dart';

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
    print(reservations[0].pharmacyName);
    return ListView.builder(
      itemCount: reservations.length,
      itemBuilder: (context, index) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text("Reserved in ${reservations[index].pharmacyName}"),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: reservations[index].medPacks.length,
            itemBuilder: (context, mIdex) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                      '${reservations[index].medPacks[mIdex].description}'),
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount:
                        reservations[index].medPacks[mIdex].getPills().length,
                    itemBuilder: (context, pIdex) => Column(
                      children: [
                        Container(
                            child: Text(
                                "Medicine Name:   ${reservations[index].medPacks[mIdex].getPills()[pIdex].name}")),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Text(
                                "Strength :   ${reservations[index].medPacks[mIdex].getPills()[pIdex].strength}")),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Text(
                                "amount:   ${reservations[index].medPacks[mIdex].getPills()[pIdex].amount}")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
