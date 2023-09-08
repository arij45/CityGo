import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controllers/demandes.dart';
import 'package:intl/intl.dart';

class affichageDemande extends StatefulWidget {
  const affichageDemande({Key? key, }) : super(key: key);

  @override
  affichageDemandeState createState() => affichageDemandeState();
}

class affichageDemandeState extends State<affichageDemande> {


  late Timer _timer;
  final Duration _refreshDuration = Duration(seconds: 6); // Adjust the duration as needed

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
                                 demandesController.filter(value),
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
                                if (demandesController.DemandesTomorrow.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
                                    child: Text(
                                      'Tomorrow',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "Georgia",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                if (demandesController.DemandesTomorrow.length > 0)
                                  for (int i = 0; i < demandesController.DemandesTomorrow.length; i++)
                                    Padding(
                                      key: const Key('length of demandestomorrow'),
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        height: 70,

                                                          child: Column(
                                                                children: [
                                                                GestureDetector(
                                                                onTap: () async {
                                                                await demandesController.fetchdetailscourse(demandesController.DemandesTomorrow[i]);
                                                                showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                return AlertDialog(

                                                                    content:
                                                                  Container(
                                                                    width: MediaQuery.of(context).size.width * 0.93,
                                                                  height: MediaQuery.of(context).size.height * 0.45,
                                                                  decoration: BoxDecoration(
                                                                  color: Color(0xFF0F5CA0).withOpacity(0.8),
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  padding: EdgeInsets.all(16),
                                                                  child: Column(
                                                                  children: [
                                                                  SingleChildScrollView(
                                                                  scrollDirection: Axis.horizontal,
                                                                    child: Column(
                                                                        children: [
                                                                           Row(
                                                                            children:[
                                                                            Container(
                                                                            width: MediaQuery.of(context).size.width*0.3,
                                                                            height: MediaQuery.of(context).size.height * 0.05,
                                                                            child: Text('Pick Up location',
                                                                            style: TextStyle(
                                                                            color: Color(0xFFFFFFFF),
                                                                            fontFamily: 'Georgia',
                                                                            fontWeight:FontWeight.bold,
                                                                            fontSize:12
                                                                            ),
                                                                            ),
                                                                            ),
                                                                            SizedBox(width: 30),
                                                                            Container(
                                                                                width: MediaQuery.of(context).size.width*0.3,
                                                                                height: MediaQuery.of(context).size.height * 0.05,
                                                                                child: Text('${demandesController.DemandesTomorrow[i].pickUpLocation}',
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
                                                                          SizedBox(height: 10),
                                                                           Row(
                                                                                children: [
                                                                                Container(
                                                                                width: MediaQuery.of(context).size.width*0.3,
                                                                                height: MediaQuery.of(context).size.height * 0.05,
                                                                                child: Text('Drop off location',
                                                                                style: TextStyle(
                                                                                color: Color(0xFFFFFFFF),
                                                                                fontFamily: 'Georgia',
                                                                                fontWeight:FontWeight.bold,
                                                                                fontSize:12
                                                                                ),
                                                                                ),
                                                                                ),
                                                                                  SizedBox(width: 30),
                                                                                    Container(
                                                                                    width: MediaQuery.of(context).size.width*0.3,
                                                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                                                    child: Text('${demandesController.DemandesTomorrow[i].dropOffLocation}',
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
                                                                          SizedBox(height: 10),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 40.0),

                                                                          child: Row(
                                                                                        children: [
                                                                                        Container(
                                                                                        width: MediaQuery.of(context).size.width*0.3,
                                                                                        height: MediaQuery.of(context).size.height * 0.05,
                                                                                        child: Text('Pick Up Date',
                                                                                        style: TextStyle(
                                                                                        color: Color(0xFFFFFFFF),
                                                                                        fontFamily: 'Georgia',
                                                                                        fontWeight:FontWeight.bold,
                                                                                        fontSize:12
                                                                                        ),
                                                                                    ),
                                                                                    ),
                                                                                          SizedBox(width: 30),
                                                                                          Container(
                                                                                          width: MediaQuery.of(context).size.width*0.41,
                                                                                          height: MediaQuery.of(context).size.height * 0.05,
                                                                                          child: Text(
                                                                                          demandesController.DemandesTomorrow[i].pickUpDate != null
                                                                                          ? DateFormat('dd/MM/yyyy ' 'at' ' hh:mm a').format(demandesController.DemandesTomorrow[i].pickUpDate!.toDate())
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
                                                                    ),
                                                                          SizedBox(height: 10),

                                                                               Row(
                                                                                  children: [
                                                                                  Container(
                                                                                  width: MediaQuery.of(context).size.width*0.3,
                                                                                  height: MediaQuery.of(context).size.height * 0.05,
                                                                                  child: Text('Passengers n°',
                                                                                  style: TextStyle(
                                                                                  color: Color(0xFFFFFFFF),
                                                                                  fontFamily: 'Georgia',
                                                                                  fontWeight:FontWeight.bold,
                                                                                  fontSize:12
                                                                                  ),
                                                                                  ),
                                                                                  ),
                                                                                    SizedBox(width: 30),
                                                                                        Container(
                                                                                        width: MediaQuery.of(context).size.width*0.3,
                                                                                        height: MediaQuery.of(context).size.height * 0.05,
                                                                                        child: Text(
                                                                                        '${demandesController.DemandesTomorrow[i].passengersNum}/${demandesController.DemandesTomorrow[i].seatingCapacity}',
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
                                                                          SizedBox(height: 10),
                                                                                Row(
                                                                                        children: [
                                                                                        Container(
                                                                                        width: MediaQuery.of(context).size.width*0.3,
                                                                                        height: MediaQuery.of(context).size.height * 0.05,
                                                                                        child: Text('Luggage',
                                                                                        style: TextStyle(
                                                                                        color: Color(0xFFFFFFFF),
                                                                                        fontFamily: 'Georgia',
                                                                                        fontWeight:FontWeight.bold,
                                                                                        fontSize:12
                                                                                        ),
                                                                                        ),
                                                                                        ),
                                                                                          SizedBox(width: 30),
                                                                                            Row(
                                                                                            children:[
                                                                                              Image.asset(
                                                                                                'assets/images/luggage1.png',
                                                                                                width: 24,
                                                                                                height: 24,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                              SizedBox(width: 5),
                                                                                            Container(
                                                                                            width: MediaQuery.of(context).size.width*0.3,
                                                                                            height: MediaQuery.of(context).size.height * 0.02,
                                                                                            child: Text(
                                                                                            '${demandesController.DemandesTomorrow[i].usedCollie}/${demandesController.DemandesTomorrow[i].collie}',
                                                                                            style: TextStyle(
                                                                                            color: Color(0xFFFFFFFF),
                                                                                            fontFamily: 'Georgia',
                                                                                            fontWeight:FontWeight.bold,
                                                                                            fontSize:12
                                                                                            ),
                                                                                            ),
                                                                                            ),
                                                                                              Image.asset(
                                                                                                'assets/images/luggage1.png',
                                                                                                width: 24,
                                                                                                height: 24,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                              SizedBox(width: 5),
                                                                                              Container(
                                                                                                width: MediaQuery.of(context).size.width*0.3,
                                                                                                height: MediaQuery.of(context).size.height * 0.02,
                                                                                                child: Text(
                                                                                                  '${demandesController.DemandesTomorrow[i].usedCollie}/${demandesController.DemandesTomorrow[i].collie}',
                                                                                                  style: TextStyle(
                                                                                                      color: Color(0xFFFFFFFF),
                                                                                                      fontFamily: 'Georgia',
                                                                                                      fontWeight:FontWeight.bold,
                                                                                                      fontSize:12
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(width: 8),
                                                                                              Image.asset(
                                                                                                'assets/images/luggage1.png',
                                                                                                width: 24,
                                                                                                height: 24,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                              SizedBox(width: 5),
                                                                                              Container(
                                                                                                width: MediaQuery.of(context).size.width*0.3,
                                                                                                height: MediaQuery.of(context).size.height * 0.02,
                                                                                                child: Text(
                                                                                                  '${demandesController.DemandesTomorrow[i].usedCollie}/${demandesController.DemandesTomorrow[i].collie}',
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
                                                                  ],
                                                                ),
                                                                    ]
                                                                  ),
                                                                ),
                                                                  SizedBox(height: 10),
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
                                                                    ]
                                                                    )
                                                                    ),

                                                                                          );


                                                                                          },



                                                                                          );
                                                                                          },
                                                                                         child: Container(
                                                                                          width: MediaQuery.of(context).size.width * 0.82,
                                                                                          height: 48,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Color(0xFF0F5CA0).withOpacity(0.8),
                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                          ),
                                                                                              child: Padding(
                                                                                              padding: const EdgeInsets.only(left: 10.0,top: 15),
                                                                                              child: Text(
                                                                                                'Transport to ' + demandesController.DemandesTomorrow[i].Destination.capitalize.toString(),
                                                                                                key: Key('destinationText_${demandesController.DemandesTomorrow[i].Destination}'), // Add this line
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

                                                    ),
                                                    )
                                                                                              else
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(left: 35.0),
                                                                                                  child: Text(
                                                                                                    'No requests for tomorrow',
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
                                if (demandesController.DemandesToday.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
                                    child: Text(
                                      'Today',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "Georgia",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                if (demandesController.DemandesToday.length > 0)
                                  for (int i = 0; i < demandesController.DemandesToday.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width * 0.87,
                                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
    Row(
    children: [
    GestureDetector(
    onTap: () async {
    await demandesController.fetchdetailscourse(demandesController.DemandesToday[i]);
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
      SizedBox(width: 30),
    Container(
    width: MediaQuery.of(context).size.width*0.3,
    height: MediaQuery.of(context).size.height * 0.1,
    child: Text('${demandesController.DemandesToday[i].pickUpLocation}',
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
      SizedBox(width: 30),
    Container(
    width: MediaQuery.of(context).size.width*0.4,
    height: MediaQuery.of(context).size.height * 0.1,
    child: Text('${demandesController.DemandesToday[i].dropOffLocation}',
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
      SizedBox(width: 30),
    Container(
    width: MediaQuery.of(context).size.width*0.4,
    height: MediaQuery.of(context).size.height * 0.1,
    child: Text(
    demandesController.DemandesToday[i].pickUpDate != null
    ? DateFormat('dd/MM/yyyy ' 'at' ' hh:mm a').format(demandesController.DemandesToday[i].pickUpDate!.toDate())
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
      SizedBox(width: 30),
    Container(
    width: MediaQuery.of(context).size.width*0.4,
    height: MediaQuery.of(context).size.height * 0.1,
    child: Text(
    '${demandesController.DemandesToday[i].passengersNum}/${demandesController.DemandesToday[i].seatingCapacity}',
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
      SizedBox(width: 30),
    Container(
    width: MediaQuery.of(context).size.width*0.4,
    height: MediaQuery.of(context).size.height * 0.1,
    child: Text(
    '${demandesController.DemandesToday[i].passengersNum}/${demandesController.DemandesToday[i].seatingCapacity}',
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
    color: Color(0xFF0F5CA0).withOpacity(0.8),
    borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
    padding: const EdgeInsets.only(left: 10.0,top: 15),
    child: Text(
    'Transport to ' + demandesController.DemandesToday[i].Destination.capitalize.toString(),
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
    ],
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
