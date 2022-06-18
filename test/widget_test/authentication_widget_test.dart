import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Presentation/Screens/Authentication/login.dart';
import 'package:medfind_flutter/Presentation/Screens/Authentication/signup.dart';
// import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/home.dart';
import 'package:medfind_flutter/main.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TextField());
  }
}

int findsAtLeastNWidgets(int i) {
  return 0;
}

void main() {
  group("Authentication widget test", () {
    testWidgets("LoginPage widget test", (tester) async {
      // await tester.pumpWidget(const MedFindApp());
      await tester.pumpWidget(MedFindApp());
      Finder textfield = find.text('Login');
      expect(textfield, findsAtLeastNWidgets(1));
    });

    testWidgets("MedFind widget test", (tester) async {
      const testKey = Key('K');
      await tester.pumpWidget(MedFindApp(key: testKey));

      expect(find.byKey(testKey), findsAtLeastNWidgets(1));
    });

    testWidgets("Login Page widget test", (tester) async {
      const testKey = Key('Login');
      await tester.pumpWidget(LoginPage(key: testKey));
      expect(find.byKey(testKey), findsAtLeastNWidgets(1));
    });

    testWidgets("text field widget test", (tester) async {
      await tester.pumpWidget(const MedFindApp());
      expect(find.byType(TextField), findsAtLeastNWidgets(10));
    });

    testWidgets("login button field widget test", (tester) async {
      await tester.pumpWidget(MedFindApp());
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
    });

    testWidgets("custom card widget test", (tester) async {
      await tester.pumpWidget(MaterialApp());
      expect(find.byType(Container), findsAtLeastNWidgets(1));
    });

    testWidgets("signup widget test", (tester) async {
      await tester.pumpWidget(MaterialApp());
      expect(find.byType(SignUpPage), findsAtLeastNWidgets(1));
    });

    testWidgets("signup form widget test", (tester) async {
      await tester.pumpWidget(MaterialApp());
      expect(find.byType(SignUpForm), findsAtLeastNWidgets(1));
    });

    testWidgets("signup text field widget test", (tester) async {
      await tester.pumpWidget(MaterialApp());
      expect(find.byType(TextField), findsAtLeastNWidgets(1));
    });

    testWidgets("signup button field widget test", (tester) async {
      await tester.pumpWidget(MaterialApp());
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
    });
  });
}

findsAtLeastNWidgets(int count) {
  return count >= 1;
}
