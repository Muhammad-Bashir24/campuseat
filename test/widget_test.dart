import 'package:flutter_test/flutter_test.dart';
import 'package:campuseat/main.dart';

void main() {
  testWidgets('CampusEatApp home screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CampusEatApp());

    // Verify key titles and sections are present.
    expect(find.text('CampusEats'), findsOneWidget);
    expect(find.text('Good afternoon, Bashir 👋'), findsOneWidget);
    expect(find.text('20% OFF first 3 orders'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Popular Near You'), findsOneWidget);
    expect(find.text('Chicken Republic'), findsOneWidget);
  });
}
