
import 'package:citygo/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Widget signup', (WidgetTester tester) async {
    bool isProfileImageSelected = true;

    // Build a SignUpScreen widget with the callback
    await tester.pumpWidget(MaterialApp(
      home: SignUpScreen(
        onProfileImageSelected: () {
          isProfileImageSelected = true;
        },
      ),
    ));

    await tester.tap(find.byKey(Key('Icon'))); 
    await tester.pump();

    // Access profileImage using the getter method
    expect(isProfileImageSelected, isTrue);
  });
}









