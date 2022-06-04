import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/_common.dart';
import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/search_result.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';

import '../../../Application/MedicineSearch/medicine_search_bloc.dart';
import '../../../Application/MedicineSearch/medicine_search_event.dart';
import '../../_Shared/Widgets/bottom_navigation_bar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final textFieldController = TextEditingController(text: "Aceon");
  @override
  Widget build(BuildContext context) {
    var currentIndex = 0;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "medFind",
            style:
                TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("med",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "Find",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                  child: TextField(
                      controller: textFieldController,
                      decoration: const InputDecoration(
                          hintText: "Type medicine name here",
                          hintStyle: TextStyle(fontSize: 15)),
                      onSubmitted: (value) => {
                            handleSubmission(textFieldController.text, context)
                          }),
                ),
                getButton(200.0, 50.0, Text("Search"),
                    () => {handleSubmission(textFieldController.text, context)})
              ],
            ),
          ],
        )),
        bottomNavigationBar: CustomNavigationBar());
  }
}
