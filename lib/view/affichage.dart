import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/courses.dart';

class affichage extends StatefulWidget {
  const affichage({Key? key}) : super(key: key);

  @override
  _affichageState createState() => _affichageState();
}

class _affichageState extends State<affichage> {
  @override
  Widget build(BuildContext context) {
    courses coursesController = Get.find();
    coursesController.fetchCourses();

    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Color(0xFF3C77E1),
              ),
            ),
            title: Text(
              'Courses List',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        body:
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    30.0),
                topRight: Radius.circular(
                    30.0), // Adjust the value as per your requirement
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/Vector.png'),
                fit: BoxFit.cover,
              ),
            ),

               child: Column(
                children: [
                 Row(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.49,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                          ),
                          color: Color(0xFFD9D9D9),
                        ),
                        child: Center(
                          child: Text(
                            "Missions",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Georgia',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.5,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                          ),
                          color: Color(0xFF8DABDF),
                        ),
                        child: Center(
                          child: Text(
                            "History",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Georgia',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
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
                                hintText: "search by name , identity card",
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
                                if (coursesController.coursesListTomorrow.length > 0)
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

                                if (coursesController.coursesListTomorrow.length > 0)
                                  for (int i = 0; i < coursesController.coursesListTomorrow.length; i++)
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
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.87,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF0F5CA0).withOpacity(0.8),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                          child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,top: 15),
                                                          child: Text(
                                                            'Transport ' + coursesController.coursesListTomorrow[i].dropOffLocation.capitalize.toString(),
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: 'Georgia',
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                                    ],
                                                ),
                                              ],
                                            ),
                                            ),
                                            )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xFF0F5CA0).withOpacity(0.7),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (coursesController.coursesListToday.length > 0)
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

                                if (coursesController.coursesListToday.length > 0)
                                  for (int i = 0; i < coursesController.coursesListToday.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width * 0.87,
                                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.9,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF0F5CA0).withOpacity(0.8),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                          child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,top: 15),
                                                          child: Text(
                                                            'Transport ' + coursesController.coursesListToday[i].dropOffLocation.capitalize.toString(),
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: 'Georgia',
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
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
                            Container(
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
    if (coursesController.coursesListTomorrowDrivers.length > 0)
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

    if (coursesController.coursesListTomorrowDrivers.length > 0)
    for (int i = 0; i < coursesController.coursesListTomorrowDrivers.length; i++)
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
    Container(
    width: MediaQuery.of(context).size.width * 0.69,
    height: 48,
    decoration: BoxDecoration(
      color: Color(0xFF0F5CA0).withOpacity(0.8),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
    padding: const EdgeInsets.only(left: 10.0,top: 15),
    child: Text(
    'Transport ' + coursesController.coursesListTomorrowDrivers[i].dropOffLocation.capitalize.toString(),
    style: TextStyle(
    fontSize: 15,
    fontFamily: 'Georgia',
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ),
    SizedBox(width: 10),
    Row(
    children: [
    GestureDetector(
    onTap: () {
   // Get.to(() => EditCourseScreen(record: coursesController.coursesListTomorrowDrivers[i]));
    },
    child: Container(
    height: 40,
    width: 25,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    ),
    child: Icon(
    Icons.edit,
    color: Color(0xFF0F5CA0),
    size: 23,
    ),
    ),
    ),
    SizedBox(width: 5),
    GestureDetector(
    onTap: () {
    showDialog(
    context: context,
    builder: (builder) => AlertDialog(
    content: Container(
    height: 100,
    width: 300,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40),
    topRight: Radius.circular(40),
    ),
    ),
    child: Center(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    SizedBox(height: 10),
    SizedBox(
    width: 100,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    elevation: 20,
    shadowColor: Colors.blue[700],
    primary: Color(0xDADADA).withOpacity(0.69),
    onPrimary: Colors.white,
    ),
    child: const Text(
    'Delete',
    style: TextStyle(fontFamily: "Georgia", fontSize: 15),
    ),
    onPressed: () {
  //  coursesController.delete_course(coursesController.coursesListTomorrowDrivers[i].id!);
    coursesController.fetchCourses();
    Navigator.pop(context);
    },
    ),
    ),
    SizedBox(width: 25),
    SizedBox(
    width: 100,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    elevation: 20,
    shadowColor: Colors.blue[700],
    primary: Color(0x0F5CA0).withOpacity(0.8),
    onPrimary: Colors.white,
    ),
    child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
    onPressed: () => Navigator.pop(context),
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    );
    },
    child: Container(
    height: 40,
    width: 25,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    ),
    child: Icon(
    Icons.delete,
    color: Color(0xFF000000).withOpacity(0.54),
    ),
    ),
    ),
    ],
    ),
    ],
    ),
    ],
    ),
    ),
    )
    else
      Padding(
        padding: const EdgeInsets.only(left: 35.0),
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xFF0F5CA0).withOpacity(0.7),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (coursesController.coursesListTodayDrivers.length > 0)
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

                                if (coursesController.coursesListTodayDrivers.length > 0)
                                  for (int i = 0; i < coursesController.coursesListTodayDrivers.length; i++)
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
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.69,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF0F5CA0).withOpacity(0.8),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                            child: Padding(
                                                            padding: const EdgeInsets.only(left: 10.0,top: 15),
                                                             child: Text(
                                                            'Transport ' + coursesController.coursesListTodayDrivers[i].dropOffLocation.capitalize.toString(),
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: 'Georgia',
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                         ),
                                                           ),
                                                      SizedBox(width: 10),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Get.to(() => EditCourseScreen(record: coursesController.coursesListTomorrowDrivers[i]));
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              child: Icon(
                                                                Icons.edit,
                                                                color: Color(0xFF0F5CA0),
                                                                size: 23,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                context: context,
                                                                builder: (builder) => AlertDialog(
                                                                  content: Container(
                                                                    height: 100,
                                                                    width: 300,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                        topLeft: Radius.circular(40),
                                                                        topRight: Radius.circular(40),
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: <Widget>[
                                                                          SizedBox(height: 10),
                                                                          SizedBox(
                                                                            width: 100,
                                                                            child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                elevation: 20,
                                                                                shadowColor: Colors.blue[700],
                                                                                primary: Color(0xDADADA).withOpacity(0.69),
                                                                                onPrimary: Colors.white,
                                                                              ),
                                                                              child: const Text(
                                                                                'Delete',
                                                                                style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                              ),
                                                                              onPressed: () {
                                                                                //  coursesController.delete_course(coursesController.coursesListTomorrowDrivers[i].id!);
                                                                                coursesController.fetchCourses();
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 25),
                                                                          SizedBox(
                                                                            width: 100,
                                                                            child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                elevation: 20,
                                                                                shadowColor: Colors.blue[700],
                                                                                primary: Color(0x0F5CA0).withOpacity(0.8),
                                                                                onPrimary: Colors.white,
                                                                              ),
                                                                              child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                              onPressed: () => Navigator.pop(context),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              child: Icon(
                                                                Icons.delete,
                                                                color: Color(0xFF000000).withOpacity(0.54),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                        ]
                                                ),
                                              ],
                                            ),
                                        ),
                                      )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
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
                            )
                          ]
    )
    )
    ]
    )
    )
        );


  }
}






