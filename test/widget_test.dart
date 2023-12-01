import 'package:ugd6_b_9/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd6_b_9/Testing/Testing_function.dart';
void main() {

  group("Login", () {

    testWidgets('Login Success', (WidgetTester tester) async {

      tester.binding.window.physicalSizeTestValue = const Size(800, 1280);



      await tester.pumpWidget(const MaterialApp(
        home: Login(),
      ));

      await tester.enterText(find.byType(TextFormField).first, '1');
      await tester.enterText(find.byType(TextFormField).last, '1');
      await tester.tap(find.byKey(const Key('tap_login')));
      await tester.pumpAndSettle();

      testing_function.login('1', '1').then((value) => expect(value!.message, 'Login Success'));

    });


    testWidgets('Login Failed', (WidgetTester tester) async {

      tester.binding.window.physicalSizeTestValue = const Size(800, 1280);



      await tester.pumpWidget(const MaterialApp(
        home: Login(),
      ));

      await tester.enterText(find.byType(TextFormField).first, '2');
      await tester.enterText(find.byType(TextFormField).last, '2');
      await tester.tap(find.byKey(const Key('tap_login')));
      await tester.pumpAndSettle();
      testing_function.login('2', '2').then((value) => expect(value!.message, 'Login Failed'));


    });

  });
}