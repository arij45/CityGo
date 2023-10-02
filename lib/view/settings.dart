import 'dart:io';

import 'package:citygo/view/policy.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FirstPage.dart';
import 'login_screen.dart';

class settings extends StatefulWidget {
  settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<settings> {

  String? profileimage ;
  String? Firstname ;
  String? Lastname;
  String? birthdate;
  int? identitycard;
  int? phonenumber;
  String? email;


  Future<String?> getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? profileimage = prefs.getString('profileimage');
    return profileimage;
  }
  Future<String?> getfirstname() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Firstname = prefs.getString('firstname');
    return Firstname;
  }
  Future<String?> getlastname() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Lastname = prefs.getString('lastname');
    return Lastname;
  }
  Future<String?> getbirthdate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? birthdate = prefs.getString('birthdate');
    return birthdate;
  }

  Future<int?> getidentitycard() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? identitycard = prefs.getInt('identitynumber');
    return identitycard;
  }
  Future<int?> getphonenumber() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? phonenumber = prefs.getInt('phonenumber');
    return phonenumber;
  }
  Future<String?> getemail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }



  @override
  void initState() {
    super.initState();
    getProfileImage().then((value) {
      setState(() {
        profileimage = value;
      });
    });
    getfirstname().then((value) {
      setState(() {
        Firstname = value!;
      });
    });
    getlastname().then((value) {
      setState(() {
        Lastname = value!;
      });
    });
    getbirthdate().then((value) {
      setState(() {
        birthdate = value!;
      });
    });
    getidentitycard().then((value) {
      setState(() {
        identitycard = value!;
      });
    });
    getphonenumber().then((value) {
      setState(() {
        phonenumber = value!;
      });
    });
    getemail().then((value) {
      setState(() {
        email = value!;
      });
    });
  }




  TextStyle selectedStyle = TextStyle(
    color: Colors.black, // Set the desired color for the selected date
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'Georgia',
  );

  @override
  Widget build(BuildContext context) {
     return Scaffold(

         appBar: AppBar(
           backgroundColor: Color(0xFF0F5CA0),
                          title: Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 40.0), // Adjust the left padding as needed
                  child: Text(
                    'Profil',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(75),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 73,
                      height: 73,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/motif4.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Container(
                        width: 65,
                        height: 62,
                        decoration: BoxDecoration(
                          image: profileimage != null
                              ? DecorationImage(
                            image: FileImage(File(profileimage!)),
                            fit: BoxFit.cover,
                          )
                              : DecorationImage(
                            image: AssetImage('assets/images/motif3.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
           actions: [ Padding(
         padding: EdgeInsets.only(right: 20.0, top: 10.0),
             child: IconButton(
               icon: Icon(Icons.settings), // Icon for parameters
               onPressed: () {
                 // Show the modal bottom sheet
                 showModalBottomSheet(
                   context: context,
                   builder: (context) {
                     return Container(
                       // Add your content for the bottom sheet here
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           ListTile(
                             leading: Icon(Icons.edit),iconColor: Color(0xFF0F5CA0),
                             title: Text('Privacy policy',style:selectedStyle),
                             onTap: () async {
                               // Navigate to the LoginScreen when the ListTile is tapped
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => policy()),
                               );
                             },
                           ),
                           ListTile(
                             leading: Icon(Icons.logout),iconColor: Color(0xFF0F5CA0),
                             title: Text('Logout',style:selectedStyle),
                             onTap: () async {
                               // Navigate to the LoginScreen when the ListTile is tapped
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => FirstPage()),
                               );
                             },
                           ),
                           ElevatedButton(
                             onPressed: (){
                               Navigator.pop(context);
                             },
                             child: Text(
                               'Close',
                               style: TextStyle(
                                 color: Colors.white,
                                 fontFamily: 'Georgia',
                                 fontSize: 12,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             style: ButtonStyle(
                               backgroundColor: MaterialStateProperty.all<Color>(
                                 Color(0xFF0F5CA0),
                               ),
                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                 RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(25),
                                 ),
                               ),
                               minimumSize: MaterialStateProperty.all(
                                 Size(MediaQuery.of(context).size.width * 0.2, 40),
                               ),
                             ),
                           ),

                         ],
                       ),
                     );
                   },
                 );
               },
             ),)
           ],
            ),

              body: Container(
              width: 387,
              height: 800,
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/images/Rectangle1.png'),
              fit: BoxFit.cover,
              ),
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: 90.0, top: 115.0),
                  child: Column(
                    children: [
                    // First Row
                          Row(
                          children: [
                                Text(
                                'First Name',
                                style: TextStyle(
                                color: Color(0xFF373737),
                                fontFamily: 'Georgia',
                                  fontWeight:FontWeight.bold,
                                ),
                                ),
                            SizedBox(width: 25),
                              Text(
                                Firstname ?? 'null', // Replace with your value
                              style: TextStyle(
                              color: Color(0xFF373737),
                              fontFamily: 'Georgia',
                              ),
                              ),
                            ],
                            ),
                             SizedBox(height: 25),
                                Row(
                                    children: [
                                      Text(
                                      'Last Name',
                                      style: TextStyle(
                                      color: Color(0xFF373737),
                                      fontFamily: 'Georgia',
                                        fontWeight:FontWeight.bold,
                                      ),
                                      ),
                                      SizedBox(width: 29),
                                      Text(
                                        Lastname ?? 'null', // Replace with your value
                                      style: TextStyle(
                                      color: Color(0xFF373737),
                                      fontFamily: 'Georgia',
                                      ),
                                      ),
                                ],
                                ),
                      SizedBox(height: 25),
                                    Row(
                                    children: [
                                    Text(
                                    'Birth Date',
                                    style: TextStyle(
                                    color: Color(0xFF373737),
                                    fontFamily: 'Georgia',
                                      fontWeight:FontWeight.bold,
                                    ),
                                    ),
                                      SizedBox(width: 31),
                                    Text(
                                      birthdate ?? 'null', // Replace with your value
                                    style: TextStyle(
                                    color: Color(0xFF373737),
                                    fontFamily: 'Georgia',
                                    ),
                                    ),
                                    ],
                                    ),
                      SizedBox(height: 25),
                                    Row(
                                        children: [
                                        Text(
                                        'Identity Card',
                                        style: TextStyle(
                                        color: Color(0xFF373737),
                                        fontFamily: 'Georgia',
                                          fontWeight:FontWeight.bold,
                                        ),
                                        ),
                                          SizedBox(width: 12),
                                        Text(
                                          identitycard.toString() ?? 'null',
                                        style: TextStyle(
                                        color: Color(0xFF373737),
                                        fontFamily: 'Georgia',
                                        ),
                                        ),
                                        ],
                                        ),
                      SizedBox(height: 25),
                                            Row(
                                            children: [
                                            Text(
                                            'Phone n°',
                                            style: TextStyle(
                                            color: Color(0xFF373737),
                                            fontFamily: 'Georgia',
                                              fontWeight:FontWeight.bold,
                                            ),
                                            ),
                                              SizedBox(width: 42),
                                            Text(
                                              phonenumber.toString() ??'null', // Replace with your value
                                            style: TextStyle(
                                            color: Color(0xFF373737),
                                            fontFamily: 'Georgia',
                                            ),
                                            ),
                                            ],
                                            ),
                      SizedBox(height: 25),
                                            Row(
                                                  children: [
                                                  Text(
                                                  'Email',
                                                  style: TextStyle(
                                                  color: Color(0xFF373737),
                                                  fontFamily: 'Georgia',
                                                    fontWeight:FontWeight.bold,
                                                  ),
                                                  ),
                                                    SizedBox(width: 65),
                                                  Text(
                                                    email ?? 'null', // Replace with your value
                                                  style: TextStyle(
                                                  color: Color(0xFF373737),
                                                  fontFamily: 'Georgia',
                                                  ),
                                                  ),
                                                  ],
                                                  ),

                      ]
    ),
              ),
     ),
    );
  }
}