import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_bloc.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart'
    as wl;
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Presentation/Screens/WatchList/watchlist_screen.dart';
import 'package:medfind_flutter/Presentation/Screens/config/size_config.dart';

import 'package:medfind_flutter/Presentation/_Shared/index.dart';

class PillTile extends StatelessWidget {
  final int id;

  final String name;
  int amount;
  int strength;

  final int parentId;

  PillTile({
    Key? key,
    required this.id,
    required this.parentId,
    required this.name,
    required this.strength,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchListBloc, wl.State>(
      builder: (context, state) {
        Widget messageWidget = SuccessMessage(message: '');

        if (state is wl.SuccessState &&
            state.type == wl.SuccessType.PILL_UPDATED) {
          // Pill updatedPill = wl.State.medpacks[parentId]!.pills[id]!;
          // strength = updatedPill.strength;
          // amount = updatedPill.amount;

          messageWidget = SuccessMessage(message: 'Successfully updated pill!');
        } else if (state is wl.FailureState &&
            state.type == wl.FailureType.PILL_FAILURE) {
          // messageWidget =
          //     FailureMessage(message: 'Failed to update pill. Invalid input');
        }

        return ListTile(
          selectedColor: Colors.red.shade900,
          leading: const Icon(Icons.medication),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          subtitle: Row(children: [
            Text("Strength: $strength"),
            SizedBox(
              width: getProportionateWidth(10),
            ),
            Text("Amount: $amount"),
          ]),
          trailing: Container(
              width: 80,
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.edit, size: 20),
                    onTap: () {
                      int? newAmount = amount;
                      int? newStrength = strength;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Update Pill'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: getProportionateWidth(150),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: TextFormField(
                                            initialValue: strength.toString(),
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Strength',
                                            ),
                                            onChanged: (value) {
                                              newStrength = int.parse(value);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateWidth(150),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: TextFormField(
                                            initialValue: amount.toString(),
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Amount',
                                            ),
                                            onChanged: (value) {
                                              newAmount = int.parse(value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                getButton(100, 50, Text("Update"), () {
                                  BlocProvider.of<WatchListBloc>(context).add(
                                      UpdatePill(parentId, id, newStrength!,
                                          newAmount!));

                                  GoRouter.of(context).navigator!.pop();
                                }),
                                getButton(100, 50, Text("Cancel"), () {
                                  GoRouter.of(context).navigator!.pop();
                                })
                              ],
                            );
                          });
                    },
                  ),
                  SizedBox(width: getProportionateWidth(15)),
                  GestureDetector(
                    child: Icon(Icons.remove),
                    onTap: () {
                      BlocProvider.of<WatchListBloc>(context)
                          .add(RemovePill(parentId, id));
                    },
                  ),
                ],
              )),
        );
      },
    );
  }
}
