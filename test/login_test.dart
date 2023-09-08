
import 'package:citygo/view/MainScreen.dart';
import 'package:citygo/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main(){

  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('test SignIn Method', ()  {
    testWidgets('verify email and password', (tester) async {
      await tester.pumpWidget
        (
        MaterialApp(
          home: LoginScreen(),
        ),
      );
      // Fill in email and password fields
      await tester.enterText(find.byKey(Key('Email')),'kortasarij999@gmail.com');
      await tester.enterText(find.byKey(Key('Password')),'arijkortas123');

      // Tap the sign-in button and wait for it to complete
      await tester.runAsync(() => tester.tap(find.byKey(Key('signin'))));
      await tester.pump(Duration(seconds: 1));
      await tester.runAsync(() => tester.tap(find.byType(CircularProgressIndicator)));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(MainScreen),findsNothing);
    },
  );
   testWidgets('test SignUp Method ', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );
      await tester.runAsync(() => tester.tap(find.byKey(Key('signup'))));
      await tester.pumpAndSettle();
      final newPageWidget = find.text('Become a driver');
      expect(newPageWidget,findsOneWidget);

      // Add your test logic for the second test case here...
    });
  },
  );
}