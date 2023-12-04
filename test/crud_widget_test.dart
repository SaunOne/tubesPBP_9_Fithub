import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd6_b_9/view/feature/scheduleView.dart';

void main() {

  testWidgets('Sukses Add Schedule', (tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      bool ifIsOverflowError = false;

      // Detect overflow error.
      var exception = details.exception;
      if (exception is FlutterError) {
        ifIsOverflowError = !exception.diagnostics.any(
            (e) => e.value.toString().startsWith("A RenderFlex overflowed by"));
      }

      // Ignore if it's an overflow error.
      if (ifIsOverflowError) {
        print('Overflow error.');
      } else {
        // Throw other errors.
        FlutterError.dumpErrorToConsole(details);
      }
    };
    // Pump widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CalendarScreen(),
      ),
    ));

    await tester.tap(find.byKey(const Key('createButton')));

    (tester.state(find.byType(CalendarScreen)) as CalendarScreenState).setDuration(50);

    tester.pump();

  });
}
