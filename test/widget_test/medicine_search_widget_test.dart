import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
    testWidgets(
      "LoginPage widget test",
      (tester) async {
        const key = Key("home");
        await tester.pumpWidget(MaterialApp());
        Finder textfield = find.byKey(key);
        expect(textfield, findsAtLeastNWidgets(1));
      },
    );
  });
}
