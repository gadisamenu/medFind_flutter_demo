import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_bloc.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_event.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_state.dart';
import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';

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
        // key: _scaffoldKey,
        body: Column(
          children: [
            Container(
              height: 100.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    width: MediaQuery.of(context).size.width,
                    height: 70.0,
                    child: Center(
                      child: Text(
                        "medFind",
                        style: TextStyle(
                            color:
                                Theme.of(context).appBarTheme.foregroundColor),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0)),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1234523.0),
                            border: Border.all(
                                color: Colors.transparent, width: 1.0),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 30,
                                margin: EdgeInsets.all(1),
                                child: TextField(
                                    controller: textFieldController,
                                    decoration: InputDecoration(
                                        hintText: "Search",
                                        hintStyle: TextStyle(fontSize: 15)
                                        // border: InputBorder(),
                                        ),
                                    onSubmitted: (value) =>
                                        handleSubmission(value, context)),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                if (textFieldController.text.length > 0) {
                                  handleSubmission(
                                      textFieldController.text, context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<MedicineSearchBloc, MedicineSearchState>(
                  builder: (context, state) {
                if (state is Loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is SearchNotFound) {
                  return Center(child: Text(state.error_message));
                }
                return ListView.builder(
                  itemCount: state.result.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // padding: const EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: ListTile(
                        // tileColor: Colors.blue,
                        title: Text(state.result[index].pharmacyName),
                        subtitle: Text(state.result[index].location),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
        bottomNavigationBar: null);

    // return Scaffold(
    //     appBar: AppBar(
    //       centerTitle: false,
    //       title: Text(
    //         "medFind",
    //         style: Theme.of(context).primaryTextTheme.headline6,
    //       ),
    //       actions: [
    //         searchButtonPressed
    //             ? Center(child: Container(width: 300, child: TextInput()))
    //             : SizedBox(),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: IconButton(
    //             icon: Icon(
    //               Icons.search,
    //               size: 30,
    //             ),
    //             onPressed: () {
    //               setState(() {
    //                 searchButtonPressed = !searchButtonPressed;
    //               });
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //     body: Stack(children: [
    //       // searchButtonPressed ? TextInput() : SizedBox(),
    //       Column(
    //         children: [
    //           BlocBuilder<medicine_search_bloc, medicine_search_state>(
    //               builder: (context, state) {
    //             return Container();
    //           })
    //         ],
    //       ),
    //     ]),
    //     bottomNavigationBar: BottomNavigationBar(
    //         // backgroundColor: Colors.cyanAccent,
    //         selectedItemColor: Colors.cyan,
    //         unselectedItemColor: Colors.cyan,
    //         currentIndex: currentIndex,
    //         onTap: (index) => setState(() => currentIndex = index),
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.search),
    //             label: "home",
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.list),
    //             label: "watchlist",
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.card_travel),
    //             label: "reserved",
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.account_circle),
    //             label: "profile",
    //           )
    //         ]));
  }

  Set<Set<void>> handleSubmission(String value, BuildContext context) {
    return {
      if (value.length > 0)
        {
          BlocProvider.of<MedicineSearchBloc>(context).add(
            Search(9.0474852, 38.7596047, value),
          ),
        }
    };
  }

  TextInput() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(),
      );
}
