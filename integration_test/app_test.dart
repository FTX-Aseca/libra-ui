import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:libra_ui/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('smoke test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final Finder alternateAuthButton = find.byKey(
      const Key('alternate_auth_button'),
    );
    await tester.tap(alternateAuthButton);
    await tester.pumpAndSettle();

    final email =
        'testuser-${DateTime.now().millisecondsSinceEpoch}@example.com';
    const password = 'Password*123';

    await tester.enterText(find.byKey(const ValueKey('email')), email);
    await tester.enterText(find.byKey(const ValueKey('password')), password);
    await tester.enterText(
      find.byKey(const ValueKey('confirmPassword')),
      password,
    );
    await tester.tap(find.byKey(const ValueKey('sign_up_button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('home_screen_key')), findsOneWidget);
  });
}
