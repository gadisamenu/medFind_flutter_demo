import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Application/Admin/admin_bloc.dart';

import '../../../Domain/Admin/User.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Screent"),
      ),
      body: Center(
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (_, AdminState state) {
            if (state is Loading) {
              return CircularProgressIndicator();
            }
            if (state is UsersLoaded) {
              final users = state.users;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, int idx) {
                  User user = users[idx];
                  return Card(
                    child: Column(children: [
                      Text(user.firstName),
                      Text(user.lastName),
                      Text(user.email),
                      Text(user.id.toString()),
                    ]),
                  );
                },
              );
            }
            return const Text("should be happend");
          },
        ),
      ),
    );
  }
}
