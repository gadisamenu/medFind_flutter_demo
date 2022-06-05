import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_event.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_state.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/card.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/form.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/text_field.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("medFind")),
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

  final TextEditingController emailTextFieldController =
      TextEditingController(text: 'stark@gmail.com');
  final TextEditingController passwordTextFieldController =
      TextEditingController(text: '12345678');
  final TextEditingController checkPasswordTextFieldController =
      TextEditingController(text: '12345678');
  final TextEditingController firstNameTextFieldController =
      TextEditingController(text: 'tony');
  final TextEditingController lastNameTextFieldController =
      TextEditingController(text: 'stark');
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: ((context, state) {
        if (state is UnAuthenticated) {
          context.go("/login");
        }
      }),
      child: Center(
          child: getCard(
              double.infinity,
              550,
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    getForm(
                        _formKey,
                        Column(
                          children: [
                            getTextFormField(
                                "First Name", 50, firstNameTextFieldController,
                                () {
                              if (firstNameTextFieldController.text.length ==
                                  0) {
                                return "first name must not be empty";
                              }
                              return null;
                            }),
                            SizedBox(
                              height: 5,
                            ),
                            getTextFormField(
                                "Last Name", 50, lastNameTextFieldController,
                                () {
                              if (lastNameTextFieldController.text.length ==
                                  0) {
                                return "last name must not be empty";
                              }
                              return null;
                            }),
                            SizedBox(
                              height: 5,
                            ),
                            getTextFormField(
                                "Email", 50, emailTextFieldController, () {
                              if (emailTextFieldController.text.length == 0) {
                                return "email must not be empty";
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailTextFieldController.text)) {
                                return "invalid email";
                              }
                              return null;
                            }),
                            SizedBox(
                              height: 5,
                            ),
                            getTextFormField(
                                "Password", 50, passwordTextFieldController,
                                () {
                              if (passwordTextFieldController.text.length < 8) {
                                return "password must be atleast 8 characters";
                              }
                              return null;
                            }, obsecurity: true),
                            SizedBox(
                              height: 5,
                            ),
                            getTextFormField("Confirm Password", 50,
                                checkPasswordTextFieldController, () {
                              if (passwordTextFieldController.text !=
                                  checkPasswordTextFieldController.text) {
                                return "password doesn't match";
                              }
                              return null;
                            }, obsecurity: true),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )),
                    getButton(200, 40, Text("Sign Up"), () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AuthenticationBloc>(context).add(Signup(
                            firstNameTextFieldController.text,
                            lastNameTextFieldController.text,
                            emailTextFieldController.text,
                            passwordTextFieldController.text,
                            "USER"));
                      }
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("already haver an account?"),
                        SizedBox(
                          width: 10,
                        ),
                        getButton(100, 20, Text("Login"), () {
                          context.push("/login");
                        }),
                      ],
                    ),
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: ((context, state) {
                      if (state is SigningUp) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is SignUpFailed) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Signup failed",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    }))
                  ],
                ),
              ),
              margin: 50)),
    );
  }
}
