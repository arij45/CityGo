import 'package:flutter/material.dart';

import 'login_screen.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
        body: Container(
                  width: 387,
                  height: 800,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 47.0,
                      top: 282.0,
                      bottom: 50.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Drive in',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 40,
                            color: Color(0xFFFFFFFF),
                            textBaseline: TextBaseline.alphabetic,
                            height: 0.7,
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 7,),
                        Text(
                          'security',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 40,
                            color: Color(0xFFFFFFFF),
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 65.0,
                        top: 15.0,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Navigate to the LoginScreen when the button is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'Get started',
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
                    ]
                  ),
                  ),
                ),
      );
  }
}