import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Application/Admin/admin_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_bloc.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_bloc.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/remote_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Admin/Repository/admin_repository.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/DataSource/remote_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/Repository/auth_repository.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/DataSource/medicine_search_data_source.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/medicine_search_repository.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';
import 'package:medfind_flutter/Presentation/_Shared/theme.dart';

import '_Shared/theme.dart';
import '_Shared/routes.dart';

void main() {
  runApp(const MedFindApp());
}

class MedFindApp extends StatelessWidget {
  const MedFindApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MedicineSearchBloc>(
            create: (BuildContext context) => MedicineSearchBloc(
                MedicineSearchRepository(MedicineSearchDataSource()))),
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc(AuthRepository(AuthDataProvider()))),
        BlocProvider<AdminBloc>(
            create: (BuildContext context) =>
                AdminBloc(AdminRepository(AdminRemoteProvider()))),
      ],
      child: MaterialApp.router(
        routeInformationParser: MedfindRouter.router.routeInformationParser,
        routerDelegate: MedfindRouter.router.routerDelegate,
        debugShowCheckedModeBanner: false,
        title: 'MedFind',
        theme: getAppTheme(),
      ),
    );
  }
}
