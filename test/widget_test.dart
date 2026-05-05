// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:barengkita/main.dart';

void main() {
  testWidgets('App loads home screen with BarengKita title',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BarengKitaApp());
    expect(find.text('BarengKita'), findsWidgets);
  });

  testWidgets('Bottom navigation has 4 items', (WidgetTester tester) async {
    await tester.pumpWidget(const BarengKitaApp());
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Darurat'), findsOneWidget);
    expect(find.text('Konseling'), findsOneWidget);
    expect(find.text('Sumber Daya'), findsOneWidget);
  });

  testWidgets('Emergency banner navigates to emergency tab',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BarengKitaApp());
    await tester.pump();

    // Tap emergency banner on home screen
    final banner = find.text('Dalam Bahaya?');
    expect(banner, findsOneWidget);
    await tester.tap(banner);
    await tester.pump();

    // Emergency tab should now be selected (index 1)
    final navBar =
        tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
    expect(navBar.currentIndex, 1);
  });
}
