import 'dart:io';
import 'package:citygo/view/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../controllers/DriverController.dart';
import 'package:intl/intl.dart';
import 'imagesPage.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpScreen extends StatefulWidget {
  late final VoidCallback? onProfileImageSelected;
  SignUpScreen({Key? key, this.onProfileImageSelected}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {




  int identitycard = 0;
  int Number = 0;

  String? profileImage;
  String? _birthDateError;
  String? selectedLicenseType;
  bool showError = false;
  List<String> licenseTypeOptions = ['A1', 'A', 'B', 'B+E', 'C', 'C+E']; // Replace with your license type options


  void selectProfileImage() async {
    String? img = await pickImage();
    setState(() {
      profileImage = img;
    });

    // Call the callback if provided
    if (widget.onProfileImageSelected != null) {
      widget.onProfileImageSelected!();
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profileimage', profileImage!);
  }

  final _registerFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _phonenumberTextController = TextEditingController();
  final _lastnameTextController = TextEditingController();
  final _birthTextController = TextEditingController();
  final _identitycardTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusLastname = FocusNode();
  final _focusbirthdate = FocusNode();
  final _focusidentitycard = FocusNode();
  final _focuslicencetype = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusphoneNumber = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _focusName.unfocus();
          _focusEmail.unfocus();
          _focusPassword.unfocus();
          _focusLastname.unfocus();
          _focusbirthdate.unfocus();
          _focusidentitycard.unfocus();
          _focuslicencetype.unfocus();
          _focusphoneNumber.unfocus();
        },
        child: Scaffold(
            body: Stack(
                children: [
                  Container(
                    color: Color(0XFF105EA0),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 30.0, left: 15),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.arrow_back_sharp,
                                  color: Color(0xFFD9D9D9),
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                          Container(
                            width: 253,
                            height: 47,
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.only(left: 45),
                            child: Text(
                              'Become a driver',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Georgia',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                if (profileImage == null)
                                  CircleAvatar(
                                    radius: 64,
                                    backgroundImage: AssetImage('assets/images/profile.png'),
                                  )
                                else
                                  CircleAvatar(
                                    radius: 64,
                                    backgroundImage: FileImage(File(profileImage!)),
                                  ),
                                Positioned(
                                  bottom: -15,
                                  left: 80,
                                  child: IconButton(
                                    key: const Key('Icon'),
                                    onPressed: () {
                                      selectProfileImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                     Padding(
                      padding: EdgeInsets.only(left: 45),
                          child: Form(
                            key: _registerFormKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _nameTextController,
                                  focusNode: _focusName,
                                  validator: (value) =>
                                      DriverController.validateName(
                                        name: value,
                                      ),
                                  decoration: InputDecoration(
                                    hintText: "First Name",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Georgia',
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      // Specify the desired color for the hint text
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          6.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueAccent,
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
                                SizedBox(height: 12.0),
                                TextFormField(
                                  controller: _lastnameTextController,
                                  focusNode: _focusLastname,
                                  validator: (value) =>
                                      DriverController.validatelastName(
                                        lastname: value,
                                      ),
                                  decoration: InputDecoration(
                                    hintText: "Last Name",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Georgia',
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      // Specify the desired color for the hint text
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          6.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueAccent,
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
                                SizedBox(height: 12.0),
                                TextField(
                                  readOnly: true,
                                  controller: _birthTextController,
                                  focusNode: _focusbirthdate,
                                  onTap: () async {

                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                    );

                                    if (selectedDate != null) {
                                      final currentDate = DateTime.now();

                                      if (selectedDate.isAfter(currentDate)) {
                                        setState(() {
                                          _birthTextController.text = ''; // Clear the text field
                                          _birthDateError = 'Birth date cannot be in the future';
                                        });
                                      } else {
                                        final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
                                        setState(() {
                                          _birthTextController.text = formattedDate;
                                          _birthDateError = null; // Clear the error message
                                        });
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Birth Date",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Georgia',
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorText: _birthDateError, // Display the birth date error message here
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                TextFormField(
                                  controller: _identitycardTextController,
                                  focusNode: _focusidentitycard,
                                  validator: (value) => DriverController.validateIdentitycard(
                                    Identitycard: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Identity Card",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Georgia',
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                TextFormField(
                                  controller: _phonenumberTextController,
                                  focusNode: _focusphoneNumber,
                                  validator: (value) =>
                                      DriverController.validatePhoneNumber(
                                        phoneNumber: value,
                                      ),
                                  decoration: InputDecoration(
                                    hintText: "Phone number",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Georgia',
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      // Specify the desired color for the hint text
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          6.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueAccent,
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
                                SizedBox(height: 12.0),
                                DropdownButtonFormField<String>(
                                  focusNode: _focuslicencetype,
                                  value: selectedLicenseType,
                                  icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                                  items: licenseTypeOptions.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedLicenseType = newValue;
                                      showError = false; // Reset the error state when a new option is selected
                                    });
                                  },
                                  dropdownColor: Colors.white,
                                  decoration: InputDecoration(
                                    hintText: "License Type",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Georgia',
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    errorText: showError ? 'Licence type cannot be empty' : null,
                                    icon: null,
                                  ),
                                  style: TextStyle(color: Colors.white), // Set the dropdown menu items' text color
                                  selectedItemBuilder: (BuildContext context) {
                                    return licenseTypeOptions.map<Widget>((String option) {
                                      return Text(
                                        option,
                                        style: TextStyle(color: Colors.black), // Set the selected value text color to black
                                      );
                                    }).toList();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      setState(() {
                                        showError = true;
                                      });
                                      return 'Licence type cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 12.0),
                                TextFormField(
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  validator: (value) =>
                                      DriverController.validateEmail(
                                        email: value,
                                      ),
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Georgia',
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      // Specify the desired color for the hint text
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          6.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueAccent,
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
                                SizedBox(height: 12.0),
                                TextFormField(
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
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      // Specify the desired color for the hint text
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          6.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueAccent,
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
                                SizedBox(height: 12.0),
                                _isProcessing
                                    ? CircularProgressIndicator()
                                    :Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 60,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                            if (_birthTextController.text
                                                .trim()
                                                .isEmpty) {
                                              _birthDateError =
                                              'Birth date cannot be empty';
                                            }
                                            else if (profileImage == null) {
                                              Fluttertoast.showToast(
                                                msg: 'Select a profile image',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black87,
                                                textColor: Colors.white,
                                              );
                                            }
                                            else if ((_birthTextController.text
                                                .trim()
                                                .isEmpty) ||
                                                (_nameTextController.text
                                                    .trim()
                                                    .isEmpty) ||
                                                (_emailTextController.text
                                                    .trim()
                                                    .isEmpty) ||
                                                (_passwordTextController.text
                                                    .trim()
                                                    .isEmpty) ||
                                                (_phonenumberTextController.text
                                                    .trim()
                                                    .isEmpty) ||
                                                (_lastnameTextController.text
                                                    .trim()
                                                    .isEmpty) ||
                                                (_identitycardTextController
                                                    .text
                                                    .trim()
                                                    .isEmpty)) {
                                              Fluttertoast.showToast(
                                                msg: 'contact details are missed',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black87,
                                                textColor: Colors.white,
                                              );
                                            }
                                            else {
                                             Number = int.tryParse(
                                                 _phonenumberTextController
                                                        .text) ?? 0;
                                                 identitycard = int.tryParse(
                                                 _identitycardTextController
                                                      .text) ?? 0;

                                                 // Check if the collection exists
                                                 QuerySnapshot<Map<String, dynamic>> collectionSnapshot =
                                                 await FirebaseFirestore.instance.collection('notiNewDrivers').limit(1).get();
                                                 if (collectionSnapshot.docs.isEmpty) {
                                                // Collection does not exist, directly navigate to images page and save data
                                            navigatetoimagesPage(
                                            Firstname: _nameTextController.text,
                                            Lastname: _lastnameTextController.text,
                                            Birthdate: _birthTextController.text,
                                            Number: Number,
                                            email: _emailTextController.text,
                                            password: _passwordTextController.text,
                                            profileImage: profileImage,
                                            identitycard: identitycard,
                                            licenceType: selectedLicenseType,
                                            );
                                            saveData();
                                            } else {
                                            // Collection exists, perform identity and email check
                                            await handleIdentityAndEmailCheck();
                                            }
                                            }
                                          if (_registerFormKey.currentState!.validate()) {
                                            User? user = await DriverController.registerUsingEmailPassword(
                                              name: _nameTextController.text,
                                              email: _emailTextController.text,
                                              password: _passwordTextController.text,
                                            );

                                            setState(() {
                                              _isProcessing = false;
                                            });
                                          }
                                        },
                                        child: Text(
                                          'Next',
                                          style: TextStyle(
                                            color: Color(0xFF0F5CA0),
                                            fontFamily: 'Georgia',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                     )
                        ],
                    ),
                  ),
                ]
            ),
        ),
    );
  }

  void navigatetoimagesPage(
      {required int identitycard, required String Firstname, required String Lastname, required String Birthdate, required int Number, required String email, required String password, required String? profileImage, required String? licenceType}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ImagesPage(identitycard: identitycard,
                Firstname: Firstname,
                Lastname: Lastname,
                Birthdate: Birthdate,
                Number: Number,
                licenceType: licenceType,
                email: email,
                password: password,
                profileImage: profileImage),
      ),
    );
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _emailTextController.text);
    prefs.setString('firstname', _nameTextController.text);
    prefs.setString('lastname', _lastnameTextController.text);
    prefs.setInt('identitynumber', identitycard);
    prefs.setString('birthdate', _birthTextController.text);
    prefs.setString('driverImage', profileImage!);
    prefs.setString('password', _passwordTextController.text);
    prefs.setInt('phonenumber', Number);
    prefs.setString('licence', selectedLicenseType!);
  }

  handleIdentityAndEmailCheck() async {


   QuerySnapshot<Map<String,
    dynamic>> identitySnapshot = await FirebaseFirestore
        .instance
        .collection('notiNewDrivers')
        .where('identityNumber',
    isEqualTo: identitycard)
        .get();

    QuerySnapshot<Map<String, dynamic>> emailSnapshot = await FirebaseFirestore.instance
        .collection('notiNewDrivers')
        .where('email', isEqualTo: _emailTextController.text)
        .get();

    if (identitySnapshot.docs.isNotEmpty) {
    Fluttertoast.showToast(
    msg: 'Identity card already exists. Please change it.',
    toastLength: Toast
        .LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors
        .black87,
    textColor: Colors.white,
    );
    }
    /*else if (emailSnapshot.docs.isNotEmpty) {
    // Email already exists, show a toast message
    Fluttertoast.showToast(
    msg: 'Email already exists. Please change it.',
    toastLength: Toast
        .LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors
        .black87,
    textColor: Colors.white,
    );
    }

     */
    else {
    navigatetoimagesPage(
    Firstname: _nameTextController
        .text,
    Lastname: _lastnameTextController
        .text,
    Birthdate: _birthTextController
        .text,
    Number: Number,
    email: _emailTextController
        .text,
    password: _passwordTextController
        .text,
    profileImage: profileImage,
    identitycard: identitycard,
    licenceType: selectedLicenseType);
    saveData();
    }
    }
  }
