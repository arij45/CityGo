import 'dart:io';
import 'package:citygo/view/signup_screen.dart';
import 'package:citygo/view/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../resources/add_profile_data.dart';
import 'Notification.dart';
import 'package:path/path.dart' as path;

class ImagesPage extends StatefulWidget {

  late int? identitycard;
  late String? Firstname;
  late String? Lastname;
  late String? Birthdate;
  late int? Number;
  late String? licenceType;
  late String? email;
  late String? password;
  late String? profileImage;


  ImagesPage({required this.identitycard,required this.Firstname,required this.Lastname,required this.Birthdate,required this.Number,required this.email,required this.password,required this.profileImage, required this.licenceType});


  @override
  _ImagesPageState createState() => _ImagesPageState();


}

class _ImagesPageState extends State<ImagesPage> {
  List<bool> areZonesVisible = [false, false, false];
  List<String?> more = [];
  late String resp ;


  @override
  void initState() {
    super.initState();
    more= List.generate(areZonesVisible.length, (_) => null);
  }

  String? _identityCardImageinter1;
  String? _identityCardImageinter2;
  String? _licencetcardImageinter1;
  String? _licencetcardImageinter2;


  void selectIdentityCardImageinter1() async {
    String? img = await pickImage();
    setState(() {
      _identityCardImageinter1 = img;
      print("heeel"+_identityCardImageinter1!);
    });
  }

  void selectMore(int i) async {
    String? img = await pickImage(); // Assuming pickImage() is a function to select an image/pdf path.
    if (img != null) {
      setState(() {
        more[i] = img;
      });
    }
  }

  void selectIdentityCardImageinter2() async {
    String? img = await pickImage();
    File myimg= File(img!);
    if (img != null) {
      print("Image bytes length: ${myimg.path}");
    } else {
      print("Image is null");
    }
    setState(() {
      _identityCardImageinter2 = img;
    });
  }

  void selectlicenceCardImageinter1() async {
    String? img = await pickImage();
    File myimg= File(img!);
    if (img != null) {
      print("Image bytes length: ${myimg.path}");
    } else {
      print("Image is null");
    }
    setState(() {
      _licencetcardImageinter1= img;
    });
  }

  void selectlicenceCardImageinter2() async {
    String? img = await pickImage();
    File myimg= File(img!);
    if (img != null) {
      print("Image bytes length: ${myimg.path}");
    } else {
      print("Image is null");
    }
    setState(() {
      _licencetcardImageinter2= img;
    });
  }

  void saveprofile() async {
    int? identitycard = widget.identitycard;
    String? Firstname = widget.Firstname;
    String? Lastname = widget.Lastname;
    String? Birthdate = widget.Birthdate;
    int? Number = widget.Number;
    String? licenceType = widget.licenceType;
    String? email = widget.email;
    String? password = widget.password;
    String? profileImage = widget.profileImage;
    print(profileImage);
    bool valide = false;
    DateTime now = DateTime.now();
    Timestamp currentDate = Timestamp.fromDate(now);


    resp = await StoreData().saveData(Firstname:Firstname,Lastname:Lastname,Birthdate:Birthdate,Number:Number,licenceType:licenceType,email: email, password: password, profilefile: profileImage!,identityfile1:_identityCardImageinter1!,identityfile2:_identityCardImageinter2!, valide:valide,submissionDate:currentDate, Identitycard:identitycard,licencefile1:_licencetcardImageinter1!,licencefile2:_licencetcardImageinter2!,more1Data: more[0], more2Data: more[1],more3Data: more[2]);
  }

