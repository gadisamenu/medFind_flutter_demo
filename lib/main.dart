// import 'package:flutter/material.dart';
// import 'package:medfind_flutter/Presentation/Screens/config/size_config.dart';

// import 'Presentation/_Shared/routes.dart';
// import 'Presentation/_Shared/theme.dart';

// void main() {
//   runApp(const MedFindApp());
// }

// class MedFindApp extends StatelessWidget {
//   const MedFindApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.initialize(context);
//     return MaterialApp.router(
//       routeInformationParser: MedfindRouter.router.routeInformationParser,
//       routerDelegate: MedfindRouter.router.routerDelegate,
//       debugShowCheckedModeBanner: false,
//       title: 'MedFind',
//       theme: getAppTheme(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Application/Admin/admin_bloc.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_bloc.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/local_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Admin/DataProvider/remote_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Admin/Repository/admin_repository.dart';
import 'package:medfind_flutter/Application/Navigation/navigation_bloc.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/DataSource/medicine_search_data_source.dart';
import 'package:medfind_flutter/Infrastructure/MedicineSearch/Repository/medicine_search_repository.dart';
import 'package:medfind_flutter/Presentation/_Shared/index.dart';
import 'package:medfind_flutter/Presentation/_Shared/theme.dart';
import 'Presentation/_Shared/theme.dart';
import 'Presentation/_Shared/routes.dart';

void main() {
  runApp(const MedFindApp());
}

class MedFindApp extends StatelessWidget {
  const MedFindApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SizeConfig.initialize(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminBloc>(
            create: (BuildContext context) =>
                AdminBloc(AdminRepository(AdminLocalProvider()))),
        BlocProvider<MedicineSearchBloc>(
            create: (BuildContext context) => MedicineSearchBloc(
                MedicineSearchRepository(MedicineSearchDataSource()))),
        BlocProvider<NavigationBloc>(
            create: (BuildContext context) => NavigationBloc()),
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
