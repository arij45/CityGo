import 'package:cloud_firestore/cloud_firestore.dart';

class Course {

  late String check ;
  late String id ;
  late String pickUpLocation ;
  late String dropOffLocation ;
  late DateTime pickUpDate;
  late int passengersNum;
  late int seatingCapacity;
  late String regNumber;
  late String driverName;
  late int identityNum;
  late DateTime dropOffDate;


  Course({
    required this.check,
    required this.id,
    required this.pickUpLocation,
    required this.dropOffLocation,
    required this.pickUpDate,
    required this.passengersNum,
    required this.seatingCapacity,
    required this.regNumber,
    required this.driverName,
    required this.identityNum,
    required this.dropOffDate,
  });

}