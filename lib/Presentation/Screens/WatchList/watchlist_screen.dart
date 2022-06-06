import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_bloc.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart'
    as wl;
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart';
import 'package:medfind_flutter/Domain/Reservation/model.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';
import 'package:medfind_flutter/Presentation/Screens/config/size_config.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/bottom_navigation_bar.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';

import 'Components/medpack_card.dart';

class WatchListScreen extends StatelessWidget {
  WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.initialize(context);
    print("initialized");
    MedPack mp = MedPack({
      10: Pill(10, MedicineName("AndreView"), 100, 15),
      12: Pill(12, MedicineName("Aceon"), 90, 20),
      8: Pill(8, MedicineName("Ivanz"), 88, 18),
      9: Pill(9, MedicineName("Abilify"), 100, 15),
      11: Pill(11, MedicineName("Asprin"), 80, 10),
      7: Pill(7, MedicineName("Amoxacilin"), 78, 16),
    });
    mp.medpackId = 1;
    mp.description = "Diabetes medicine";
    wl.State.medpacks.putIfAbsent(1, () => mp);
    return Scaffold(
      appBar: AppBar(title: const Text("WatchList")),
      bottomNavigationBar: CustomNavigationBar(),
      body: Stack(
        children: [
          Positioned(
            child: getButton(
                150,
                30,
                Row(children: const [
                  Icon(
                    Icons.add,
                    size: 20,
                    semanticLabel: "add",
                  ),
                  Text("Add medpack")
                ]), () {
              String description = '';
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Create Medpack'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Description',
                                  ),
                                  onChanged: (value) {
                                    description = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        getButton(100, 50, Text("Create"), () {
                          BlocProvider.of<WatchListBloc>(context)
                              .add(AddMedpack(description));

                          MedPack newMedpack = MedPack({});
                          newMedpack.medpackId = 5;
                          newMedpack.description = description;
                          wl.State.medpacks[5] = newMedpack;

                          GoRouter.of(context).navigator!.pop();
                        }),
                        getButton(100, 50, Text("Cancel"), () {
                          GoRouter.of(context).navigator!.pop();
                        })
                      ],
                    );
                  });
            }),
            top: 20,
            left: getProportionateWidth(30),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, getProportionateHeight(70), 0, 0),
              child: BlocBuilder<WatchListBloc, wl.State>(
                builder: (context, state) {
                  List<MedPack> medpacks = [];

                  if (state is wl.SuccessState &&
                          state.type == wl.SuccessType.MEDPACK_ADDED ||
                      state is wl.SuccessState &&
                          state.type == wl.SuccessType.MEDPACK_REMOVED) {
                    // medpacks = wl.State.medpacks.values.toList();
                    // print(medpacks);
                  }
                  medpacks = wl.State.medpacks.values.toList();

                  if (wl.State is NoMedPackState) {
                    return Column(
                      children: [
                        const Text("YOUR WATCHLIST IS EMPTY!"),
                        getButton(
                            getProportionateHeight(50),
                            getProportionateWidth(30),
                            const Icon(
                              Icons.add,
                              semanticLabel: "Add",
                            ),
                            () {}),
                      ],
                    );
                  } else {
                    return ListView(
                        scrollDirection: Axis.vertical,
                        children: List.generate(medpacks.length, (index) {
                          return MedPackCard(
                            id: medpacks[index].medpackId,
                            height: 400,
                            pills: medpacks[index].getPills(),
                          );
                        }));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
