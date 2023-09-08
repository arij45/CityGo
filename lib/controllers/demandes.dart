

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/Demande.dart';

class demandes extends GetxController {

  late Timestamp DateDemande;
  var demandesList = <Demande>[].obs;
  var DemandesTomorrow = <Demande>[].obs;
  var DemandesToday = <Demande>[].obs;
  var DemandesYesterday = <Demande>[].obs;
  var DemandesbeforeYesterday = <Demande>[].obs;
  var groupedDemandesLists = <Demande>[].obs;
  var demandeData;


  Future<void> fetchdemandes() async {
    try {
      RxBool isLoading = RxBool(false); // Initialize isLoading
      isLoading.value = true;

      QuerySnapshot demandes = await FirebaseFirestore.instance
          .collection('demande')
          .orderBy('DateDemande', descending: true)
          .get();
      if (demandes.docs.isNotEmpty) {
        print('Demandes is not empty.');
        // You can also print the number of documents fetched:
        print('Number of documents fetched: ${demandes.docs.length}');
      } else {
        print('Demandes is empty.');
      }

      demandesList.clear();

      for (var demande in demandes.docs) {
        demandeData = demande.data() as Map<String, dynamic>;

        if (demandeData.containsKey('DateDemande')) {
          Timestamp DateDemande = demandeData['DateDemande'];

          Demande Demandeuser = Demande(
              Destination: demandeData['Destination'],
              id: demande.id,
              Email: demandeData['Email'],
              NbBaggage: demandeData['NbBaggage'],
              IdentityCard: demandeData['IdentityCard'],
              DateDemande: DateDemande.toDate(),
              NumeroTelephone: demandeData['NumeroTelephone'],
              UserName: demandeData['UserName'],
              idcourse: demandeData['idcourse'],
          );
          demandesList.add(Demandeuser);
          print('date: ${Demandeuser.DateDemande}');
        } else {
          print("false");
      }
    }

     filterDemandesToday();
     filterDemandesTomorrow();
     filterDemandesYesterday();
     filterDemandesbeforeYesterday();

      isLoading.value = false;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }


////////////////////////demande/////////////////

  void filterDemandesToday() {
    DateTime currentDate = DateTime.now();
    DemandesToday.assignAll(demandesList.where((demande) =>
    demande.DateDemande.year == currentDate.year
        && demande.DateDemande.month == currentDate.month
        && demande.DateDemande.day == currentDate.day
    ));
    for (var demande in DemandesToday) {
      print('Demande ID : ${demande.id}');
      print('Destination  : ${demande.Destination}');
    }
  }

  void filterDemandesTomorrow() {
    DateTime currentDate = DateTime.now();
    DemandesTomorrow.assignAll(demandesList.where((demande) =>
    demande.DateDemande.year == currentDate
        .add(Duration(days: 1))
        .year
        && demande.DateDemande.month == currentDate
        .add(Duration(days: 1))
        .month
        && demande.DateDemande.day == currentDate
        .add(Duration(days: 1))
        .day
    ));
    for (var demande in DemandesTomorrow) {
      print('Demande ID : ${demande.id}');
      print('Destination  : ${demande.Destination}');
    }
  }

  void filterDemandesYesterday() {
    DateTime currentDate = DateTime.now();
    DemandesYesterday.assignAll(demandesList.where((demande) =>
    demande.DateDemande.year == currentDate
        .subtract(Duration(days: 1))
        .year
        && demande.DateDemande.month == currentDate
        .subtract(Duration(days: 1))
        .month
        && demande.DateDemande.day == currentDate
        .subtract(Duration(days: 1))
        .day
    ));
    for (var demande in DemandesYesterday) {
      print('Demande ID : ${demande.id}');
      print('Destination  : ${demande.Destination}');
    }
  }

  List<List<Demande>> filterDemandesbeforeYesterday() {
    DateTime currentDate = DateTime.now();
    DateTime yesterday = currentDate.subtract(Duration(days: 2));

    List<Demande> demandesBeforeYesterday = demandesList.where((demande) =>
        demande.DateDemande.isBefore(DateTime(
            yesterday.year, yesterday.month, yesterday.day, 23, 59, 59
        ))
    ).toList();

    Map<String, List<Demande>> groupedDemandes = {};

    for (Demande demande in demandesBeforeYesterday) {
      String dateKey = "${demande.DateDemande.day}-${demande.DateDemande.month}-${demande.DateDemande.year}";
      groupedDemandes[dateKey] ??= [];
      groupedDemandes[dateKey]?.add(demande);
    }

    return groupedDemandes.values.toList();
  }





  void filterhistory(String prefix){

    DemandesYesterday.assignAll(demandesList.where((demande) =>
    demande.UserName.toLowerCase()!.startsWith(prefix.toLowerCase())
        && demande.DateDemande.year == DateTime.now()
            .subtract(Duration(days: 1))
        .year
    && demande.DateDemande.month == DateTime.now()
        .subtract(Duration(days: 1))
        .month
    && demande.DateDemande.day ==DateTime.now()
        .subtract(Duration(days: 1))
    .day
    ));

    DateTime currentDate = DateTime.now();
    DateTime yesterday = currentDate.subtract(Duration(days: 1));

    DemandesbeforeYesterday.assignAll(demandesList.where((demande) =>
        demande.UserName.toLowerCase()!.startsWith(prefix.toLowerCase())
        && demande.DateDemande.isBefore(DateTime(
            yesterday.year, yesterday.month, yesterday.day, 23, 59, 59))
    ));
  }

  void filter(String prefix) {
    DemandesToday.assignAll(demandesList.where((demande) =>
    demande.UserName.toLowerCase()!.startsWith(prefix.toLowerCase())
        && demande.DateDemande.year == DateTime
        .now()
        .year
        && demande.DateDemande.month == DateTime
        .now()
        .month
        && demande.DateDemande.day == DateTime
        .now()
        .day
    ));
    DemandesTomorrow.assignAll(demandesList.where((demande) =>
    demande.UserName.toLowerCase()!.startsWith(prefix.toLowerCase())
        && demande.DateDemande.year == DateTime
        .now()
        .add(Duration(days: 1))
        .year
        && demande.DateDemande.month == DateTime
        .now()
        .add(Duration(days: 1))
        .month
        && demande.DateDemande.day == DateTime
        .now()
        .add(Duration(days: 1))
        .day
    ));
  }

  Future<void> fetchdetailscourse(Demande demande) async {
    try {
      if (demande.idcourse != null) {
        String courseId = demande.idcourse;
        DocumentSnapshot courseSnapshot = await FirebaseFirestore.instance
            .collection('courses')
            .doc(courseId)
            .get();
        if (courseSnapshot.exists) {
          var courseData = courseSnapshot.data() as Map<String, dynamic>;
          String regNumber = courseData['regNumber'];
          String pickUpLocation = courseData['pickUpLocation'];
          String dropOffLocation = courseData['dropOffLocation'];
          Timestamp pickUpDate = courseData['pickUpDate'];
          int seatingCapacity = courseData['seatingCapacity'];
          int passengersNum = courseData['passengersNum'];
          int collie = courseData['collie'];
          int luggageBigSize = courseData['luggageBigSize'];
          int luggageMediumSize = courseData['luggageMediumSize'];
          int usedCollie = courseData['usedCollie'];
          int usedLuggageBigSize = courseData['usedLuggageBigSize'];
          int usedLuggageMediumSize = courseData['usedLuggageMediumSize'];

          demande.pickUpLocation = pickUpLocation;
          demande.dropOffLocation = dropOffLocation;
          demande.pickUpDate = pickUpDate;
          demande.seatingCapacity = seatingCapacity;
          demande.passengersNum = passengersNum ;
          demande.regNumber = regNumber;
          demande.collie = collie;
          demande.luggageBigSize =luggageBigSize;
          demande.luggageMediumSize =luggageMediumSize;
          demande.usedCollie =usedCollie;
          demande.usedLuggageBigSize=usedLuggageBigSize;
          demande.usedLuggageMediumSize=usedLuggageMediumSize;

          // Now you have the regNumber from the course collection
          print('Reg Number for demande ${demande.id}: $regNumber');
          // You can store the fetched data in the demande object if needed
        } else {
          print('Course not found for idcourse: $courseId');
        }
      }
    } catch (e) {
      print('Error fetching course details: ${e.toString()}');
    }
  }

}