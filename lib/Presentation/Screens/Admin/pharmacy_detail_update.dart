import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
              if (state is PharmacyLoaded) {
                pharmacy = state.pharmacy;
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
                              adminbloc.add(
                                UpdatePharmacy(
                                  APharmacy(
                                      pharmacy.id,
                                      nameController.text,
                                      ownerController.text,
                                      addressController.text,
                                      location: locationController.text),
                                ),
                              );
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
