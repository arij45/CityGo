
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import '../controllers/courses.dart';

class course extends StatefulWidget {
  const course({Key? key}) : super(key: key);

  @override
  _courseState createState() => _courseState();

}

class _courseState extends State<course> {


  final courses excelData = Get.find<courses>();
  bool checkPassengers = false;
  bool checkCar = false;
  late DateTime now; // Declare the DateTime variable
  Timestamp? currentDate;
  Timestamp? selectedDate;
  String selectedDriver = '';
  List<String> driverNames = ['John Doe', 'Jane Smith', 'Michael Johnson', 'Arij Kortas',];
  late int selectedLuggage1 ;
  late int selectedLuggage2 ;
  late int selectedLuggage3 ;
  List<int> LuggageNumber1 = [0, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> LuggageNumber2 = [0, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> LuggageNumber3 = [0, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  GlobalKey<State<StatefulWidget>> _textKey1 = GlobalKey();
  GlobalKey<State<StatefulWidget>> _textKey2 = GlobalKey();
  GlobalKey<State<StatefulWidget>> _textKey3 = GlobalKey();
  final TextEditingController passengersController = TextEditingController();
  final TextEditingController RegController = TextEditingController();
  final TextEditingController SeatingCapacityController = TextEditingController();
  final TextEditingController pickuplocationController = TextEditingController();
  final TextEditingController  DropofflocationController = TextEditingController();
  late File ordre ;
  String? excel ;
  TextStyle defaultStyle = TextStyle(
    color: Color(0xFF105EA0),
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'Georgia',
  );
  TextStyle selectedStyle = TextStyle(
    color: Colors.black, // Set the desired color for the selected date
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'Georgia',
  );
  String check = '';

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate?.toDate() ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      // Date selected
      setState(() {
        selectedDate = Timestamp.fromDate(pickedDate);
      });

      // Show the time picker after selecting the date
      _selectTime(context);
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Time selected
      setState(() {
        // Update the time component of the selectedDate
        if (selectedDate != null) {
          selectedDate = Timestamp.fromDate(
            DateTime.fromMillisecondsSinceEpoch(selectedDate!.millisecondsSinceEpoch)
                .add(Duration(hours: pickedTime.hour, minutes: pickedTime.minute)),
          );
        }
      });
    }
  }

  void savecourse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? identityCard = prefs.getInt('identitynumber');
    print("aaaa");
    print(identityCard);

    int seatingcapacity = int.parse(SeatingCapacityController.text);
    int passengerNum = int.parse(passengersController.text);

      excelData.saveData(
      pickuplocation:pickuplocationController.text,
      Dropofflocation:DropofflocationController.text,
      pickupdate:currentDate,
      Dropoffdate:selectedDate,
      Passengers:passengerNum,
      LuggageHandsBag:selectedLuggage1,
      LuggageCabinBaggage:selectedLuggage2,
      LuggageCheckedBagBagages:selectedLuggage3,
      Drivername:selectedDriver,
      Reg:RegController.text,
      seatingcapacity:seatingcapacity,
      passengerDetails:excelData.passengerCarDetails.map((
      passenger) => passenger.toJson()).toList(),
      check: check,
      order:ordre,
      identityNum:identityCard,
    );
    }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }


  @override
  void initState() {
    super.initState();
    now = DateTime.now(); // Initialize the DateTime inside initState
    currentDate = Timestamp.fromDate(now);
    selectedLuggage1 = LuggageNumber1[0];
    selectedLuggage2 = LuggageNumber2[0];
    selectedLuggage3 = LuggageNumber3[0];

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    String formattedDate = '';
    if (currentDate != null) {
      // Convert the Timestamp to DateTime
      DateTime dateTime = currentDate!.toDate();

      // Format the DateTime as 'dd/MM/yyyy hh:mm'
      formattedDate = DateFormat('dd/MM/yyyy hh:mm').format(dateTime);
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 51, 51, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        // Set the preferred height of the AppBar
        child: AppBar(
          backgroundColor: Colors.transparent, // Make the AppBar transparent
          elevation: 0, // Remove the shadow
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(60.0),
                bottomLeft: Radius.circular(60.0),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/Rectangle2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            'Add course',
            style: TextStyle(
              color: Colors.white, // Set title color to white
            ),
          ),
        ),
      ),
      body:
      Padding(
      padding: EdgeInsets.only(top: 30.0, left: 18.0),
      child :Container(
        padding: EdgeInsets.only(top: 30),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        60.0),
                    topRight: Radius.circular(
                        60.0), // Adjust the value as per your requirement
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle1.png'),
                    fit: BoxFit.cover,
                  ),
                ),

              child: SingleChildScrollView(
                    child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.81,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(
                              8.0), // Adjust the value as per your requirement
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Rectangle 32.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:8,left:45),
                        // Adjust the left padding as needed

                        child: TextFormField(
                          controller: pickuplocationController,
                          style: selectedStyle,
                          decoration: InputDecoration(
                            hintText: 'pick-up location',
                            hintStyle: defaultStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.82,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(
                                8.0), // Adjust the value as per your requirement
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/images/Rectangle 32.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:8,left:45),
                          child: TextFormField(
                            controller: DropofflocationController,
                            style: selectedStyle,
                            decoration: InputDecoration(
                              hintText: 'Drop off location',
                              hintStyle: defaultStyle,
                              border: InputBorder.none,
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.41,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(
                                  8.0), // Adjust the value as per your requirement
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/Rectangle 34.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Pick-Up Date',
                                style: defaultStyle,
                              ),
                              SizedBox(height: 8),
                              Text(
                                formattedDate,
                                style: selectedStyle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.40,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              topLeft: Radius.circular(
                                  8.0), // Adjust the value as per your requirement
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/Rectangle 34.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () => _selectDate(context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    selectedDate == null ? 'Return' : 'Drop off date',
                                    style: defaultStyle,
                                  ),
                                  SizedBox(height: 8), // Add some spacing between the texts
                                  selectedDate != null
                                      ? Text(
                                    DateFormat('dd/MM/yyyy HH:mm').format(selectedDate!.toDate()),
                                    style: selectedStyle,
                                  )
                                      : SizedBox(), // Hide the selected date when "Drop off date" is shown
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.84,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.103,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(
                              8.0), // Adjust the value as per your requirement
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Rectangle 32.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:8,left:45),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Passengers',
                              style: TextStyle(
                                color: Color(0xFF0F5CA0),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Georgia',
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Color(0xFF0F5CA0),
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: passengersController,
                                    keyboardType: TextInputType.number,
                                    style: selectedStyle,
                                    decoration: InputDecoration(
                                      hintText: 'Enter number of passengers',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.84,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(
                              8.0), // Adjust the value as per your requirement
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Rectangle 32.png'),
                          fit: BoxFit.cover,
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(top:8,left:45),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.circular(20.0)),
                                  ),
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 12), // Add padding around the content
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.15,
                                            height: MediaQuery.of(context).size.height * 0.4,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Hands Bag',
                                                  style: TextStyle(
                                                    color: Color(0xFF0F5CA0),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Georgia',
                                                  ),
                                                ),
                                                SizedBox(height: 9),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.5,
                                                  height: MediaQuery.of(context).size.height * 0.06,
                                                  color: Color(0xFF0F5CA0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/luggage1.png',
                                                        width: 24,
                                                        height: 24,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        child: DropdownButton<int>(
                                                          value: selectedLuggage1,
                                                          items: LuggageNumber1.map((number) {
                                                            return DropdownMenuItem<int>(
                                                              value: number,
                                                              child: Text(
                                                                number.toString(),
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'Georgia',
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newValue) {
                                                            setState(() {
                                                              selectedLuggage1 = newValue!;
                                                            });
                                                            _textKey1.currentState?.setState(() {});
                                                          },
                                                          underline: Container(),
                                                          isExpanded: false,
                                                          icon: Icon(
                                                            Icons.arrow_drop_down,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Cabin Baggage',
                                                  style: TextStyle(
                                                    color: Color(0xFF0F5CA0),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Georgia',
                                                  ),
                                                ),
                                                SizedBox(height: 9),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.5,
                                                  height: MediaQuery.of(context).size.height * 0.06,
                                                  color: Color(0xFF0F5CA0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/luggage2.png',
                                                        width: 24,
                                                        height: 24,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        child: DropdownButton<int>(
                                                          value: selectedLuggage2,
                                                          items: LuggageNumber2.map((number) {
                                                            return DropdownMenuItem<int>(
                                                              value: number,
                                                              child: Text(
                                                                number.toString(),
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'Georgia',
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newValue) {
                                                            setState(() {
                                                              selectedLuggage2 = newValue!;
                                                            });
                                                            _textKey2.currentState?.setState(() {});
                                                          },
                                                          underline: Container(),
                                                          isExpanded: false,
                                                          icon: Icon(
                                                            Icons.arrow_drop_down,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Checked BagBagages',
                                                  style: TextStyle(
                                                    color: Color(0xFF0F5CA0),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Georgia',
                                                  ),
                                                ),
                                                SizedBox(height: 9),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.5,
                                                  height: MediaQuery.of(context).size.height * 0.06,
                                                  color: Color(0xFF0F5CA0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/luggage3.png',
                                                        width: 24,
                                                        height: 24,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        child: DropdownButton<int>(
                                                          value: selectedLuggage3,
                                                          items: LuggageNumber3.map((number) {
                                                            return DropdownMenuItem<int>(
                                                              value: number,
                                                              child: Text(
                                                                number.toString(),
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'Georgia',
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newValue) {
                                                            setState(() {
                                                              selectedLuggage3 = newValue!;
                                                            });
                                                            _textKey3.currentState?.setState(() {});
                                                          },
                                                          underline: Container(),
                                                          isExpanded: false,
                                                          icon: Icon(
                                                            Icons.arrow_drop_down,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Add',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Georgia',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF105EA0)),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(25),
                                                      ),
                                                    ),
                                                    minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.2, 40)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Luggage',
                                style: TextStyle(
                                  color: Color(0xFF0F5CA0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Georgia',
                                ),
                              ),
                            ),
                          Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.47,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Row(
                          children: [
                           Image.asset('assets/images/luggage1.png', width: 24, height: 24),
                            SizedBox(width: 3),
                                  StatefulBuilder(
                                  key: _textKey1,
                                  builder: (BuildContext context, StateSetter setState) {
                                    return Text(
                                      selectedLuggage1.toString(),
                                      // Display selectedLuggage1 value
                                      style: selectedStyle,
                                    );
                                  }
                                ),
                            SizedBox(width: 8),
                            Image.asset('assets/images/luggage2.png', width: 24, height: 24),
                            SizedBox(width: 3),
                                StatefulBuilder(
                                key: _textKey2,
                                builder: (BuildContext context, StateSetter setState) {
                                  return Text(
                                    selectedLuggage2.toString(),
                                    style: selectedStyle,
                                  );
                                }
                                ),
                            SizedBox(width: 8),
                            Image.asset('assets/images/luggage3.png', width: 24, height: 24),
                            SizedBox(width: 3),
                             StatefulBuilder(
                              key: _textKey3,
                              builder: (BuildContext context, StateSetter setState) {
                                return Text(
                                  selectedLuggage3.toString(),
                                  style: selectedStyle,
                                );
                              }
                             ),
                          ],
                        ),

                            ),
                          ),
                      ]
                    ),
                    ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.84,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(
                              8.0), // Adjust the value as per your requirement
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Rectangle 32.png'),
                          fit: BoxFit.cover,
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(left:45),
                        child: DropdownButton<String>(
                          icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                          value: selectedDriver.isEmpty ? null : selectedDriver,
                          hint: Text(
                            'Driver name',
                            style: TextStyle(
                              color: Color(0xFF0F5CA0),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Georgia',
                            ),
                          ),
                          items: driverNames.map((name) {
                            return DropdownMenuItem<String>(
                              value: name,
                              child: Text(name, style:selectedStyle),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedDriver = newValue!;
                            });
                          },
                          underline: Container(),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.84,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.103,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(
                              8.0), // Adjust the value as per your requirement
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Rectangle 32.png'),
                          fit: BoxFit.cover,
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(top:8,left:45),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reg n°',
                              style: TextStyle(
                                color: Color(0xFF0F5CA0),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Georgia',
                              ),
                            ),
                            TextFormField(
                              controller: RegController,
                              style: selectedStyle,
                              decoration: InputDecoration(
                                hintText: 'Enter Reg n°',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.84,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.103,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(
                              8.0), // Adjust the value as per your requirement
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Rectangle 32.png'),
                          fit: BoxFit.cover,
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(top:8,left:45),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seating capacity',
                              style: TextStyle(
                                color: Color(0xFF0F5CA0),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Georgia',
                              ),
                            ),
                            TextFormField(
                              controller: SeatingCapacityController,
                              keyboardType: TextInputType.number,
                              style: selectedStyle,
                              decoration: InputDecoration(
                                hintText: 'Enter Seating capacity',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Checkbox(
                          side: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          value: checkPassengers,
                          onChanged: (bool? value) {
                            setState(() {
                              checkPassengers = value ?? false;
                              checkCar = !checkPassengers;
                              check = checkPassengers ? 'passengers' : (checkCar ? 'car' : '');
                            });
                            excelData.importFromExcel();
                          },
                        ),
                        Text(
                          'Check passengers',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Georgia',
                          ),
                        ),
                        SizedBox(width: 20),
                        Checkbox(
                          side: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          value: checkCar,
                          onChanged: (bool? value) {
                            setState(() {
                              checkCar = value ?? false;
                              checkPassengers = !checkCar;
                              check = checkPassengers ? 'passengers' : (checkCar ? 'car' : '');
                            });
                              showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.circular(20.0)),
                                  ),
                                  child: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        ListTile(
                                                          leading: Icon(Icons.camera,color:Color(0xFF437FE6)),
                                                          title: Text('Take a Photo',
                                                          style:selectedStyle),
                                                          onTap: () async {
                                                            Navigator.pop(context);
                                                            File? cameraImage = await excelData.pickOrder(true);
                                                            if (cameraImage != null) {
                                                                  setState(() {
                                                                  ordre = cameraImage;
                                                                  print("ordre: $ordre");
                                                                  });
                                                                  }
                                                                   }
                                                            ),
                                                        ListTile(
                                                          leading: Icon(Icons.photo_library,color:Color(0xFF437FE6)),
                                                          title: Text('Choose an Image',style:selectedStyle),
                                                          onTap: () async {
                                                            Navigator.pop(context);
                                                            File? galleryImage = await excelData.pickOrder(false);
                                                            if (galleryImage != null) {
                                                              setState(() {
                                                                ordre = galleryImage;
                                                                print("ordre: $ordre");
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                            },
                                            child: Text(
                                              'Add an order',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Georgia',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                Color(0xFF437FE6),
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                              ),
                                              minimumSize: MaterialStateProperty.all(
                                                Size(MediaQuery.of(context).size.width * 0.2, 40),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await excelData.importFromExcel();
                                            },
                                            child: Text(
                                              'Add list of passengers',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Georgia',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                Color(0xFF437FE6),
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                              ),
                                              minimumSize: MaterialStateProperty.all(
                                                Size(MediaQuery.of(context).size.width * 0.2, 40),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // Add another SizedBox for spacing
                                          ElevatedButton(
                                            onPressed: (){
                                                if (( excelData.cameraImage== null)&&(excelData.result==null)) {
                                                  showToast("Please select the order!");
                                                          }
                                                   else if(excelData.pickedFile == null){
                                                  showToast("Please select the list of passengers!");
                                                }
                                                else {
                                                  print("mrigeel");
                                                  Navigator.pop(context);
                                                    }
                                            },
                                            child: Text(
                                              'Next',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Georgia',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                Color(0xFF333333),
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                              ),
                                              minimumSize: MaterialStateProperty.all(
                                                Size(MediaQuery.of(context).size.width * 0.2, 40),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Text(
                          'Check car',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Georgia',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () async {
                        savecourse();

                        //showToast("details are missed");
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Georgia',
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF105EA0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.4, 40)),
                      ),
                    ),
                  ],
                ),

              ),
            ),
      ),
      ),
    );
  }
}