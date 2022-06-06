import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/home.dart';

void main() {
  group("medicine search widget testing", () {
    testWidgets("text field widget testing", (tester) async {
      await tester.pumpWidget(Home());
      // expect(find.byType(MaterialApp), findsAtLeastNWidgets(0));
    });
  });
}
