import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_event.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_state.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/card.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/text_field.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("medFind")),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailTextFieldController =
      TextEditingController(text: "amhaznif@gmail.com");

  final TextEditingController passwordTextFieldController =
      TextEditingController(text: "WARMACHINEROX");

  String message = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            if (state.role == "ADMIN") {
              context.go("/admin");
            } else {
              context.go("/home");
            }
          } else if (state is AuthenticationFailed) {
            setState(() {
              message = "Authentication failed";
            });
          }
        },
        child: Center(
            child: getCard(
                double.infinity,
                450,
                Container(
                  margin: EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      getTextField(
                          "Email", 50, emailTextFieldController, () {}),
                      SizedBox(
                        height: 20,
                      ),
                      getTextField(
                          "Password", 50, passwordTextFieldController, () {}),
                      SizedBox(
                        height: 20,
                      ),
                      getButton(200, 50, Text("Login"), () {
                        BlocProvider.of<AuthenticationBloc>(context).add(Login(
                            email: emailTextFieldController.text,
                            password: passwordTextFieldController.text));
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          SizedBox(
                            width: 10,
                          ),
                          getButton(100, 20, Text("Sign Up"), () {
                            context.push("/signup");
                          }),
                        ],
                      ),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: ((context, state) {
                        if (state is Authenticating) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      }))
                    ],
                  ),
                ),
                margin: 50)));
  }
}
