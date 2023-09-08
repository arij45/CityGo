import 'package:cloud_firestore/cloud_firestore.dart';

class Demande {

  late String Destination;
  late String id;
  late String Email;
  late int NbBaggage;
  late DateTime DateDemande;
  late int NumeroTelephone;
  late int IdentityCard;
  late String UserName ;
  late String idcourse ;
  String regNumber;
  String pickUpLocation;
  String dropOffLocation;
  Timestamp? pickUpDate;
  int? seatingCapacity;
  int? passengersNum;
  int? usedCollie;
  int? usedLuggageBigSize;
  int? usedLuggageMediumSize;
  int? collie;
  int? luggageBigSize;
  int? luggageMediumSize;


  Demande({
    required this.Destination,
    required this.id,
    required this.Email,
    required this.NbBaggage,
    required this.DateDemande,
    required this.NumeroTelephone,
    required this.IdentityCard,
    required this.UserName,
    required this.idcourse,
    this.regNumber = '',
    this.pickUpLocation = '',
    this.dropOffLocation = '',
    this.pickUpDate = null,
    this.seatingCapacity = null,
    this.passengersNum = null,
    this.collie=null,
    this.luggageBigSize=null,
    this.luggageMediumSize=null,
    this.usedCollie=null,
    this.usedLuggageBigSize=null,
    this.usedLuggageMediumSize=null,
  });




}