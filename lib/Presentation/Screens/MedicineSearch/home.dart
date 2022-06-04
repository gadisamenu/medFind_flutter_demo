import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../Application/MedicineSearch/medicine_search_bloc.dart';
import '../../../Application/MedicineSearch/medicine_search_event.dart';
import '../../_Shared/Widgets/bottom_navigation_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                        color: Theme.of(context)
                            .textTheme
                            .headline6!
                            .backgroundColor,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "Find",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline6!.color,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search", hintStyle: TextStyle(fontSize: 15)
                      // border: InputBorder(),
                      ),
                  onSubmitted: (value) => {
                        if (value.length > 0)
                          {
                            context.go("/search"),
                            BlocProvider.of<MedicineSearchBloc>(context).add(
                              Search(9.0474852, 38.7596047, value),
                            ),
                          }
                      }),
            ),
          ],
        )),
        bottomNavigationBar: CustomNavigationBar());
  }
}


// Container(
//           heigColor.fromARGB(255, 27, 15, 14)/           width: double.infinity,
//           margin: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromARGB(112, 0, 0, 0),
//                   offset: Offset.fromDirection(0.8, 50.0),
//                   blurRadius: 50.0,
//                 )
//               ]),
//         ),