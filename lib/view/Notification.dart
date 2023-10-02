import 'dart:io';

import 'package:citygo/view/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/DriverController.dart';
import 'Accept.dart';


class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? emailValue ;
  String? profileimage ;
  late FirebaseAuth _auth;
  User? _user;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? profileimage = prefs.getString('profileimage');
    return profileimage;
  }


  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    Emailvalue();
    //updateDocumentValuesSF();
    // checkAndNavigate(context);
    getProfileImage().then((value) {
      setState(() {
        profileimage = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('notiNewDrivers')
              .where('email', isEqualTo: emailValue)
          // Replace with the actual document ID you want to listen to
              .snapshots(),
          builder: (context, snapshot) {
            print("////////////////////////////////");
            print(emailValue);
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              DocumentSnapshot<Map<String, dynamic>> document = snapshot.data!
                  .docs[0];
              Map<String, dynamic>? data = document.data();
              bool isValid = data?['valid'] ?? false;
              if (isValid) {
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Accept(),
                    ),
                  );
                });
              } else {

                return Stack(

                    children: [
                      Container(
                        color: Color(0xFF105EA0),
                      ),
                      Positioned(
                        top: 25,
                        left: 115,
                        child: Container(
                          width: 173,
                          height: 186,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/motif1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 140,
                        child: Container(
                          width: 128,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/motif2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150,
                        left: 180,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/motif4.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150,
                        left: 180,
                          child: ClipOval(
                           child: Container(
                          width: 50,
                          height: 50,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 120, left: 38),
                            // Adjust the bottom padding value as needed
                            child: Container(
                              width: 250,
                              child: Text(
                                'your request has been sent successfully.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Acme',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.only(top: 30, left: 32),
                            child: Container(
                              width: 250,
                              child: Text(
                                'You will receive a notification shortly.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Acme',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(padding: EdgeInsets.only(left: 30),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 37,
                                    child: InkWell(
                                      onTap: () async {
                                        DriverController driverController = DriverController(
                                            setState: (void Function() fn) {});
                                        SharedPreferences prefs = await SharedPreferences
                                            .getInstance();
                                        int? identitynumberValue = prefs.getInt(
                                            'identitynumber');
                                        print('Delete request tapped');
                                        // int identitycard = widget.identitycard;
                                        // print(identitycard);
                                        driverController.fetchAndDeleteDocument(
                                            identitynumberValue!);
                                        await driverController.deleteImages(
                                            identitynumberValue);
                                        driverController.deleteUserAccount();
                                        Fluttertoast.showToast(
                                          msg: 'your request is deleted',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black87,
                                          textColor: Colors.white,
                                        );
                                      },
                                      child: Text(
                                        'Delete request',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Georgia',
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                          decorationThickness: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 120,
                                    height: 37,
                                      child: InkWell(
                                      onTap: () async {

                                            Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                            builder: (context) => SignUpScreen(),
                                            ),
                                              );
                                              },

                                          child: Text(
                                                    'Edit request',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: 'Georgia',
                                                      fontWeight: FontWeight.w700,
                                                      decoration: TextDecoration.underline,
                                                      decorationColor: Colors.white,
                                                      decorationThickness: 1.5,
                                                    ),
                                                  ),
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                );
                // You can return an empty widget here or any other widget you need.
              }
            }
            else {
              // Display the Stack widget when there is no data in the snapshot
              return Stack(
                  children: [
                    Container(
                      color: Color(0xFF105EA0),
                    ),
                    Positioned(
                      top: 25,
                      left: 115,
                      child: Container(
                        width: 173,
                        height: 186,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/motif1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 140,
                      child: Container(
                        width: 128,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/motif2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 180,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/motif4.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 180,
                      child: ClipOval(
                        child: Container(
                          width: 50,
                          height: 50,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 120, left: 38),
                          // Adjust the bottom padding value as needed
                          child: Container(
                            width: 250,
                            child: Text(
                              'your request has been sent successfully.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Acme',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.only(top: 30, left: 32),
                          child: Container(
                            width: 250,
                            child: Text(
                              'You will receive a notification shortly.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Acme',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(padding: EdgeInsets.only(left: 30),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 37,
                                  child: InkWell(
                                    onTap: () async {
                                      DriverController driverController = DriverController(
                                          setState: (void Function() fn) {});
                                      SharedPreferences prefs = await SharedPreferences
                                          .getInstance();
                                      int? identitynumberValue = prefs.getInt(
                                          'identitynumber');
                                      print('Delete request tapped');
                                      // int identitycard = widget.identitycard;
                                      // print(identitycard);
                                      driverController.fetchAndDeleteDocument(
                                          identitynumberValue!);
                                      await driverController.deleteImages(
                                          identitynumberValue);
                                      driverController.deleteUserAccount();
                                      Fluttertoast.showToast(
                                        msg: 'your request is deleted',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black87,
                                        textColor: Colors.white,
                                      );
                                      await prefs.remove('email');
                                    },
                                    child: Text(
                                      'Delete request',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Georgia',
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                        decorationThickness: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 120,
                                  height: 37,
                                      child: InkWell(
                                      onTap: () async {

                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                      ),
                                      );
                                      },

                                    child: Text(
                                      'Edit request',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Georgia',
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                        decorationThickness: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        )

    );
  }



  Future<void> Emailvalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailValue = prefs.getString('email'); // Set the emailValue using the member variable
    });
  }

  /*Future<void> updateDocumentValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() async {
      String? emailValue = prefs.getString('email');
      String? nameValue = prefs.getString('firstname');
      String? lastnameValue = prefs.getString('lastname');
      String? identitynumberValue = prefs.getString('identitynumber');
      String? birthdateValue = prefs.getString('birthdate');
      String? driverImage = prefs.getString('driverImage');
      String? password = prefs.getString('password');
      String? phonenumber = prefs.getString('phonenumber');
      String? licencetype = prefs.getString('licence');
      print(emailValue);

      QuerySnapshot querySnapshot = await _firestore
          .collection('notiNewDrivers')
          .where('email', isEqualTo: emailValue)
          .get();

      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        try {
          await documentSnapshot.reference.update({
            'firstName': nameValue,
            'lastName': lastnameValue,
            'identityNumber': identitynumberValue,
            'birthDate': birthdateValue,
            'driverImage': driverImage,
            'password': password,
            'phoneNumber': phonenumber,
            'licenceType': licencetype,
            // Add other fields here if needed
          });
          print('Document updated successfully');
        } catch (e) {
          print('Error updating document: $e');
        }
      }
    }
    );
  }

   */
  Future<Map<String, dynamic>> fetchUserData(String email) async {
    final userDoc = FirebaseFirestore.instance.collection('notiNewDrivers').doc(email);
    final userData = await userDoc.get();

    if (userData.exists) {
      return {
        'email': userData['email'] ,
        'firstName': userData['firstName'] ,
        'lastName': userData['lastName'] ,
        'birthDate': userData['birthDate'] ,
        'identityNumber': userData['identityNumber'].toString(),
        'phoneNumber': userData['phoneNumber'] ,
        'password': userData['password'] ,
      };
    } else {
      print("User document does not exist");
      return {}; // Return an empty map if the user data doesn't exist
    }
  }


}
