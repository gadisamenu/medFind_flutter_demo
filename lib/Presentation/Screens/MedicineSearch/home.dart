import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_state.dart';
import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/_common.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/app_bar.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/text_field.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';

import '../../_Shared/Widgets/bottom_navigation_bar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var currentIndex = 0;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          context.go("/login");
        }
      },
      child: Scaffold(
          appBar: getAppBar(
            context,
          ),
          body: Center(
              key: const Key("home"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("med",
                            key: Key("med"),
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          "Find",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline2!.color,
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
                          child: getTextField(
                              "Search",
                              400,
                              this.textFieldController,
                              () => handleSubmission(
                                  textFieldController.text, context))),
                      getButton(
                          200.0,
                          50.0,
                          Text("Search"),
                          () => {
                                handleSubmission(
                                    textFieldController.text, context)
                              })
                    ],
                  ),
                ],
              )),
          bottomNavigationBar: CustomNavigationBar()),
    );
  }
}
