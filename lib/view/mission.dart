/*import 'package:flutter/material.dart';

import 'settings.dart';

class mission extends StatelessWidget {
  const mission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Container(
              color: const Color.fromRGBO(51, 51, 51, 1),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.200,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                        60.0), // Adjust the value as per your requirement
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => home(),
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: Color(0xFFD9D9D9),
                  size: 40,
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 30,
              child: Container(
                width: 180,
                height: 30,
                child: Center(
                  child: Text(
                    'Missions',
                    // Replace this with the text you want to display
                    style: TextStyle(
                      color: Colors.white, // You can set the text color
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia',
                    ),
                  ),
                ),

              ),
            ),
            Positioned(
              top: 40,
              right: 40,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/motif4.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 43,
              right: 42,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/motif3.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: 20,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(

                    topLeft: Radius.circular(
                        60.0), // Adjust the value as per your requirement
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/login.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: 20,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(

                    topLeft: Radius.circular(
                        60.0), // Adjust the value as per your requirement
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/login.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 27,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0), // Adjust the value as per your requirement
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/Rectangle 25.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Rides',
                              style: TextStyle(
                                color: Color(0xFF373737),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Georgia',
                              ),
                            ),
                            Text(
                              'Airport transfers',
                              style: TextStyle(
                                color: Color(0xFF373737),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Georgia',
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0), // Adjust the value as per your requirement
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/Rectangle 27.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Car hire', // Replace this with the text you want to display
                        style: TextStyle(
                          color: Color(0xFF373737), // You can set the text color
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 270,
              left: 37,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.86,
                      height: MediaQuery.of(context).size.height * 0.58,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Rectangle 28.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                 ),
                                                   ),
            Positioned(
              top: 273,
              left: 41,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.84,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0), // Adjust the value as per your requirement
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle 32.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 170), // Adjust the left padding as needed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pick-up location',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Georgia',
                          ),
                        ),
                        Text(
                          'aaaaaaaaaa',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Georgia',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 332,
              left: 41,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.84,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),// Adjust the value as per your requirement
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle 32.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Drop off location ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Georgia',
                          ),
                        ),
                        Text(
                          'yyyyyyyyyyyy',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Georgia',
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
            Positioned(
                   top: 395,
                   left: 40,
                       child: Row(
                         children: [
                                  Container(
                                   width: MediaQuery.of(context).size.width * 0.41,
                                   height: MediaQuery.of(context).size.height * 0.1,
                                   decoration: BoxDecoration(
                                   borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0), // Adjust the value as per your requirement
                                    ),
                                    image: DecorationImage(
                                    image: AssetImage('assets/images/Rectangle 34.png'),
                                    fit: BoxFit.cover,
                                    ),
                                     ),
                                        child: Center(
                                             child: Column(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                      Text(
                                                      'Pick-Up',
                                                     style: TextStyle(
                                                       color: Colors.black,
                                                       fontSize: 12,
                                                       fontWeight: FontWeight.bold,
                                                       fontFamily: 'Georgia',
                                                            ),
                                                          ),
                                                              Text(
                                                        'jj/mm/aaaa',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                        fontFamily: 'Georgia',
                                                        ),
                                                        ),
                                                        ],
                                                        ),
                                                        )
                                                        ),
                                                    SizedBox(width: 5),
                                        Container(
                                                width: MediaQuery.of(context).size.width * 0.42,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8.0),
                                                topLeft: Radius.circular(8.0), // Adjust the value as per your requirement
                                                ),
                                                image: DecorationImage(
                                                image: AssetImage('assets/images/Rectangle 34.png'),
                                                fit: BoxFit.cover,
                                                ),
                                                ),
                                                child: Center(
                                                 child: Text(
                                                'Return', // Replace this with the text you want to display
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                fontFamily: 'Georgia',
                                  ),
                                  ),
                                  ),
                                  ),
                                  ],
                                  ),
                ),
            Positioned(
              top: 470,
              left: 40,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.84,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),// Adjust the value as per your requirement
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle 32.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        'Passengers',
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 12,
                           fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '2',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 530,
              left: 40,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.84,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),// Adjust the value as per your requirement
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle 32.png'),
                    fit: BoxFit.cover,
                  ),
                ),

               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Luggage',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/luggage.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                       Container(
                         width: MediaQuery.of(context).size.width * 0.07,
                         height: MediaQuery.of(context).size.height * 0.03,
                         decoration: BoxDecoration(
                           image: DecorationImage(
                             image: AssetImage('assets/images/luggagee.png'),
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                      SizedBox(width: 8),
                      Text(
                        '4',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ),
            Positioned(
              top: 590,
              left: 40,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.84,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),// Adjust the value as per your requirement
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle 32.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Subject File',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                 SizedBox(width:10),
                  Container(
                  width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pdf.png'),
                  fit: BoxFit.cover,
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

 */