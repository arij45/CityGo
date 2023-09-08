import 'package:flutter/material.dart';

import 'FirstPage.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: ClipRRect(
              child: Container(
                width: 430,
                height: 700,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Welcome.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
