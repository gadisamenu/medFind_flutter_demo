import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/card.dart';
import '../../../Application/Admin/admin_bloc.dart';
import '../../../Domain/Admin/APharamcy.dart';

class PharmacyDetailUpdateScreen extends StatelessWidget {
  APharmacy pharmacy;

  PharmacyDetailUpdateScreen({Key? key, required this.pharmacy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminbloc = BlocProvider.of<AdminBloc>(context);
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController()..text = pharmacy.name;
    final locationController = TextEditingController()
      ..text = pharmacy.location!;
    final addressController = TextEditingController()..text = pharmacy.address;
    final ownerController = TextEditingController()..text = pharmacy.owner;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.go("/admin"),
            icon: Icon(Icons.arrow_back)),
        title: const Text("pharmacy Detail"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                adminbloc.add(DeletePharmacy(pharmacy.id));
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
              if (state is PharmacyDeleted) {
                context.go("/admin", extra: "fromUser");
              }
            },
            // buildWhen: ,
            builder: (context, state) {
              if (state is Loading) {
                return const CircularProgressIndicator();
              }
              if (state is ErrorState) {
                return Center(
                  child: Text(
                    "${state.msg}",
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              }

              if (state is PharmacyLoaded) {
                pharmacy = state.pharmacy;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container()),
                    getCard(
                        300,
                        400,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                    labelText: "name",
                                    border: UnderlineInputBorder()),
                              ),
                              TextFormField(
                                controller: addressController,
                                decoration: const InputDecoration(
                                    labelText: "address",
                                    border: OutlineInputBorder()),
                              ),
                              TextFormField(
                                controller: ownerController,
                                decoration: const InputDecoration(
                                    labelText: "owner",
                                    border: OutlineInputBorder()),
                              ),
                              TextFormField(
                                controller: locationController,
                                decoration: const InputDecoration(
                                    labelText: "location",
                                    border: OutlineInputBorder()),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final phar = APharmacy(
                                      pharmacy.id,
                                      nameController.text,
                                      ownerController.text,
                                      addressController.text,
                                      location: locationController.text);
                                  if (phar.validate()) {
                                    adminbloc.add(UpdatePharmacy(phar));
                                  } else {
                                    adminbloc.add(Error(
                                        data: pharmacy,
                                        msg:
                                            "name length must be > 5 and address length must be > 10"));
                                  }
                                },
                                child: const Text("Update"),
                              )
                            ],
                          ),
                        ),
                        margin: 40),
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
