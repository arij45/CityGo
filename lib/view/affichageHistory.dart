import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../controllers/demandes.dart';
import '../models/Demande.dart';


class affichageHistory extends StatefulWidget {
  const affichageHistory({Key? key}) : super(key: key);

  @override
  affichageHistoryState createState() => affichageHistoryState();
}

class affichageHistoryState extends State<affichageHistory> {

  late Timer _timer;
  final Duration _refreshDuration = Duration(seconds: 6);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    // Start a timer that fires every specified duration
    _timer = Timer.periodic(_refreshDuration, (_) {
      refresh();
    });
  }

  Future<void> refresh() async {
    demandes demandesController = Get.find();
    demandesController.fetchdemandes();

    setState(() {
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    demandes demandesController = Get.find();
    demandesController.fetchdemandes();
    List<String> monthNames = [
      "", // Placeholder to make index 1-based
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    Size size = MediaQuery.of(context).size;



    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body:
        Container(

            child: Column(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white, // Set the color of the border
                          width: 2.0, // Set the width of the border
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "search by Name",
                                border: InputBorder.none,
                              ),
                              onChanged: (value) =>
                                  demandesController.filterhistory(value),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {
                              // Add your search logic here
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 9),
                  Expanded(
                      child: RefreshIndicator(
                          onRefresh: refresh,
                          child: ListView(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFF0F5CA0).withOpacity(0.7),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (demandesController.DemandesYesterday.length > 0)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 35.0),
                                        child: Text(
                                          'Yesterday',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Georgia",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                    if (demandesController.DemandesYesterday.length > 0)
                                      for (int i = 0; i < demandesController.DemandesYesterday.length; i++)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Container(
                                            height: 70,
                                            width: MediaQuery.of(context).size.width * 0.9,
                                            padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await demandesController.fetchdetailscourse(demandesController.DemandesYesterday[i]);
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              contentPadding: EdgeInsets.all(15),
                                                              content:Center(
                                                              child: Container(
                                                                width: MediaQuery.of(context).size.width,
                                                                height: MediaQuery.of(context).size.height * 0.5,
                                                            decoration: BoxDecoration(
                                                            color: Color(0xFF0F5CA0).withOpacity(0.8),
                                                            borderRadius: BorderRadius.circular(10),
                                                            ),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(context).size.width,
                                                                    height: MediaQuery.of(context).size.height * 0.6,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xFF0F5CA0).withOpacity(0.8),
                                                                      borderRadius: BorderRadius.circular(10),
                                                                    ),
                                                                      child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                      Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children:[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width*0.4,
                                                                          height: MediaQuery.of(context).size.height * 0.1,
                                                                          child: Text('Pick Up location',
                                                                            style: TextStyle(
                                                                                color: Color(0xFFFFFFFF),
                                                                                fontFamily: 'Georgia',
                                                                                fontWeight:FontWeight.bold,
                                                                                fontSize:12
                                                                            ),
                                                                          ),
                                                                        ),
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width*0.3,
                                                                            height: MediaQuery.of(context).size.height * 0.1,
                                                                            child: Text('${demandesController.DemandesYesterday[i].pickUpLocation}',
                                                                              style: TextStyle(
                                                                                  color: Color(0xFFFFFFFF),
                                                                                  fontFamily: 'Georgia',
                                                                                  fontWeight:FontWeight.bold,
                                                                                  fontSize:12
                                                                              ),
                                                                            ),
                                                                          ),
                                                                             ]
                                                                        ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width*0.4,
                                                                            height: MediaQuery.of(context).size.height * 0.1,
                                                                            child: Text('Drop off location',
                                                                              style: TextStyle(
                                                                                  color: Color(0xFFFFFFFF),
                                                                                  fontFamily: 'Georgia',
                                                                                  fontWeight:FontWeight.bold,
                                                                                  fontSize:12
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width*0.4,
                                                                            height: MediaQuery.of(context).size.height * 0.1,
                                                                            child: Text('${demandesController.DemandesYesterday[i].dropOffLocation}',
                                                                              style: TextStyle(
                                                                                  color: Color(0xFFFFFFFF),
                                                                                  fontFamily: 'Georgia',
                                                                                  fontWeight:FontWeight.bold,
                                                                                  fontSize:12
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width*0.4,
                                                                              height: MediaQuery.of(context).size.height * 0.1,
                                                                              child: Text('Pick Up Date',
                                                                                style: TextStyle(
                                                                                    color: Color(0xFFFFFFFF),
                                                                                    fontFamily: 'Georgia',
                                                                                    fontWeight:FontWeight.bold,
                                                                                    fontSize:12
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width*0.4,
                                                                              height: MediaQuery.of(context).size.height * 0.1,
                                                                              child: Text(
                                                                                demandesController.DemandesYesterday[i].pickUpDate != null
                                                                                    ? DateFormat('dd/MM/yyyy ' 'at' ' hh:mm a').format(demandesController.DemandesYesterday[i].pickUpDate!.toDate())
                                                                                    : 'No Date Available',
                                                                                style: TextStyle(
                                                                                    color: Color(0xFFFFFFFF),
                                                                                    fontFamily: 'Georgia',
                                                                                    fontWeight:FontWeight.bold,
                                                                                    fontSize:12
                                                                                ),
                                                                            ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width*0.4,
                                                                            height: MediaQuery.of(context).size.height * 0.1,
                                                                            child: Text('Passengers n°',
                                                                              style: TextStyle(
                                                                                  color: Color(0xFFFFFFFF),
                                                                                  fontFamily: 'Georgia',
                                                                                  fontWeight:FontWeight.bold,
                                                                                  fontSize:12
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width*0.4,
                                                                            height: MediaQuery.of(context).size.height * 0.1,
                                                                            child: Text(
                                                                            '${demandesController.DemandesYesterday[i].passengersNum}/${demandesController.DemandesYesterday[i].seatingCapacity}',
                                                                                        style: TextStyle(
                                                                                              color: Color(0xFFFFFFFF),
                                                                                              fontFamily: 'Georgia',
                                                                                              fontWeight:FontWeight.bold,
                                                                                              fontSize:12
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width*0.4,
                                                                                        height: MediaQuery.of(context).size.height * 0.1,
                                                                                        child: Text('Passengers n°',
                                                                                          style: TextStyle(
                                                                                              color: Color(0xFFFFFFFF),
                                                                                              fontFamily: 'Georgia',
                                                                                              fontWeight:FontWeight.bold,
                                                                                              fontSize:12
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width*0.4,
                                                                                        height: MediaQuery.of(context).size.height * 0.1,
                                                                                        child: Text(
                                                                                          '${demandesController.DemandesYesterday[i].passengersNum}/${demandesController.DemandesYesterday[i].seatingCapacity}',
                                                                                          style: TextStyle(
                                                                                              color: Color(0xFFFFFFFF),
                                                                                              fontFamily: 'Georgia',
                                                                                              fontWeight:FontWeight.bold,
                                                                                              fontSize:12
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                        ]
                                                                      ),
                                                                        ),
                                                                  SizedBox(height: 6),
                                                                  ElevatedButton(
                                                                    onPressed: () {
                                                                      // Close the dialog
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                    child: Text('Close',
                                                                              style: TextStyle(
                                                                              color: Color(0xFFFFFFFF),
                                                                              fontFamily: 'Georgia',
                                                                              fontWeight:FontWeight.bold,
                                                                              fontSize:14
                                                                              ),
                                                                              ),
                                                                              style: ButtonStyle(
                                                                              backgroundColor:
                                                                              MaterialStateProperty.all<
                                                                              Color>(Color(0xFF0F5CA0)),
                                                                              shape: MaterialStateProperty.all<
                                                                              RoundedRectangleBorder>(
                                                                              RoundedRectangleBorder(
                                                                              borderRadius:
                                                                              BorderRadius.circular(25),
                                                                              ),
                                                                              ),
                                                                              minimumSize: MaterialStateProperty.all(Size(size.height*0.13, 32)),
                                                                              ),
                                                                  ),
                                                                ],
                                                              ),
                                                              ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * 0.82,
                                                        height: 48,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFFD9D9D9).withOpacity(0.8),
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0, top: 15),
                                                          child: Text(
                                                            'Transport to ' + demandesController.DemandesYesterday[i].Destination.capitalize.toString(),
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: 'Georgia',
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                  ],
                                ),
                                SizedBox(height: 7),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFF0F5CA0).withOpacity(0.7),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (demandesController.filterDemandesbeforeYesterday().length > 0)
                                      for (List<Demande> demandesForDate in demandesController.filterDemandesbeforeYesterday())
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 35.0),
                                              child: Text(
                                                "${demandesForDate[0].DateDemande.day} ${monthNames[demandesForDate[0].DateDemande.month]} ${demandesForDate[0].DateDemande.year}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "Georgia",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            for (Demande demande in demandesForDate)
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Container(
                                                  height: 70,
                                                  width: MediaQuery.of(context).size.width * 0.87,
                                                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                                  child: Row(
                                                      children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                        onTap: () async {
                                                          await demandesController.fetchdetailscourse(demande);
                                                          showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                                              content: Container(
                                                                width: MediaQuery.of(context).size.width,
                                                                height: MediaQuery.of(context).size.height * 0.7,
                                                                child: Center(
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width,
                                                                        height: MediaQuery.of(context).size.height * 0.6,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(0xFF0F5CA0).withOpacity(0.8),
                                                                          borderRadius: BorderRadius.circular(10),
                                                                        ),
                                                                        child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children:[
                                                                                    Container(
                                                                                      width: MediaQuery.of(context).size.width*0.4,
                                                                                      height: MediaQuery.of(context).size.height * 0.1,
                                                                                      child: Text('Pick Up location',
                                                                                        style: TextStyle(
                                                                                            color: Color(0xFFFFFFFF),
                                                                                            fontFamily: 'Georgia',
                                                                                            fontWeight:FontWeight.bold,
                                                                                            fontSize:12
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: MediaQuery.of(context).size.width*0.3,
                                                                                      height: MediaQuery.of(context).size.height * 0.1,
                                                                                      child: Text('${demande.pickUpLocation}',
                                                                                        style: TextStyle(
                                                                                            color: Color(0xFFFFFFFF),
                                                                                            fontFamily: 'Georgia',
                                                                                            fontWeight:FontWeight.bold,
                                                                                            fontSize:12
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ]
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width*0.4,
                                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                                    child: Text('Drop off location',
                                                                                      style: TextStyle(
                                                                                          color: Color(0xFFFFFFFF),
                                                                                          fontFamily: 'Georgia',
                                                                                          fontWeight:FontWeight.bold,
                                                                                          fontSize:12
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width*0.4,
                                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                                    child: Text('${demande.dropOffLocation}',
                                                                                      style: TextStyle(
                                                                                          color: Color(0xFFFFFFFF),
                                                                                          fontFamily: 'Georgia',
                                                                                          fontWeight:FontWeight.bold,
                                                                                          fontSize:12
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width*0.4,
                                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                                    child: Text('Pick Up Date',
                                                                                      style: TextStyle(
                                                                                          color: Color(0xFFFFFFFF),
                                                                                          fontFamily: 'Georgia',
                                                                                          fontWeight:FontWeight.bold,
                                                                                          fontSize:12
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width*0.4,
                                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                                    child: Text(
                                                                                      demande.pickUpDate != null
                                                                                          ? DateFormat('dd/MM/yyyy ' 'At' ' hh:mm a').format(demande.pickUpDate!.toDate())
                                                                                          : 'No Date Available',
                                                                                      style: TextStyle(
                                                                                          color: Color(0xFFFFFFFF),
                                                                                          fontFamily: 'Georgia',
                                                                                          fontWeight:FontWeight.bold,
                                                                                          fontSize:12
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width*0.4,
                                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                                    child: Text('Passengers n°',
                                                                                      style: TextStyle(
                                                                                          color: Color(0xFFFFFFFF),
                                                                                          fontFamily: 'Georgia',
                                                                                          fontWeight:FontWeight.bold,
                                                                                          fontSize:12
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width*0.4,
                                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                                    child: Text(
                                                                                      '${demande.passengersNum}/${demande.seatingCapacity}',
                                                                                      style: TextStyle(
                                                                                          color: Color(0xFFFFFFFF),
                                                                                          fontFamily: 'Georgia',
                                                                                          fontWeight:FontWeight.bold,
                                                                                          fontSize:12
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width*0.4,
                                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                                    child: Text('Passengers n°',
                                                                                      style: TextStyle(
                                                                                          color: Color(0xFFFFFFFF),
                                                                                          fontFamily: 'Georgia',
                                                                                          fontWeight:FontWeight.bold,
                                                                                          fontSize:12
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width*0.4,
                                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                                    child: Text(
                                                                                      '${demande.passengersNum}/${demande.seatingCapacity}',
                                                                                      style: TextStyle(
                                                                                          color: Color(0xFFFFFFFF),
                                                                                          fontFamily: 'Georgia',
                                                                                          fontWeight:FontWeight.bold,
                                                                                          fontSize:12
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ]
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 6),
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          // Close the dialog
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        child: Text('Close',
                                                                          style: TextStyle(
                                                                              color: Color(0xFFFFFFFF),
                                                                              fontFamily: 'Georgia',
                                                                              fontWeight:FontWeight.bold,
                                                                              fontSize:14
                                                                          ),
                                                                        ),
                                                                        style: ButtonStyle(
                                                                          backgroundColor:
                                                                          MaterialStateProperty.all<
                                                                              Color>(Color(0xFF0F5CA0)),
                                                                          shape: MaterialStateProperty.all<
                                                                              RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                              borderRadius:
                                                                              BorderRadius.circular(25),
                                                                            ),
                                                                          ),
                                                                          minimumSize: MaterialStateProperty.all(Size(size.height*0.13, 32)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );

                                                          },
                                                          );
                                                          },
                                                            child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.84,
                                                            height: 48,
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFFD9D9D9).withOpacity(0.8),
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 10.0, top: 15),
                                                              child: Text(
                                                                'Transport to ${demande.Destination.capitalize}',
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily: 'Georgia',
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        ],
                                                      ),
                                                  ]
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )
                                    else
                                      Padding(
                                        padding: const EdgeInsets.only(left: 35.0),
                                        child: Text(
                                          'No requests before yesterday',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontFamily: "Georgia",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                              ]
                          )
                      )
                  ),
    ]
        ),
    ),
    );
  }
}