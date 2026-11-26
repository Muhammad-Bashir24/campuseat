import 'package:flutter_test/flutter_test.dart';
import 'package:campuseat/main.dart';
import 'package:campuseat/home_screen.dart';
import 'package:campuseat/splash_screen.dart';

void main() {
  testWidgets('CampusEatApp splash screen and navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CampusEatApp());

    // Initially on splash screen
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('CampusEats'), findsOneWidget);
    expect(find.text('Fast Campus Delivery • Hot & Fresh'), findsOneWidget);

    // Advance time past the splash duration (1800ms entrance + 800ms hold) to trigger navigation
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    // Now on home screen
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Good afternoon, Bashir 👋'), findsOneWidget);
    expect(find.text('20% OFF first 3 orders'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Popular Near You'), findsOneWidget);
    expect(find.text('Chicken Republic'), findsOneWidget);
  });
}
