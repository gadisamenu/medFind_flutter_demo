import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_bloc.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart'
    as wl;
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart';
import 'package:medfind_flutter/Domain/Reservation/model.dart';
import 'package:medfind_flutter/Presentation/Screens/config/size_config.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/bottom_navigation_bar.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';

import 'Components/medpack_card.dart';

class WatchListScreen extends StatelessWidget {
  WatchListScreen({Key? key}) : super(key: key);

  List<MedPack> medpacks = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig.initialize(context);
    print("initialized");

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
                  Widget messageWidget = SuccessMessage(message: '');
                  medpacks = wl.State.medpacks.values.toList();
                  print(medpacks);
                  print('=>>>>>>>>>>>>>>>>>>');
                  if (state is wl.SuccessState &&
                      state.type == wl.SuccessType.MEDPACK_ADDED) {
                    messageWidget = SuccessMessage(
                        message: 'Successfully added new medpack!');
                  } else if (state is wl.SuccessState &&
                      state.type == wl.SuccessType.MEDPACK_REMOVED) {
                    messageWidget = SuccessMessage(
                        message: 'Successfully removed the medpack!');
                  } else if (wl.State is NoMedPackState) {
                    print('no medpack');
                    messageWidget = SuccessMessage(message: 'No medpacks');
                  } else if (wl.State is FailureState &&
                      wl.State == wl.FailureType.MEDPACK_FAILURE) {
                    print('failed!');
                    messageWidget = FailureMessage(
                        message: 'Failed! Try again with valid input');
                  }

                  return Column(
                    children: [
                      Flexible(
                        child: messageWidget,
                        flex: 1,
                      ),
                      Flexible(
                        flex: 16,
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: List.generate(medpacks.length, (index) {
                              return MedPackCard(
                                id: medpacks[index].medpackId,
                                height: 400,
                                pills: medpacks[index].getPills(),
                              );
                            })),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FailureMessage extends StatelessWidget {
  final message;
  const FailureMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateWidth(250),
      child: Text(
        '$message',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SuccessMessage extends StatelessWidget {
  final String message;
  const SuccessMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateWidth(250),
      child: Text(
        '$message',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
