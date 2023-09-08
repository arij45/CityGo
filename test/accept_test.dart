import 'package:citygo/view/Accept.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main()  {

  testWidgets('Widget Accept' ,
  (tester) async
{
  await tester.pumpWidget
  (
    MaterialApp(
       home: Accept(
     ),
    ),
     );
  final text = find.text('Your request has been confirmed');
  expect(text,findsOneWidget);
  final login = find.byType(ElevatedButton);
  await tester.tap(login);
  await tester.pumpAndSettle();
  final newPageWidget = find.text('Welcome');
  expect(newPageWidget,findsOneWidget);
}
  );
}
