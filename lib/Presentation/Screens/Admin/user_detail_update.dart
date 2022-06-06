import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../Application/Admin/admin_bloc.dart';
import '../../../Domain/Admin/User.dart';

class UserDetailUpdateScreen extends StatelessWidget {
  User user;

  UserDetailUpdateScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminbloc = BlocProvider.of<AdminBloc>(context);
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController()..text = user.email;
    final firstNameController = TextEditingController()..text = user.firstName;
    final lastNameController = TextEditingController()..text = user.lastName;
    final oldpasswordController = TextEditingController();
    final newpasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Detail"),
        leading: IconButton(
            onPressed: () => context.go("/admin"),
            icon: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                adminbloc.add(DeleteUser(user.id!));
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: BlocConsumer<AdminBloc, AdminState>(
            listener: (_, AdminState state) {
              if (state is UserDeleted) {
                context.go("/admin");
              }
            },
            // buildWhen: ,
            builder: (context, state) {
              if (state is Loading) {
                return const CircularProgressIndicator();
              }
              if (state is UserLoaded) {
                user = state.user;
                final fields = {
                  "firstName": firstNameController,
                  "lastName": lastNameController,
                  "email": emailController,
                  "role": user.role,
                  "old password": oldpasswordController,
                  "new password": newpasswordController
                };
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container()),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 81, 141, 190),
                              width: 1.5,
                              style: BorderStyle.solid),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      height: 400,
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            controller: firstNameController
                              ..text = user.firstName,
                            decoration: const InputDecoration(
                                labelText: "firstName",
                                border: UnderlineInputBorder()),
                          ),
                          TextFormField(
                            controller: lastNameController,
                            decoration: const InputDecoration(
                                labelText: "lastName",
                                border: OutlineInputBorder()),
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                labelText: "email",
                                border: OutlineInputBorder()),
                          ),
                          TextFormField(
                            initialValue: user.role,
                            decoration: const InputDecoration(
                                labelText: "role",
                                border: OutlineInputBorder()),
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: oldpasswordController,
                            decoration: const InputDecoration(
                                labelText: "old password",
                                border: OutlineInputBorder()),
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: newpasswordController,
                            decoration: const InputDecoration(
                                labelText: "new password",
                                border: OutlineInputBorder()),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              adminbloc.add(UpdateUser(User(
                                  id: user.id,
                                  email: emailController.text,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  role: user.role,
                                  oldPassword: oldpasswordController.text,
                                  newPassword: newpasswordController.text)));
                              // print("");
                            },
                            child: const Text("Update"),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                );
              }

              if (state is UpdateFailed) {
                return Text(state.msg!);
              }
              return Text("Shouldn't happen");
            },
          ),
        ),
      ),
    );
  }
}