  showPdfDialog(BuildContext context, String pdfPath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.7,
            child: SfPdfViewer.file(File(pdfPath)),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF105EA0),
          ),
          Padding(
            padding: EdgeInsets.only(top: 85, left: 45, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Upload Identity',
                        style: TextStyle(
                          fontSize: 16,
                          color:Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_identityCardImageinter1 != null && _identityCardImageinter1!.endsWith('.pdf')) {
                          showPdfDialog(context, _identityCardImageinter1!);
                        } else {
                          selectIdentityCardImageinter1();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.400, // Set the desired width here
                        height: 100, // Increased height to accommodate the Text widget
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: _identityCardImageinter1 != null && _identityCardImageinter1!.endsWith('.pdf')
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.picture_as_pdf),
                            SizedBox(height: 5),
                            Text(
                              path.basename(_identityCardImageinter1!), // Extract only the file name
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                            : _identityCardImageinter1 != null
                            ? Image.file(File(_identityCardImageinter1!), fit: BoxFit.cover)
                            : Image.asset(
                          'assets/images/idface1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_identityCardImageinter2 != null && _identityCardImageinter2!.endsWith('.pdf')) {
                            showPdfDialog(context, _identityCardImageinter2!);
                          } else {
                            selectIdentityCardImageinter2();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.400, // Set the desired width here
                          height: 100, // Increased height to accommodate the Text widget
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 3,
                            ),
                          ),
                          child: _identityCardImageinter2 != null && _identityCardImageinter2!.endsWith('.pdf')
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.picture_as_pdf),
                              SizedBox(height: 5),
                              Text(
                                path.basename(_identityCardImageinter2!), // Extract only the file name
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                              : _identityCardImageinter2 != null
                              ? Image.file(File(_identityCardImageinter2!), fit: BoxFit.cover)
                              : Image.asset(
                            'assets/images/idface2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5),
                Text("Allowed file types.pdf.png")
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 238, left: 45, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Upload Licence',
                        style: TextStyle(
                          fontSize: 16,
                          color:Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_licencetcardImageinter1 != null && _licencetcardImageinter1!.endsWith('.pdf')) {
                            showPdfDialog(context, _licencetcardImageinter1!);
                          } else {
                            selectlicenceCardImageinter1();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.400, // Set the desired width here
                          height: 100, // Increased height to accommodate the Text widget
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 3,
                            ),
                          ),
                          child: _licencetcardImageinter1 != null && _licencetcardImageinter1!.endsWith('.pdf')
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.picture_as_pdf),
                              SizedBox(height: 5),
                              Text(
                                path.basename(_licencetcardImageinter1!), // Extract only the file name
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                              : _licencetcardImageinter1 != null
                              ? Image.file(File(_licencetcardImageinter1!), fit: BoxFit.cover)
                              : Image.asset(
                            'assets/images/idface1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child:GestureDetector(
                        onTap: () {
                          if (_licencetcardImageinter2 != null && _licencetcardImageinter2!.endsWith('.pdf')) {
                            showPdfDialog(context, _licencetcardImageinter2!);
                          } else {
                            selectlicenceCardImageinter2();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.400, // Set the desired width here
                          height: 100, // Increased height to accommodate the Text widget
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 3,
                            ),
                          ),
                          child: _licencetcardImageinter2 != null && _licencetcardImageinter2!.endsWith('.pdf')
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.picture_as_pdf),
                              SizedBox(height: 5),
                              Text(
                                path.basename(_licencetcardImageinter2!), // Extract only the file name
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                              : _licencetcardImageinter2 != null
                              ? Image.file(File(_licencetcardImageinter2!), fit: BoxFit.cover)
                              : Image.asset('assets/images/permis.png', fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5),
                Text("Allowed file types.pdf.png"),
              ],
            ),
          ),
                Positioned(
                bottom: 250,
                left:45 ,
                    child: ElevatedButton(
                    onPressed: () {
                    setState(() {
                    int nextAvailableIndex = areZonesVisible.indexOf(false);
                    if (nextAvailableIndex != -1) {
                    areZonesVisible[nextAvailableIndex] = true;
                    }
                    });
                    },
                    style: ElevatedButton.styleFrom(
                    primary:Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    ),
                    ),
                    child: Text(
                    'More',
                    style: TextStyle(
                    color:Color(0xFF0F5CA0),
                    fontFamily: 'Georgia',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                    ),
                  ),
          Stack(
                children: [
                Positioned(
    top: 450,
    left: 45,
    right: 20,
    bottom: 0,
    child: ListView(
    children: [
    for (int i = 0; i < areZonesVisible.length; i++)
    if (areZonesVisible[i])
    Column(
    children: [
    Container(
    width: MediaQuery.of(context).size.width * 0.800,
    decoration: BoxDecoration(
    border: Border.all(
    color: Colors.grey,
    width: 3,
    ),
    ),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width * 0.800,
    child: GestureDetector(
    onTap: () {
    if (more[i] != null && more[i]!.endsWith('.pdf')) {
    showPdfDialog(context, more[i]!);
    } else {
    selectMore(i); // Pass the zone index to the selectMore function
    }
    },
    child: more[i] != null && more[i]!.endsWith('.pdf')
    ? Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Icon(Icons.picture_as_pdf),
    SizedBox(height: 5),
    Text(
    path.basename(more[i]!),
    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
    ),
    ],
    )
        : more[i] != null
    ? Image.file(File(more[i]!), fit: BoxFit.cover)
        : Column(
    children: [
    Icon(Icons.file_download_outlined),
    SizedBox(height: 10),
    Text('Zone ${i + 1}: Click or drag a file to this area to upload',
    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    ),
    ],
    ),
    ),
    )
    ],
    ),
    ),

                            SizedBox(height: 10),
                                     ]
    ),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary:Color(0xFFFFFFFF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            color:Color(0xFF0F5CA0),
                                            fontFamily: 'Georgia',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    SizedBox(width: 16),
                                      ElevatedButton(
                                        onPressed: () {
                                          saveprofile();
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFFFFFFFF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: Text(
                                          'Send',
                                          style: TextStyle(
                                            color: Color(0xFF0F5CA0),
                                            fontFamily: 'Georgia',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                ],
              ),

            ],
          ),
    ),
    ]
    ),
    ]
    ),


      );
  }

}