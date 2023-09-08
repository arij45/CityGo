import 'package:flutter/material.dart';

import 'FirstPage.dart';
import 'affichageDemande.dart';

class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Positioned(
            top:0,
            left:0,
            child: Container(
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)// Adjust the value as per your requirement
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/rectangle1min.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 140,
            child: Container(
              width: 75,
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
            top: 152,
            right: 142,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/motif3.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top:380,
            right:56,
            child: Container(
              width: 250,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60.0),
                  bottomLeft: Radius.circular(60.0),
                  topLeft: Radius.circular(60.0),
                  topRight: Radius.circular(60.0),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/Rectangle 14.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Acme',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top:480,
            right:56,
            child: Container(
              width: 250,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60.0),
                  bottomLeft: Radius.circular(60.0),
                  topLeft: Radius.circular(60.0),
                  topRight: Radius.circular(60.0),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/Rectangle 14.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>FirstPage(),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Acme',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      )
    );
  }
}