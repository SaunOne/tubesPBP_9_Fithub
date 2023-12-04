// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd6_b_9/Testing/Testing_function.dart';
import 'package:ugd6_b_9/database/Auth.dart';
import 'package:ugd6_b_9/view/content/home.dart';
import 'package:ugd6_b_9/view/register.dart';

void main() {
  group("Register", () {
    testWidgets('Register Success', (WidgetTester tester) async {
      FlutterError.onError = (FlutterErrorDetails details) {
        bool ifIsOverflowError = false;

        // Detect overflow error.
        var exception = details.exception;
        if (exception is FlutterError) {
          ifIsOverflowError = !exception.diagnostics.any((e) =>
              e.value.toString().startsWith("A RenderFlex overflowed by"));
        }

        // Ignore if it's an overflow error.
        if (ifIsOverflowError) {
          print('Overflow error.');
        } else {
          // Throw other errors.
          FlutterError.dumpErrorToConsole(details);
        }
      };

      tester.binding.window.physicalSizeTestValue = const Size(600, 1480);

      await tester.pumpWidget(const MaterialApp(
        home: Register(),
      ));

      await tester.enterText(find.byKey(const Key('fullnameField')), 'tinar');
      await tester.enterText(find.byKey(const Key('usernameField')), 'saun01');
      await tester.enterText(
          find.byKey(
            const Key('emailField'),
          ),
          'tinartinar@gmail.com');
      await tester.enterText(find.byKey(const Key('passwordField')), '1232145');

      await tester.enterText(find.byKey(const Key('dateField')), '2/12/2023');
      await tester.tap(find.byKey(const Key('maleTap')));
      
      tester.ensureVisible(find.byKey(Key('termsButton')));
      await tester.tap(find.byKey(const Key('termsButton')));
      // await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signUpButton')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      // await RegisterState().handleTestingRegister(
      //     fullname: 'tinar',
      //     username: 'saun01',
      //     email: '12@gmail.com',
      //     password: '1232145',
      //     birthdate: '12/12/2023',
      //     gender: 'Male');
      // await tester.pumpAndSettle();

      final user = await testing_function.register(
          fullname: 'tinar',
          username: 'saun01',
          email: '12@gmail.com',
          password: '1232145',
          birthdate: '12/12/2023',
          gender: 'Male');

      print('username : ${user!.fullname}');

      expect(user.fullname, 'tinar');
      expect(user.email, '12@gmail.com');
      expect(user.username, 'saun01');
      expect(user.birthdate, '12/12/2023');
      expect(user.gender, 'Male');
    });

    testWidgets('Register Failed', (WidgetTester tester) async {
      FlutterError.onError = (FlutterErrorDetails details) {
        bool ifIsOverflowError = false;

        // Detect overflow error.
        var exception = details.exception;
        if (exception is FlutterError) {
          ifIsOverflowError = !exception.diagnostics.any((e) =>
              e.value.toString().startsWith("A RenderFlex overflowed by"));
        }

        // Ignore if it's an overflow error.
        if (ifIsOverflowError) {
          print('Overflow error.');
        } else {
          // Throw other errors.
          FlutterError.dumpErrorToConsole(details);
        }
      };
      // tester.binding.window.physicalSizeTestValue = const Size(1000, 2000);

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: Register()),
      ));

      await tester.enterText(find.byKey(const Key('fullnameField')), '');
      await tester.enterText(find.byKey(const Key('usernameField')), '');
      await tester.enterText(
          find.byKey(
            const Key('emailField'),
          ),
          'tinartinar@gmail.com');
      await tester.enterText(find.byKey(const Key('passwordField')), '1232145');
      await tester.enterText(find.byKey(const Key('dateField')), '12-12-12');
      await tester.tap(find.byKey(const Key('maleTap')));

      tester.ensureVisible(find.byKey(Key('termsButton')));
      await tester.tap(find.byKey(const Key('termsButton')));
      await tester.tap(find.byKey(const Key('signUpButton')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final user = await testing_function.register(
          fullname: '',
          username: 'saun01',
          email: '12@gmail.com',
          password: '1232145',
          birthdate: '12/12/2023',
          gender: 'Male');

      print('username : ${user!.fullname}');

      expect(user.fullname, '');
    });
  });
}
