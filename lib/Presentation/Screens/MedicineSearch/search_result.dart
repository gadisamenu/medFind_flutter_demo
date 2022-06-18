import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_bloc.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_state.dart';
import 'package:medfind_flutter/Application/Reservation/reservation_bloc.dart';
import 'package:medfind_flutter/Application/Reservation/reservation_event.dart';
import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/_common.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/app_bar.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/bottom_navigation_bar.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/card.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SearchResult> {
  int currentIndex = 0;
  bool searchButtonPressed = false;
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 30,
                  margin: EdgeInsets.all(5),
                  child: TextField(
                    controller: textFieldController,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: InputBorder.none,
                        hintText: "type your medicine name here",
                        hintStyle: TextStyle(fontSize: 15)),
                    onSubmitted: (value) => handleSubmission(value, context),
                  ),
                ),
                getButton(100, 30, Text("Search"), () {})
              ],
            ),
            BlocBuilder<MedicineSearchBloc, MedicineSearchState>(
                builder: (context, state) {
              if (state is Loading) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                ));
              }
              if (state is SearchNotFound) {
                return Center(
                    child: Text(
                  state.error_message,
                  style: TextStyle(color: Colors.red),
                ));
              }
              return Expanded(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            (state is SearchFound && state.medicineName != null) ? "Search results for ${state.medicineName}" : "",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: state.result.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          getCard(
                              double.infinity,
                              150,
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        state.result[index].pharmacyName,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .color,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Address: ',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .color,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              state.result[index].location,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .color,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                          Positioned(
                              bottom: 30.0,
                              right: 30.0,
                              child: Row(
                                children: [
                                  getButton(100, 30, Text("reserve"), () => {
                                    if (state.medPackId != null){
                                      context.go("/reservation"),
                                      BlocProvider.of<ReservationBloc>(context).add(
                                        ReservationCreate(state.medPackId, state.result[index].pharmacyId),
                                      ),
                                    }
                                  }),
                                ],
                              )),
                        ],
                      );
                    },
                  )),
                ],
              ));
            })
          ],
        ),
        bottomNavigationBar: CustomNavigationBar());
  }

  TextInput() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(),
      );
}
