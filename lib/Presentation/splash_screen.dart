import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_event.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_state.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // void goToHome() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   context.go("/home");
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        print(state.toString());
        return Column(
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
            SizedBox(height: 100),
            getButton(200, 50, Text("Get Started"), () {
              if (state is UnAuthenticated) {
                context.go("/login");
              } else if (state is AuthUninitialized || state is Authenticated) {
                context.go("/home");
              }
            }),
          ],
        );
      }),
    ));
  }
}
