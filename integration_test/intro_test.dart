import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

 testIntro(WidgetTester tester) async{
  //intro
  expect(find.text('DONE'), findsNothing);
  expect(find.text('NEXT'), findsOneWidget);
  final next = find.byKey(const Key('next'));
  await tester.tap(next);
  await tester.pumpAndSettle();
  expect(find.text('DONE'), findsOneWidget);

  final done = find.byKey(const Key('done'));
  await tester.tap(done);
  await tester.pumpAndSettle();
}