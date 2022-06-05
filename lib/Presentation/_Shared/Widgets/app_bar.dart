import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_event.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_state.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/custom_button.dart';

AppBar getAppBar(BuildContext context) {
  return AppBar(
      centerTitle: false,
      title: Text(
        "medFind",
        style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: [
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: ((context, state) {
          if (state is Authenticated) {
            return getButton(50, 10, Icon(Icons.logout), () {
              BlocProvider.of<AuthenticationBloc>(context).add(Logout());
            });
          } else {
            return Row(
              children: [
                Center(
                    child: getButton(100, 10, Text("Login"), () {
                  context.go("/login");
                })),
                SizedBox(
                  width: 10,
                ),
                Center(
                    child: getButton(
                  100,
                  10,
                  Text("Sign Up"),
                  () {
                    context.go("/signup");
                  },
                )),
              ],
            );
          }
        }))
      ]);
}
