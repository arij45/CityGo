import 'package:citygo/view/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../controllers/DriverController.dart';
import 'MainScreen.dart';
import 'Notification.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
          ),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        resizeToAvoidBottomInset: true,
        body:  Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(65.0), // Adjust the radius as needed
            ),
          ),
          padding:
          const EdgeInsets.only(left: 45.0, right: 8.0, top: 48),
          child: Form(
             key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 30.0,
                        top: MediaQuery.of(context).size.height * 0.1,
                        left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container (
                          width: 285,
                          height: 66,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Welcome',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'Georgia',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.only(right: 70),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 235,
                              height: 35,
                              child: Text(
                                'Login',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    key: Key('Email'),
                    controller: _emailTextController,
                    focusNode: _focusEmail,
                    validator: (value) =>
                        DriverController.validateEmail(
                          email: value,
                        ),
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(
                        fontFamily: 'Georgia',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // Specify the desired color for the hint text
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          // color: Colors.red,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFF333333), // Specify the desired color for the cursor
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  TextFormField(
                    key: Key('Password'),
                    controller: _passwordTextController,
                    focusNode: _focusPassword,
                    obscureText: true,
                    validator: (value) =>
                        DriverController.validatePassword(
                          password: value,
                        ),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                          fontFamily: 'Georgia',
                          color: Colors.white,
                          fontWeight: FontWeight
                              .bold // Specify the desired color for the hint text
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(6.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFF333333), // Specify the desired color for the cursor
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  _isProcessing
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                            children: [
                           ElevatedButton(
                             key: Key('signin'),
                            onPressed: () async {
                               _focusEmail.unfocus();
                               _focusPassword.unfocus();
                              if (_formKey.currentState!
                                  .validate()) {
                                setState(() {
                                  _isProcessing = true;
                                });

                                User? user =
                                await DriverController
                                    .signInUsingEmailPassword(
                                  email:
                                  _emailTextController
                                      .text,
                                  password:
                                  _passwordTextController
                                      .text,
                                );
                                setState(() {
                                  _isProcessing = false;
                                });

                                if (user != null) {
                                  print('test');
                                  Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>MainScreen(),
                                        ),
                                      );
                                }
                              }
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                color: Color(0xFF0F5CA0),
                                fontFamily: 'Georgia',
                                fontWeight:FontWeight.bold,
                                fontSize:16
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<
                                    Color>(Color(0xFFFFFFFF)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(25),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(Size(150, 57))
                            ),
                        ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 4,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        child: Text(
                          'Ou',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Georgia',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 4,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    key: Key('signup'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                       color: Color(0xFF0F5CA0),
                        fontFamily: 'Georgia',
                          fontWeight:FontWeight.bold,
                          fontSize:16
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<
                            Color>(Color(0xFFFFFFFF)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(25),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(Size(150, 57))
                    ),
                  ),
                  SizedBox(height: 24.0),
                ],
              ),
          ),
        )
        ),
      ),
    );
  }
}