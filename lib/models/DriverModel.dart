import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class DriverModel {

  late Timestamp currentDate;
  Uint8List? profileImage;
  Uint8List? identityCardImage;
  Uint8List? licenceTypeImage;
  String? selectedLicenseType;
  late String firstname;
  late String lastname;
  late String birthDate;
  late int phoneNumber;
 // String? licenseType;
  late String email;
  late String password;
  late int Identitycard;
  bool valide = false;

  DriverModel(
      this.currentDate,
      this.profileImage,
      this.identityCardImage,
      this.licenceTypeImage,
      this.selectedLicenseType,
      this.firstname,
      this.lastname,
      this.birthDate,
      this.phoneNumber,
    //  this.licenseType,
      this.email,
      this.password,
      this.Identitycard,
      this.valide);

  List<String> licenseTypeOptions = ['A1', 'A', 'B', 'B+E', 'C', 'C+E'];
}
