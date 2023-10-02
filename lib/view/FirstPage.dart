import 'package:flutter/material.dart';

import 'login_screen.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(

      child: Scaffold(
        backgroundColor: Colors.white,
        body:
        Padding(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Padding(
            padding: EdgeInsets.only(left: 25.0),
                child: Text(
                  'Drive in                                 ',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 40,
                    color: Color(0xFFFFFFFF),
                    textBaseline: TextBaseline.alphabetic,
                    height: 0.7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
                SizedBox(height: 35),
                Text(
                  'Security',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 40,
                    color: Color(0xFFFFFFFF),
                    textBaseline: TextBaseline.alphabetic,
                    height: 0.7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 35),
             ElevatedButton(
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
              ],
            ),
          ),
        )
      )
      );

  }
}