/*      for (int i = 0; i<coursesController.coursesListTomorrow.length;i++)
            Padding(
            padding: const EdgeInsets.only(
            left: 10),
            child: Container(
            height: 70,
            width: MediaQuery.of(context)
                .size
                .width *0.9,
            padding: EdgeInsets.only(
            left: 5,
            right: 5,
            bottom: 5),
            child: Row(
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
            children: [
            Row(
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
            children: [
            Container(
            width: 200,
            height: 48,
            decoration: BoxDecoration(
            color: Colors
                .white
                .withOpacity(
            0.8),
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
            const EdgeInsets.only(bottom: 8.0),
            width:
            70,
            child:
            Center(
            child: Text(coursesController.coursesListTomorrow[i].pickUpLocation.capitalize.toString(),
            style: TextStyle(
            fontSize: 15,
            fontFamily: 'Georgia',
            )),
            ),
            ),
            if (coursesController.coursesListToday.length >0)
            Padding(
            padding:
            const EdgeInsets.only(left: 35.0),
            child:
            Text(
            'Today',
            style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "Georgia", fontWeight: FontWeight.bold),
            ),
            ),
            for (int i = 0 ;
            i < coursesController.coursesListToday.length;
            i++)
            Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(

            children: [
            GestureDetector(
            onTap: () {
            showDialog(
            // barrierDismissible:false,
            context: context,
            builder: (builder) => AlertDialog(
            content: Container(child: Text(coursesController.coursesListToday[i].driverName)),
            ));
            },
            child: Container(
            width: 200,
            height: 48,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(5)),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            width: 70,
            child: Center(
            child: Text(coursesController.coursesListToday[i].pickUpLocation.capitalize.toString(),
            style: TextStyle(
            fontSize: 13,
            fontFamily: 'Georgia',
            )),
            ),
            ),
            for (int i = 0; i < coursesController.coursesListToday.length; i++)
            Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
            // mainAxisAlignment:
            // MainAxisAlignment
            //     .spaceBetween,
            children: [
            GestureDetector(
            onTap: () {
            showDialog(
            // barrierDismissible:false,
            context: context,
            builder: (builder) => AlertDialog(
            content: Container(child: Text(coursesController.coursesListToday[i].driverName)),
            ));
            },
            child: Container(
            width: 200,
            height: 48,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(5)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            width: 70,
            child: Center(
            child: Text(coursesController.coursesListToday[i].pickUpLocation.capitalize.toString(),
            style: TextStyle(
            fontSize: 13,
            fontFamily: 'Georgia',
            )),
            ),
            ),
            ]))),
            ]),
            ]),
            ),
            ),
            ],
    ),
    ),
    ),
    ]
    ),



    ]
        ),

*/
/*



                            ListView(children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFF0F5CA0).withOpacity(0.7),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (coursesController
                                                .coursesListTomorrow.length >
                                            0)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 35.0),
                                            child: Text(
                                              'Tomorrow',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "Georgia",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        for (int i = 0; i<coursesController.coursesListTomorrow.length;i++)
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Container(
                                                  height: 70,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *0.9,
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 5),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                  width: 200,
                                                                  height: 48,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.8),
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
                                                                              const EdgeInsets.only(bottom: 8.0),
                                                                          width:
                                                                              70,
                                                                          child:
                                                                              Center(
                                                                            child: Text(coursesController.coursesListTomorrow[i].pickUpLocation.capitalize.toString(),
                                                                                style: TextStyle(
                                                                                  fontSize: 15,
                                                                                  fontFamily: 'Georgia',
                                                                                )),
                                                                          ),
                                                                        ),
                                                                        if (coursesController.coursesListToday.length >0)
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 35.0),
                                                                            child:
                                                                                Text(
                                                                              'Today',
                                                                              style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "Georgia", fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        for (int i = 0 ;
                                                                            i < coursesController.coursesListToday.length;
                                                                            i++)
                                                                          Padding(
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: Container(
                                                                                  height: 70,
                                                                                  width: MediaQuery.of(context).size.width * 0.9,
                                                                                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 15),
                                                                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                    Row(

                                                                                        children: [
                                                                                          GestureDetector(
                                                                                              onTap: () {
                                                                                                showDialog(
                                                                                                    // barrierDismissible:false,
                                                                                                    context: context,
                                                                                                    builder: (builder) => AlertDialog(
                                                                                                          content: Container(child: Text(coursesController.coursesListToday[i].driverName)),
                                                                                                        ));
                                                                                              },
                                                                                              child: Container(
                                                                                                  width: 200,
                                                                                                  height: 48,
                                                                                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(5)),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        padding: const EdgeInsets.only(bottom: 8.0),
                                                                                                        width: 70,
                                                                                                        child: Center(
                                                                                                          child: Text(coursesController.coursesListToday[i].pickUpLocation.capitalize.toString(),
                                                                                                              style: TextStyle(
                                                                                                                fontSize: 13,
                                                                                                                fontFamily: 'Georgia',
                                                                                                              )),
                                                                                                        ),
                                                                                                      ),
                                                                                                      for (int i = 0; i < coursesController.coursesListToday.length; i++)
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsets.only(left: 10),
                                                                                                          child: Container(
                                                                                                            height: 70,
                                                                                                            width: MediaQuery.of(context).size.width * 0.9,
                                                                                                            padding: EdgeInsets.only(left: 5, right: 5, bottom: 15),
                                                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                                              Row(
                                                                                                                  // mainAxisAlignment:
                                                                                                                  // MainAxisAlignment
                                                                                                                  //     .spaceBetween,
                                                                                                                  children: [
                                                                                                                    GestureDetector(
                                                                                                                        onTap: () {
                                                                                                                          showDialog(
                                                                                                                              // barrierDismissible:false,
                                                                                                                              context: context,
                                                                                                                              builder: (builder) => AlertDialog(
                                                                                                                                    content: Container(child: Text(coursesController.coursesListToday[i].driverName)),
                                                                                                                                  ));
                                                                                                                        },
                                                                                                                        child: Container(
                                                                                                                            width: 200,
                                                                                                                            height: 48,
                                                                                                                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(5)),
                                                                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                                                                              Container(
                                                                                                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                                                                                                width: 70,
                                                                                                                                child: Center(
                                                                                                                                  child: Text(coursesController.coursesListToday[i].pickUpLocation.capitalize.toString(),
                                                                                                                                      style: TextStyle(
                                                                                                                                        fontSize: 13,
                                                                                                                                        fontFamily: 'Georgia',
                                                                                                                                      )),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ]))),
                                                                                                                  ]),
                                                                                                            ]),
                                                                                                          ),
                                                                                                        ),
                                                                                                    ],
                                                                                                  )))
                                                                                        ])
                                                                                  ])))
                                                                      ]))
                                                            ])
                                                      ])))
                                      ]))
                            ])
                          ]))))
        ]));
  }
}






                   */
