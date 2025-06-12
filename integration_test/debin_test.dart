import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:libra_ui/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DEBIN success flow', (WidgetTester tester) async {
    // Launch the app
    app.main();
    await tester.pumpAndSettle();

    // Login with seeded account
    await tester.enterText(
      find.byKey(const ValueKey('email')).first,
      'alice@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('password')).first,
      'Password1!',
    );
    await tester.tap(find.byKey(const ValueKey('login_button')));
    await tester.pumpAndSettle();
    // Verify home screen
    expect(find.byKey(const ValueKey('home_screen_key')), findsOneWidget);

    // Navigate to the Transfer page
    final transferNavIcon = find.byIcon(Icons.swap_horiz);
    await tester.tap(transferNavIcon);
    await tester.pumpAndSettle();

    // Select DEBIN operation
    await tester.tap(find.text('DEBIN'));
    await tester.pumpAndSettle();

    // Enter alias starting with A for a successful DEBIN
    final aliasField = find.byType(TextFormField).first;
    await tester.tap(aliasField);
    await tester.enterText(aliasField, 'AlphaAlias');
    await tester.pumpAndSettle();

    // Continue to the amount step
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Enter the DEBIN amount
    final amountField = find.byType(TextFormField).first;
    await tester.tap(amountField);
    await tester.enterText(amountField, '10');
    await tester.pumpAndSettle();

    // Confirm the DEBIN request
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    // Allow time for processing
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify that the DEBIN completed confirmation is shown
    expect(find.text('DEBIN Completed'), findsOneWidget);

    // Finish and return to the initial step
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
  });
}
