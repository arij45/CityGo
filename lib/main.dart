import 'package:citygo/view/FirstPage.dart';
import 'package:citygo/view/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'controllers/courses.dart';
import 'controllers/demandes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  courses coursesData = courses();
  Get.put(coursesData);
  demandes demandeData = demandes();
  Get.put(demandeData);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 5)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            return FirstPage();
          } else {

            return Welcome();
          }
        },
      ),
    );
  }
}
