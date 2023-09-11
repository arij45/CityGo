import 'dart:io';

import 'package:citygo/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FirstPage.dart';
import 'affichageDemande.dart';

class settings extends StatefulWidget {
  settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<settings> {

  String? profileimage ;

  Future<String?> getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? profileimage = prefs.getString('profileimage');
    return profileimage;
  }

  @override
  void initState() {
    super.initState();
    getProfileImage().then((value) {
      setState(() {
        profileimage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(51, 51, 51, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            // Set the preferred height of the AppBar
            child: AppBar(
              backgroundColor: Colors.transparent, // Make the AppBar transparent
              elevation: 0, // Remove the shadow
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60.0),
                    bottomLeft: Radius.circular(60.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                'Profil',
                style: TextStyle(
                  color: Colors.white, // Set title color to white
                ),
              ),
            ),
          ),
      body: Stack(
        children: [

          Positioned(
            top: 110,
            right: 140,
            child: Container(
              width: 72,
              height: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/motif4.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 110,
            right: 140,
            child: ClipOval(
            child: Container(
            width: 72,
            height: 69,
            decoration: BoxDecoration(
              image: profileimage != null
                  ? DecorationImage(
                image: FileImage(File(profileimage!)), // Load image from file path
                fit: BoxFit.cover,
              )
                  : DecorationImage(
                image: AssetImage('assets/images/motif3.png'), // Default image if profileimage is null or empty
                fit: BoxFit.cover,
              ),
            ),
          ),
         ),
          ),
          Positioned(
            top:380,
            right:56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SignUpScreen(),
                  ),
                );
              },
              child: Text(
                'Settings',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'Georgia',
                    fontWeight:FontWeight.bold,
                    fontSize:16
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
                  minimumSize: MaterialStateProperty.all(Size(250, 57))
              ),
            ),
          ),
          Positioned(
            top:480,
            right:56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        FirstPage(),
                  ),
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'Georgia',
                    fontWeight:FontWeight.bold,
                    fontSize:16
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
                  minimumSize: MaterialStateProperty.all(Size(250, 57))
              ),
            ),
          ),
]

      )
    );
  }
}