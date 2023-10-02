import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class policy extends StatelessWidget {
  const policy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // Set the desired height here
          child: AppBar(
            backgroundColor: Color(0xFF0F5CA0),
            title: Padding(
              padding: EdgeInsets.only(right: 20.0, top: 30.0),
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
              child:SingleChildScrollView(
                      padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'Introduction:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'City Go is a flutter application.',
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'Information Collection and Use:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'We collect and use information to provide and improve the Service. By using the Service, you agree to this policy.',
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'Types of Data Collected:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Data: We may ask for personally identifiable information, such as email ',
                        ),
                        Text(
                          'Usage Data: We collect information about your interactions with our Service, such as your device and browser information.',
                        ),
                      ],
                    ),

                  ),
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'How We Use Your Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Providing, maintaining, and improving our Service.',
                        ),
                        Text(
                          'Communicating with you, including sending you updates and support messages.',
                        ),
                        Text(
                          'Analyzing usage patterns to enhance the user experience.',
                        ),
                      ],
                    ),

                  ),
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'Cookies and Tracking',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        Text(
                            'We may use cookies and similar tracking technologies to track user activity on our Service and to enhance user experience.',
                    ),

                  ),
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'Third-Party Services',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        Text(
                            'Our Service may contain links to third-party websites or services. We are not responsible for the privacy practices of these third parties.',
                        ),
                    ),
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'Security',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                    Text(
                      'We take measures to protect your data, but no method of transmission over the internet is entirely secure. We cannot guarantee absolute security.',
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'Children''s Privacy',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                    Text(
                      'Our Service is not intended for children under the age of 13. We do not knowingly collect personal information from children.',
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'Changes to This Privacy Policy',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                    Text(
                      'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      'Contact Us',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                    Text(
                      'If you have any questions about our Privacy Policy, please contact us at rh@3dwave.tech',
                    ),
                  ),

           ]

                  ),
              ),
         ),
    );
                  // Add more phrases as needed



  }
}