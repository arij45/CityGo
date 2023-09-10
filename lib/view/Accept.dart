import 'package:flutter/material.dart';

import 'Notification.dart';
import 'login_screen.dart';

class Accept extends StatelessWidget {
  const Accept({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF105EA0),
          ),
          Positioned(
            top: 50,
            left: 50,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 150.0,
                    top: 100.0,
                    bottom: 50.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 240,
                        height: 210,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Group 4.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 30,
                              left: 90,
                              child: Container(
                                width: 100,
                                height: 120,
                                child: Center(
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/car.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              left: 53,
                              child: Text(
                                'Your request has been confirmed',
                                style: TextStyle(
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                  fontSize: 12,
                                  fontFamily: 'Acme',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                       Padding(
                          padding: const EdgeInsets.only(top:80.0,left:50),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xFF0F5CA0),
                                fontFamily: 'Georgia',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(Size(size.width * 0.5, 50)),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
                ]
            ),
          );
  }
}
