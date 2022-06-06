import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/Admin/admin_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_event.dart';
import 'package:medfind_flutter/Domain/Admin/APharamcy.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/app_bar.dart';

import '../../../Domain/Admin/User.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminbloc = BlocProvider.of<AdminBloc>(context)..add(LoadUsers());
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(
        children: [
          Column(children: [
            Card(
                elevation: 3,
                child: Container(
                  height: 37,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        adminbloc.add(LoadUsers());
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Users",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            )
                          ]),
                    )),
                    SizedBox(
                        height: 40,
                        width: 2,
                        child: Container(color: Colors.black)),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        adminbloc.add(LoadPharmacies());
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Pharmacies",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ))
                  ]),
                ))
          ]),
          Expanded(
            child: Center(
              child: BlocConsumer<AdminBloc, AdminState>(
                // listenWhen: ((previous, current) => current == UserLoaded),
                listener: (_, AdminState state) {
                  if (state is UserLoaded) {
                    context.go("/admin/user_details", extra: state.user);
                  }

                  if (state is PharmacyLoaded) {
                    context.go("/admin/pharmacy_details",
                        extra: state.pharmacy);
                  }
                },
                buildWhen: ((previous, current) => current != UserLoaded),
                builder: (_, AdminState state) {
                  if (state is Loading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is UsersLoaded) {
                    return displayUsers(state);
                  }

                  if (state is PharmaciesLoaded) {
                    return displayPharmacies(state);
                  }
                  if (state is UpdateFailed) {
                    return Text(state.msg!);
                  }

                  if (state is LoadingFailed) {
                    return Text(state.msg!);
                  }
                  return const Text("should be happend ");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget displayUsers(UsersLoaded state) {
  final users = state.users;
  // print(users.length);
  return ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, int idx) {
      User user = users[idx];
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3.5),
        elevation: 1,
        shadowColor: Colors.blueAccent,
        child: ListTile(
          leading: GestureDetector(
              child: const Icon(Icons.person),
              onTap: () {
                BlocProvider.of<AdminBloc>(context).add(LoadUser(user.id!));
              }
              // context.go("/admin/user_details", extra: user),
              ),
          title: GestureDetector(
              child: Text(user.firstName + " " + user.lastName),
              onTap: () {
                BlocProvider.of<AdminBloc>(context).add(LoadUser(user.id!));
              }),
          subtitle: Text(user.email),
        ),
      );
    },
  );
}

Widget displayPharmacies(PharmaciesLoaded state) {
  final pharmacies = state.pharmacies;
  return ListView.builder(
    itemCount: pharmacies.length,
    itemBuilder: (context, int idx) {
      APharmacy pharmacy = pharmacies[idx];
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3.5),
        elevation: 1,
        shadowColor: Colors.blueAccent,
        child: ListTile(
          leading: GestureDetector(
              child: const Icon(Icons.home),
              onTap: () {
                BlocProvider.of<AdminBloc>(context).add(LoadUser(pharmacy.id));
              }),
          title: GestureDetector(
              child: Text(pharmacy.name),
              onTap: () {
                BlocProvider.of<AdminBloc>(context)
                    .add(LoadPharmacy(pharmacy.id));
              }),
          subtitle: Text(pharmacy.address),
        ),
      );
    },
  );
}
