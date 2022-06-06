import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/card.dart';

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
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ErrorState) {
                return Center(
                  child: Text(
                    "${state.msg}",
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              }
              if (state is RoleChanged) {
                Future.delayed(const Duration(seconds: 3),
                    () => adminbloc.add(LoadUser(state.id)));

                return const Center(child: Text("Role change successful"));
              }
              if (state is ChangeFailed) {
                Future.delayed(const Duration(seconds: 3),
                    () => adminbloc.add(LoadUser(state.id)));

                return const Center(child: Text("Role change failed"));
              }
              if (state is UserLoaded) {
                user = state.user;

                final role = ["ADMIN", "USER", "PHARMACY"];

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container()),
                    getCard(
                      300,
                      650,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                              validator: (String? password) {
                                if (password!.length < 8) {
                                  return "password length must be greater 8";
                                }

                                if (!RegExp("[a-zA-Z0-9#*!;]")
                                    .hasMatch(password)) {
                                  return "password include alphanumeric and symbols";
                                }
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final form = formKey.currentState!.validate();
                                final use = User(
                                    id: user.id,
                                    email: emailController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    role: user.role,
                                    oldPassword: oldpasswordController.text,
                                    newPassword: newpasswordController.text);
                                if (user.validate()) {
                                  adminbloc.add(UpdateUser(user));
                                } else {
                                  adminbloc.add(Error(
                                      data: user,
                                      msg:
                                          "password length must be > 8 and email from must be 'example@exmap.com'"));
                                }
                                // print("");
                              },
                              child: const Text("Update"),
                            ),
                            Container(
                              color: Colors.blue,
                              padding: EdgeInsets.all(5),
                              height: 35,
                              width: 170,
                              child: ListView.builder(
                                  itemCount: role.length,
                                  itemBuilder: (_, idx) => GestureDetector(
                                        child: Text(role[idx],
                                            style: TextStyle(fontSize: 30),
                                            textAlign: TextAlign.center),
                                        onTap: () => {
                                          adminbloc.add(
                                              ChangerRole(role[idx], user.id!)),
                                        },
                                      )),
                            )
                          ],
                        ),
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
