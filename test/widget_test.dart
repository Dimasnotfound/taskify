import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskify/features/auth/presentation/pages/login_page.dart';

void main() {
  group('Login Page Widget Test', () {
    testWidgets('Check if Login Page displays correctly',
        (WidgetTester tester) async {
      // Build LoginPage widget
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      // Check if "Email" text field exists
      expect(find.byType(TextField),
          findsNWidgets(2)); // Two TextFields (email and password)

      // Check if "Login" button exists
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('Enter email and password, then tap Login button',
        (WidgetTester tester) async {
      // Build LoginPage widget
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      // Find TextFields and Button
      final emailField = find.byType(TextField).at(0);
      final passwordField = find.byType(TextField).at(1);
      final loginButton = find.text('Login');

      // Enter text into the email field
      await tester.enterText(emailField, 'user1@example.com');
      expect(find.text('user1@example.com'), findsOneWidget);

      // Enter text into the password field
      await tester.enterText(passwordField, 'password');
      expect(find.text('password'), findsOneWidget);

      // Tap the Login button
      await tester.tap(loginButton);

      // Trigger a frame
      await tester.pump();
    });
  });
}
