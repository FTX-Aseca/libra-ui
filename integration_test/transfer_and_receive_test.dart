import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:libra_ui/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Transfer and receive flow', (WidgetTester tester) async {
    // Launch the app
    app.main();
    await tester.pumpAndSettle();

    // Login as Alice
    await tester.enterText(find.byKey(const ValueKey('email')).first, 'alice@example.com');
    await tester.enterText(find.byKey(const ValueKey('password')).first, 'Password1!');
    await tester.tap(find.byKey(const ValueKey('login_button')));
    await tester.pumpAndSettle();
    // Should land on home
    expect(find.byKey(const ValueKey('home_screen_key')), findsOneWidget);

    // Navigate to Transfer tab
    await tester.tap(find.byIcon(Icons.swap_horiz));
    await tester.pumpAndSettle();

    // Enter Bob's alias
    final destField = find.byType(TextFormField).first;
    await tester.tap(destField);
    await tester.enterText(destField, 'happy.mountain.002');
    await tester.pumpAndSettle();

    // Continue to amount
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Enter amount to transfer
    final amountField = find.byType(TextFormField).first;
    await tester.tap(amountField);
    await tester.enterText(amountField, '10');
    await tester.pumpAndSettle();

    // Confirm transfer
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify transfer success
    expect(find.text('Transfer Successful'), findsOneWidget);

    // Logout
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('email')).first, findsOneWidget);

    // Login as Bob
    await tester.enterText(find.byKey(const ValueKey('email')).first, 'bob@example.com');
    await tester.enterText(find.byKey(const ValueKey('password')).first, 'Password2!');
    await tester.tap(find.byKey(const ValueKey('login_button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('home_screen_key')), findsOneWidget);

    // Navigate to Transactions tab
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    // Verify received transaction is shown
    expect(find.text('Received'), findsWidgets);
  });
} 