// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emeklilikte/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Emekli olabilir miyim test', (WidgetTester tester) async {
    await tester.pumpWidget(EmekliOlabilirimApp());

    // Find DropdownButtonFormField and select 'Kadın' option
    expect(find.byType(DropdownButtonFormField), findsOneWidget);
    await tester.tap(find.byType(DropdownButtonFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kadın').last);
    await tester.pumpAndSettle();

    // Enter age, work years, and prim days
    expect(find.byType(TextFormField), findsNWidgets(3));
    await tester.enterText(find.byType(TextFormField).at(0), '55');
    await tester.enterText(find.byType(TextFormField).at(1), '15');
    await tester.enterText(find.byType(TextFormField).at(2), '5000');
    await tester.pumpAndSettle();

    // Tap the 'Emekli Olabilir miyim?' button
    expect(find.text('Emekli Olabilir miyim?'), findsOneWidget);
    await tester.tap(find.text('Emekli Olabilir miyim?'));
    await tester.pumpAndSettle();

    // Expect a dialog to appear with 'Emekli Olamazsınız' text
    expect(find.text('Emekli Olamazsınız'), findsOneWidget);
    expect(find.text('Kalan yaş: 3, Kalan çalışma yılı: 5, Kalan prim günü: 2200'), findsOneWidget);

    // Close the dialog
    await tester.tap(find.text('Tamam'));
    await tester.pumpAndSettle();

    // Select 'Erkek' option
    await tester.tap(find.byType(DropdownButtonFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Erkek').last);
    await tester.pumpAndSettle();

    // Enter age, work years, and prim days
    await tester.enterText(find.byType(TextFormField).at(0), '62');
    await tester.enterText(find.byType(TextFormField).at(1), '30');
    await tester.enterText(find.byType(TextFormField).at(2), '7500');
    await tester.pumpAndSettle();

    // Tap the 'Emekli Olabilir miyim?' button
    await tester.tap(find.text('Emekli Olabilir miyim?'));
    await tester.pumpAndSettle();

    // Expect a dialog to appear with 'Emekli Olabilirsiniz' text
    expect(find.text('Emekli Olabilirsiniz'), findsOneWidget);
    expect(find.text('Tebrikler, emekli olabilirsiniz!'), findsOneWidget);

    // Close the dialog
    await tester.tap(find.text('Tamam'));
    await tester.pumpAndSettle();
  });
}
