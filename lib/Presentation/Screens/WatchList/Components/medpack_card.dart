import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_bloc.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_bloc.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart'
    as wl;

import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Presentation/Screens/WatchList/watchlist_screen.dart';
import 'package:medfind_flutter/Presentation/Screens/config/size_config.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/card.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';

import 'pill_tile.dart';

class MedPackCard extends StatelessWidget {
  double height;
  int id;
  List<Pill> pills;

  MedPackCard(
      {Key? key, required this.id, required this.height, required this.pills})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateHeight(10),
          horizontal: getProportionateWidth(10)),
      child: getCard(
        getProportionateWidth(800),
        height,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<WatchListBloc, wl.State>(
              builder: (context, state) {
                pills = wl.State.medpacks[id]!.getPills();
                Widget messageWidget = SuccessMessage(message: '');

                if (state is wl.SuccessState &&
                    state.type == wl.SuccessType.PILL_CREATED) {
                  messageWidget =
                      SuccessMessage(message: 'Successfully created new pill');
                } else if (state is wl.SuccessState &&
                    state.type == wl.SuccessType.PILL_REMOVED) {
                  messageWidget = SuccessMessage(
                    message: 'Successfully removed the pill!',
                  );
                } else if (state is wl.SuccessState &&
                    state.type == wl.SuccessType.PILL_UPDATED) {
                  messageWidget = SuccessMessage(
                    message: 'Successfully updated the pill!',
                  );
                } else if (state is wl.FailureState) {
                  messageWidget =
                      FailureMessage(message: 'Invalid input try again!');
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 30),
                          child: Text(
                            wl.State.medpacks[id]!.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: GestureDetector(
                            child: const Icon(Icons.search),
                            onTap: () {
                              BlocProvider.of<MedicineSearchBloc>(context).add(
                                  SearchMedPack(9.0474852, 38.7596047, id));
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        messageWidget,
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: height - 100),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: pills.length,
                              itemBuilder: (context, index) {
                                return PillTile(
                                    id: pills[index].pillId,
                                    parentId: id,
                                    name: pills[index].name.get(),
                                    strength: pills[index].strength,
                                    amount: pills[index].amount);
                              }),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            Align(
              alignment: const Alignment(-0.9, 0.9),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: getButton(
                          100,
                          30,
                          Row(
                            children: const [
                              Icon(
                                Icons.add,
                                size: 20,
                                semanticLabel: "add",
                              ),
                              Text("Add Pill")
                            ],
                          ), () {
                        String? newMedicineName;
                        int? newAmount;
                        int? newStrength;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Add Pill'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Medicine Name',
                                            ),
                                            onChanged: (value) {
                                              newMedicineName = value;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Strength',
                                            ),
                                            onChanged: (value) {
                                              newStrength = int.parse(value);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Amount',
                                            ),
                                            onChanged: (value) {
                                              newAmount = int.parse(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  getButton(100, 50, Text("Add"), () {
                                    BlocProvider.of<WatchListBloc>(context).add(
                                        AddPill(id, newMedicineName!,
                                            newStrength!, newAmount!));
                                    GoRouter.of(context).navigator!.pop();
                                  }),
                                  getButton(100, 50, Text("Cancel"), () {
                                    GoRouter.of(context).navigator!.pop();
                                  })
                                ],
                              );
                            });
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child:
                          getButton(150, 30, const Text("Remove medpack"), () {
                        BlocProvider.of<WatchListBloc>(context)
                            .add(RemoveMedpack(id));
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
