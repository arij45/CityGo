import 'package:citygo/controllers/demandes.dart';
import 'package:citygo/models/Demande.dart';
import 'package:citygo/view/affichageDemande.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import './mock.dart';



void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
    Get.put(demandes());
  });

  testWidgets('Widget Demande', (WidgetTester tester) async {
    final tomorrowdemands = [
      Demande(id:'EFL5HSDYUY9vG0RhTjRv', Destination: 'Sousse', Email: 'kortasarij99@gmail.com', NbBaggage: 6, DateDemande:DateTime(2023, 9, 1, 15, 30), NumeroTelephone: 54039290, IdentityCard: 12858098, UserName: 'aymen', idcourse: 'wipXTdgvyEsf7OSQuoGL',)
    ];

    demandes demandesController = Get.find();

    demandesController.DemandesTomorrow.assignAll(tomorrowdemands);

    await tester.pumpWidget
      (
      MaterialApp(
        home: affichageDemande(),
      ),
    );
    expect(find.byType(RefreshIndicator),findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(ListView),findsOneWidget);
    expect(find.byKey(Key('length of demandestomorrow')), findsNWidgets(tomorrowdemands.length));
    for (final Demande in tomorrowdemands) {
      final destinationKey = Key('destinationText_${Demande.Destination}');
      expect(find.byKey(destinationKey), findsOneWidget);
    }
  });
}