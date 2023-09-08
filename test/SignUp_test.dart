
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

    // Trigger the selectProfileImage function by tapping a button or performing an action
    await tester.tap(find.byKey(Key('Icon'))); // Replace with the actual widget used to trigger image selection
    await tester.pump();

    // Access profileImage using the getter method
    expect(isProfileImageSelected, isTrue);
  });
}









