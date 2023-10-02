import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/courses.dart';
import 'course.dart';


class affichagecourse extends StatefulWidget {
  @override
  _AffichageCourseState createState() => _AffichageCourseState();
}

class _AffichageCourseState extends State<affichagecourse> {
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
    courses coursesController = Get.find();
    coursesController.fetchCourses();

    setState(() {
      // You can update the UI here when the data changes
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    courses coursesController = Get.find();
    coursesController.fetchCourses();
    return Scaffold(

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.0),
          child: AppBar(
            backgroundColor: Color(0xFF105EA0),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.0),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 25, bottom: 8), // Adjust top padding
                child: Text(
                  'Courses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Georgia",
                  ),
                ),
              ),
            ),
          ),
        ),
        body:
        Container(
            child: Column(
                children: [
                  SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xFF0F5CA0),
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
                                hintText: "search by Destination",
                                border: InputBorder.none,
                              ),
                              onChanged: (value) =>
                                  coursesController.filter(value),
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
                       child: SingleChildScrollView(
                       child: Column(
                          children: [
                            Column(
                              children: [
                                if (coursesController.coursesListTomorrow.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 250.0),
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

                                if (coursesController.coursesListTomorrow.length > 0)
                                  for (int i = 0; i < coursesController.coursesListTomorrow.length; i++)
                              Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Container(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width ,
                                      padding: EdgeInsets.only(
                                       right: 20, bottom: 5),
                                    child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                         Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                      Container(
                                      width: 175,
                                      height: 48,
                                      decoration: BoxDecoration(
                                      color: Color(0xFF0F5CA0),
                                      borderRadius:
                                      BorderRadius.circular(
                                      5)),
                                      child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceAround,
                                      children: [
                                      Container(
                                      padding:
                                      const EdgeInsets
                                          .only(
                                      bottom: 8.0),
                                      width: 70,
                                      child: Center(
                                      child: Text(
                                      coursesController
                                          .coursesListTomorrow[i]
                                          .pickUpLocation
                                          .capitalize
                                          .toString(),
                                      style: TextStyle(
                                      fontSize: 15,
                                      fontFamily:
                                      'Georgia',
                                       color: Colors.white,
                                      )),
                                      ),
                                      ),
                                      Row(
                                      children: [
                                      Container(
                                      height: 2,
                                      width: 30,
                                      color: Color(0xFFFFFFFF),
                                      ),
                                      Container(
                                      height: 5,
                                      width: 5,
                                      decoration:
                                      BoxDecoration(
                                      shape: BoxShape
                                          .circle,
                                      color:
                                     Color(0xFFFFFFFF),
                                      ),
                                      ),
                                      ],
                                      ),
                              Container(
                              width: 70,
                              padding:
                              const EdgeInsets
                                  .only(
                              bottom: 8.0),
                              child: Center(
                              child: Text(
                              coursesController
                                  .coursesListTomorrow[
                              i]
                                  .dropOffLocation!
                                  .capitalize
                                  .toString(),
                              style: TextStyle(
                              fontSize: 15,
                              fontFamily:
                              'Georgia',
                              color: Colors.white,
                              )),
                              ),
                              ),
                              ],
                              ),
                              ),
                              SizedBox(width: 5),
                              Container(
                              width: 40,
                              height: 48,
                              decoration: BoxDecoration(
                              color: Color(0xFF105EA0),
                              borderRadius:
                              BorderRadius.circular(
                              5)),
                              child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Icon(
                              Icons.people_alt_outlined,
                              size: 20,
                              color: Color(0xFFFFFFFF),
                              ),
                              Container(
                              // width:70,
                              child: Text(
                              coursesController
                                  .coursesListTomorrow[i]
                                  .passengersNum
                                  .toString() +
                              '/' +
                              coursesController
                                  .coursesListTomorrow[i]
                                  .seatingCapacity
                                  .toString(),
                              style: TextStyle(
                              fontSize: 13,
                              fontFamily:
                              'Georgia',
                              fontWeight:
                              FontWeight
                                  .bold)),
                              ),
                              ],
                              ),
                              ),
                              SizedBox(width: 5),
                              ],
                              ),
                                          /*Row(
                                            children: [
                                            GestureDetector(
                                            onTap: () {
                                            //Get.to(()=>EditCourseScreen(record: coursesController.coursesListTomorrow[i]));
                                            },
                                              child: Container(
                                              height: 40,
                                              width: 25,
                                              decoration: BoxDecoration(
                                              color: Color(0xFF0F5CA0),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(5)),
                                                  child: Icon(
                                                  Icons.edit,
                                                  color: Color(0xFFFFFFFF),
                                                  size: 23,
                                                  ),
                                                  ),
                                                  ),
                                                SizedBox(width: 5,),
                                                 GestureDetector(
                                                        onTap: () {
                                                        showDialog(
                                                        context: context,
                                                        builder:
                                                        ((builder) =>
                                                      AlertDialog(
                                                        content:
                                                        Container(
                                                          height: 100,
                                                          width: 300,
                                                          decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                          topLeft:
                                                          Radius.circular(40),
                                                          topRight: Radius.circular(40))),
                                                          child:
                                                         Center(
                                                           child:
                                                           Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.spaceBetween,
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              children: <Widget>[
                                                                  SizedBox(
                                                                  height:
                                                                  10,
                                                                  ),
                                                                  SizedBox(
                                                                  width:
                                                                  100,
                                                                  child:
                                                                      ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                      child: const Text(
                                                                      'Delete',
                                                                      style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                      ),
                                                                      onPressed: () {
                                                                      //coursesController.delete_course(coursesController.coursesListTomorrow[i].id!);
                                                                      coursesController.fetchCourses();
                                                                      Navigator.pop(context);
                                                                      },
                                                                      ),
                                                                      ),
                                                                      SizedBox(
                                                                      width:
                                                                      25,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                        100,
                                                                        child:
                                                                        ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                        child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                        onPressed: () => Navigator.pop(context),
                                                                        ),
                                                                        ),
                                                                        ],
                                                                        ),
                                                                        ),
                                                                        ),
                                                                        )));
                                                                        },
                                                                                  child: Container(
                                                                                    height: 40,
                                                                                    width: 25,
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color(0xFF0F5CA0),
                                                                                    borderRadius:
                                                                                    BorderRadius
                                                                                        .circular(5)),
                                                                                        child: Icon(
                                                                                        Icons.delete,
                                                                                        color: Color(0xFFFFFFFF),
                                                                                        ),
                                                                                        ),
                                                                                        )
                                                                                        ],
                                                                                        )
                                            */
                                        ]
                                      )
                                    ),
                                  ),
                              )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(right: 135.0),
                                    child: Text(
                                      'No courses for tomorrow',
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
                            Column(
                              children: [
                                if (coursesController.coursesListToday.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 250.0),
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

                                if (coursesController.coursesListToday.length > 0)
                                  for (int i = 0; i < coursesController.coursesListToday.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 14.0),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width ,
                                        padding: EdgeInsets.only(
                                            right: 20, bottom: 5),
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 175,
                                                        height: 48,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xFF0F5CA0),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Container(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 8.0),
                                                              width: 70,
                                                              child: Center(
                                                                child: Text(
                                                                    coursesController
                                                                        .coursesListToday[i]
                                                                        .pickUpLocation
                                                                        .capitalize
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      'Georgia',
                                                                      color: Colors.white,
                                                                    )),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 2,
                                                                  width: 30,
                                                                  color: Color(0xFFFFFFFF),
                                                                ),
                                                                Container(
                                                                  height: 5,
                                                                  width: 5,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                    Color(0xFFFFFFFF),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              width: 70,
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 8.0),
                                                              child: Center(
                                                                child: Text(
                                                                    coursesController
                                                                        .coursesListToday[
                                                                    i]
                                                                        .dropOffLocation!
                                                                        .capitalize
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      'Georgia',
                                                                      color: Colors.white,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Container(
                                                        width: 40,
                                                        height: 48,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xFF105EA0),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.people_alt_outlined,
                                                              size: 20,
                                                              color: Color(0xFFFFFFFF),
                                                            ),
                                                            Container(
                                                              // width:70,
                                                              child: Text(
                                                                  coursesController
                                                                      .coursesListToday[i]
                                                                      .passengersNum
                                                                      .toString() +
                                                                      '/' +
                                                                      coursesController
                                                                          .coursesListToday[i]
                                                                          .seatingCapacity
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 13,
                                                                      fontFamily:
                                                                      'Georgia',
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                    ],
                                                  ),
                                                  /*Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          //Get.to(()=>EditCourseScreen(record: coursesController.coursesListTomorrow[i]));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 25,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFF0F5CA0),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Color(0xFFFFFFFF),
                                                            size: 23,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5,),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                              ((builder) =>
                                                                  AlertDialog(
                                                                    content:
                                                                    Container(
                                                                      height: 100,
                                                                      width: 300,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft:
                                                                              Radius.circular(40),
                                                                              topRight: Radius.circular(40))),
                                                                      child:
                                                                      Center(
                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                          mainAxisSize:
                                                                          MainAxisSize.min,
                                                                          children: <Widget>[
                                                                            SizedBox(
                                                                              height:
                                                                              10,
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                              100,
                                                                              child:
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                                child: const Text(
                                                                                  'Delete',
                                                                                  style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                                ),
                                                                                onPressed: () {
                                                                                  //coursesController.delete_course(coursesController.coursesListTomorrow[i].id!);
                                                                                  coursesController.fetchCourses();
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                              25,
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                              100,
                                                                              child:
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                                child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                                onPressed: () => Navigator.pop(context),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 25,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFF0F5CA0),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Color(0xFFFFFFFF),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                  */
                                                ]
                                            )
                                        ),
                                      ),
                                    )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(right: 169.0),
                                    child: Text(
                                      'No courses for today',
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
                            Padding(
                            padding: const EdgeInsets.only(right: 297.0),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.1,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(80.0),
                                  bottomLeft: Radius.circular(80.0),
                                  topLeft: Radius.circular(80.0),
                                  topRight: Radius.circular(80.0),
                                ),
                                color: Color(0xFF0F5CA0),
                              ),
                              child: Center(
                                child:
                                Image.asset('assets/images/drivericon.png'),
                              ),
                            ),
                            ),
                            SizedBox(height: 7),
                            Column(
                              children: [
                                if (coursesController.coursesListTomorrowDrivers.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 250.0),
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

                                if (coursesController.coursesListTomorrowDrivers.length > 0)
                                  for (int i = 0; i < coursesController.coursesListTomorrowDrivers.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 14.0),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width ,
                                        padding: EdgeInsets.only(
                                            right: 20, bottom: 5),
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 175,
                                                        height: 48,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xFF0F5CA0),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Container(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 8.0),
                                                              width: 70,
                                                              child: Center(
                                                                child: Text(
                                                                    coursesController
                                                                        .coursesListTomorrowDrivers[i]
                                                                        .pickUpLocation
                                                                        .capitalize
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      'Georgia',
                                                                      color: Colors.white,
                                                                    )),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 2,
                                                                  width: 30,
                                                                  color: Color(0xFFFFFFFF),
                                                                ),
                                                                Container(
                                                                  height: 5,
                                                                  width: 5,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                    Color(0xFFFFFFFF),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              width: 70,
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 8.0),
                                                              child: Center(
                                                                child: Text(
                                                                    coursesController
                                                                        .coursesListTomorrowDrivers[
                                                                    i]
                                                                        .dropOffLocation!
                                                                        .capitalize
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      'Georgia',
                                                                      color: Colors.white,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Container(
                                                        width: 40,
                                                        height: 48,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xFF105EA0),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.people_alt_outlined,
                                                              size: 20,
                                                              color: Color(0xFFFFFFFF),
                                                            ),
                                                            Container(
                                                              // width:70,
                                                              child: Text(
                                                                  coursesController
                                                                      .coursesListTomorrowDrivers[i]
                                                                      .passengersNum
                                                                      .toString() +
                                                                      '/' +
                                                                      coursesController
                                                                          .coursesListTomorrowDrivers[i]
                                                                          .seatingCapacity
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 13,
                                                                      fontFamily:
                                                                      'Georgia',
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          //Get.to(()=>EditCourseScreen(record: coursesController.coursesListTomorrow[i]));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 25,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFF0F5CA0),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Color(0xFFFFFFFF),
                                                            size: 23,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5,),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                              ((builder) =>
                                                                  AlertDialog(
                                                                    content:
                                                                    Container(
                                                                      height: 100,
                                                                      width: 300,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft:
                                                                              Radius.circular(40),
                                                                              topRight: Radius.circular(40))),
                                                                      child:
                                                                      Center(
                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                          mainAxisSize:
                                                                          MainAxisSize.min,
                                                                          children: <Widget>[
                                                                            SizedBox(
                                                                              height:
                                                                              10,
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                              100,
                                                                              child:
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                                child: const Text(
                                                                                  'Delete',
                                                                                  style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                                ),
                                                                                onPressed: () {
                                                                                  //coursesController.delete_course(coursesController.coursesListTomorrow[i].id!);
                                                                                  coursesController.fetchCourses();
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                              25,
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                              100,
                                                                              child:
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                                child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                                onPressed: () => Navigator.pop(context),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 25,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFF0F5CA0),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Color(0xFFFFFFFF),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ]
                                            )
                                        ),
                                      ),
                                    )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(right: 132.0),
                                    child: Text(
                                      'No courses for tomorrow',
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
                            SizedBox(height: 7,),
                            Column(
                              children: [
                                if (coursesController.coursesListTodayDrivers.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 250.0),
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

                                if (coursesController.coursesListTodayDrivers.length > 0)
                                  for (int i = 0; i < coursesController.coursesListTodayDrivers.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 14.0),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width ,
                                        padding: EdgeInsets.only(
                                            right: 20, bottom: 5),
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 175,
                                                        height: 48,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xFF0F5CA0),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Container(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 8.0),
                                                              width: 70,
                                                              child: Center(
                                                                child: Text(
                                                                    coursesController
                                                                        .coursesListTodayDrivers[i]
                                                                        .pickUpLocation
                                                                        .capitalize
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      'Georgia',
                                                                      color: Colors.white,
                                                                    )),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 2,
                                                                  width: 30,
                                                                  color: Color(0xFFFFFFFF),
                                                                ),
                                                                Container(
                                                                  height: 5,
                                                                  width: 5,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                    Color(0xFFFFFFFF),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              width: 70,
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 8.0),
                                                              child: Center(
                                                                child: Text(
                                                                    coursesController
                                                                        .coursesListTodayDrivers[
                                                                    i]
                                                                        .dropOffLocation!
                                                                        .capitalize
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      'Georgia',
                                                                      color: Colors.white,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Container(
                                                        width: 40,
                                                        height: 48,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xFF105EA0),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.people_alt_outlined,
                                                              size: 20,
                                                              color: Color(0xFFFFFFFF),
                                                            ),
                                                            Container(
                                                              // width:70,
                                                              child: Text(
                                                                  coursesController
                                                                      .coursesListTodayDrivers[i]
                                                                      .passengersNum
                                                                      .toString() +
                                                                      '/' +
                                                                      coursesController
                                                                          .coursesListTodayDrivers[i]
                                                                          .seatingCapacity
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 13,
                                                                      fontFamily:
                                                                      'Georgia',
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          //Get.to(()=>EditCourseScreen(record: coursesController.coursesListTomorrow[i]));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 25,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFF0F5CA0),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Color(0xFFFFFFFF),
                                                            size: 23,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5,),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                              ((builder) =>
                                                                  AlertDialog(
                                                                    content:
                                                                    Container(
                                                                      height: 100,
                                                                      width: 300,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft:
                                                                              Radius.circular(40),
                                                                              topRight: Radius.circular(40))),
                                                                      child:
                                                                      Center(
                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                          mainAxisSize:
                                                                          MainAxisSize.min,
                                                                          children: <Widget>[
                                                                            SizedBox(
                                                                              height:
                                                                              10,
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                              100,
                                                                              child:
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                                child: const Text(
                                                                                  'Delete',
                                                                                  style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                                ),
                                                                                onPressed: () {
                                                                                  //coursesController.delete_course(coursesController.coursesListTomorrow[i].id!);
                                                                                  coursesController.fetchCourses();
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                              25,
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                              100,
                                                                              child:
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                                child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                                onPressed: () => Navigator.pop(context),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 25,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFF0F5CA0),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Color(0xFFFFFFFF),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ]
                                            )
                                        ),
                                      ),
                                    )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(right: 166.0),
                                    child: Text(
                                      'No courses for today',
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
                       ),
                      ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Adjust padding as needed
                      child: FloatingActionButton(
                        onPressed: () {
                          // Navigate to the other page when the button is clicked
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => course(),
                          ));
                        },
                        backgroundColor: Color(0xFF0F5CA0),
                        child: Icon(Icons.add),
                      ),
                    ),
                  )
                ]
            )
        )
    );


  }
}
