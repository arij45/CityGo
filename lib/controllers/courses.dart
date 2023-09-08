import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Course.dart';
import '../view/rowdata.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class courses extends GetxController {

  late bool fromCamera;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? dropOffLocation;
  RxList<rowdata> passengerCarDetails = RxList<rowdata>([]);
  Rx<FilePickerResult?> _pickedFile = Rx<FilePickerResult?>(null);

  FilePickerResult? get pickedFile => _pickedFile.value;
  Rx<XFile?> _cameraImage = Rx<XFile?>(null);

  XFile? get cameraImage => _cameraImage.value;
  Rx<FilePickerResult?> _result = Rx<FilePickerResult?>(null);

  FilePickerResult? get result => _result.value;


  late Timestamp dropOffDate;

  late Timestamp pickUpDate;

  var coursesListAdmin = <Course>[].obs;
  var coursesListDriver = <Course>[].obs;

/////////////admin////////////////
  var coursesList = <Course>[].obs;
  var coursesListToday = <Course>[].obs;
  var coursesListTomorrow = <Course>[].obs;

  /////////////driver////////////////
  var coursesListDrivers = <Course>[].obs;
  var coursesListTodayDrivers = <Course>[].obs;
  var coursesListTomorrowDrivers = <Course>[].obs;

  Future<void> fetchCourses() async {
    try {
      RxBool isLoading = RxBool(false); // Initialize isLoading
      isLoading.value = true;
      QuerySnapshot courses = await FirebaseFirestore.instance
          .collection('courses')
          .orderBy('pickUpDate', descending: true)
          .get();
      if (courses.docs.isNotEmpty) {
        print('Courses is not empty.');
        // You can also print the number of documents fetched:
        print('Number of documents fetched: ${courses.docs.length}');
      } else {
        print('Courses is empty.');
      }

      coursesListAdmin.clear();
      coursesListDriver.clear();

      for (var course in courses.docs) {
        var courseData = course.data() as Map<String, dynamic>;

        if (courseData.containsKey('dropOffDate')) {
          Timestamp dropOffDate = courseData['dropOffDate'];

          if (courseData.containsKey('pickUpDate')) {
            Timestamp pickUpDate = courseData['pickUpDate'];

            if (courseData.containsKey('idAdmin')) {
              Course adminCourse = Course(
                check: courseData['check'],
                id: course.id,
                pickUpLocation: courseData['pickUpLocation'],
                dropOffLocation: courseData['dropOffLocation'],
                pickUpDate: pickUpDate.toDate(),
                passengersNum: courseData['passengersNum'],
                seatingCapacity: courseData['seatingCapacity'],
                regNumber: courseData['regNumber'],
                driverName: courseData['driverName'],
                identityNum: courseData['identityNum'],
                dropOffDate: dropOffDate.toDate(),
              );
              coursesListAdmin.add(adminCourse);
              print('dateAdmin: ${adminCourse.pickUpDate}');
            } else {
              print("true");

              Course driverCourse = Course(
                check: courseData['check'],
                id: course.id,
                pickUpLocation: courseData['pickUpLocation'],
                dropOffLocation: courseData['dropOffLocation'],
                pickUpDate: pickUpDate.toDate(),
                passengersNum: courseData['passengersNum'],
                seatingCapacity: courseData['seatingCapacity'],
                regNumber: courseData['regNumber'],
                driverName: courseData['driverName'],
                identityNum: courseData['identityNum'],
                dropOffDate: dropOffDate.toDate(),
              );
              coursesListDriver.add(driverCourse);
              print('dateDriver: ${driverCourse.pickUpDate}');
            }
          }
        }
      }

      // Filter courses for today and tomorrow for Admin
        filterCoursesTodayAdmin();
       filterCoursesTomorrowAdmin();

      // Filter courses for today and tomorrow for Driver
      filterCoursesTodayDriver();
      filterCoursesTomorrowDriver();

      isLoading.value = false;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }


////////////////////////Admin/////////////////

    void filterCoursesTodayAdmin() {
    DateTime currentDate = DateTime.now();
    coursesListToday.assignAll(coursesListAdmin.where((course) =>
    course.pickUpDate.year == currentDate.year
    && course.pickUpDate.month == currentDate.month
    && course.pickUpDate.day == currentDate.day
    ));
      for (var course in coursesListToday) {
        print('Course ID AdminT: ${course.id}');
        print('Pickup Location AdminT : ${course.pickUpLocation}');
        print('Dropoff Location AdminT: ${course.dropOffLocation}');
      }
    }

    void filterCoursesTomorrowAdmin() {
     DateTime currentDate = DateTime.now();
    coursesListTomorrow.assignAll(coursesListAdmin.where((course) =>
    course.pickUpDate.year == currentDate.add(Duration(days: 1)).year
    && course.pickUpDate.month == currentDate.add(Duration(days: 1)).month
    && course.pickUpDate.day == currentDate.add(Duration(days: 1)).day
    ));
     for (var course in coursesListTomorrow) {
       print('Course ID AdminTo: ${course.id}');
       print('Pickup Location AdminTo : ${course.pickUpLocation}');
       print('Dropoff Location AdminTo: ${course.dropOffLocation}');
     }
    }


  ///////////////////driver///////////////////////////
  void filterCoursesTodayDriver() {
    DateTime currentDate = DateTime.now();
    print('$currentDate');
    coursesListTodayDrivers.assignAll(coursesListDriver.where((course) =>
    course.pickUpDate.year == currentDate.year
        && course.pickUpDate.month == currentDate.month
        && course.pickUpDate.day == currentDate.day
    ));
    for (var course in coursesListTodayDrivers) {
      print('Course ID DriverT: ${course.id}');
      print('Pickup Location DriverT : ${course.pickUpLocation}');
      print('Dropoff Location DriverT: ${course.dropOffLocation}');
    }
  }

  void filterCoursesTomorrowDriver() {
      DateTime currentDate = DateTime.now();
    coursesListTomorrowDrivers.assignAll(coursesListDriver.where((course) =>
    course.pickUpDate.year == currentDate.add(Duration(days: 1)).year
    && course.pickUpDate.month == currentDate.add(Duration(days: 1)).month
    && course.pickUpDate.day == currentDate.add(Duration(days: 1)).day
    ));
      for (var course in coursesListTodayDrivers) {
        print('Course ID DriverTo: ${course.id}');
        print('Pickup Location DriverTo : ${course.pickUpLocation}');
        print('Dropoff Location DriverTo: ${course.dropOffLocation}');
      }

    }


    void filter(String prefix) {
     coursesListToday.assignAll(coursesListAdmin.where((course) =>
      course.dropOffLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
          && course.pickUpDate.year == DateTime
          .now()
          .year
          && course.pickUpDate.month == DateTime
          .now()
          .month
          && course.pickUpDate.day == DateTime
          .now()
          .day
      ));
      coursesListTomorrow.assignAll(coursesListAdmin.where((course) =>
      course.dropOffLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
          && course.pickUpDate.year == DateTime
          .now()
          .add(Duration(days: 1))
          .year
          && course.pickUpDate.month == DateTime
          .now()
          .add(Duration(days: 1))
          .month
          && course.pickUpDate.day == DateTime
          .now()
          .add(Duration(days: 1))
          .day
      ));

      coursesList.assignAll(coursesListAdmin.where((course) =>
      course.dropOffLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
          && !coursesListToday.contains(course)
          && !coursesListTomorrow.contains(course)
      ));

      coursesListTodayDrivers.assignAll(coursesListDriver.where((course) =>
      course.dropOffLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
          && course.pickUpDate.year == DateTime
          .now()
          .year
          && course.pickUpDate.month == DateTime
          .now()
          .month
          && course.pickUpDate.day == DateTime
          .now()
          .day
      ));

      coursesListTomorrowDrivers.assignAll(coursesListDriver.where((course) =>
      course.dropOffLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
          && course.pickUpDate.year == DateTime
          .now()
          .add(Duration(days: 1))
          .year
          && course.pickUpDate.month == DateTime
          .now()
          .add(Duration(days: 1))
          .month
          && course.pickUpDate.day == DateTime
          .now()
          .add(Duration(days: 1))
          .day
      ));
      coursesListDrivers.assignAll(coursesListDriver.where((course) =>
      course.dropOffLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
          && !coursesListToday.contains(course)
          && !coursesListTomorrow.contains(course)
      ));

    }


    Future<String> uploadorderToStorage(String childName, File order) async {
      Reference ref = _storage.ref().child(childName);
      UploadTask uploadTask = ref.putFile(order);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }

    Future<void> importFromExcel() async {
      passengerCarDetails = RxList<rowdata>([]);

      _pickedFile.value = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        allowMultiple: false,
      );

      if (pickedFile != null && pickedFile!.files.isNotEmpty) {
        PlatformFile file = pickedFile!.files.first;
        var bytes = File(file.path!).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        print("teeest${file.path!}");

        // Assuming the data starts from the second row, as the first row may contain headers.
        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows.skip(1)) {
            String firstname = row[0]?.value.toString() ?? '';
            String lastName = row[1]?.value.toString() ?? '';
            String identityNum = row[2]?.value.toString() ?? '';

            passengerCarDetails.add(
              rowdata(
                firstname: firstname,
                lastName: lastName,
                identityNum: identityNum,
              ),
            );
          }
        }
        print(passengerCarDetails);
      }
    }

    Future<String> saveData({
      required String pickuplocation,
      required String Dropofflocation,
      required Timestamp? pickupdate,
      required Timestamp? Dropoffdate,
      required int Passengers,
      required int LuggageHandsBag,
      required int LuggageCabinBaggage,
      required int LuggageCheckedBagBagages,
      required String Drivername,
      required String Reg,
      required int seatingcapacity,
      required int? identityNum,
      List<Map<String, dynamic>>? passengerDetails,
      required File order,
      required String check,

    }) async {
      try {
        String childName = 'orderfile_' + path.basename(order.path);
        String imageUrlorder = await uploadorderToStorage(childName, order!);
        Map<String, dynamic> dataToStore = {
          'pickUpLocation': pickuplocation,
          'dropOffLocation': Dropofflocation,
          'pickUpDate': pickupdate,
          if (Dropoffdate != null) 'dropOffDate': Dropoffdate,
          'passengersNum': Passengers,
          'luggageHandsBag': LuggageHandsBag,
          'luggageCabinBaggage': LuggageCabinBaggage,
          'luggageCheckedBagBagages': LuggageCheckedBagBagages,
          'driverName': Drivername,
          'regNumber': Reg,
          'seatingCapacity': seatingcapacity,
          'passengersDetails': passengerDetails,
          if (imageUrlorder != null) 'orderUrl': imageUrlorder,
          'identityNum': identityNum,
          'check': check,
        };

        await _firestore.collection('courses').add(dataToStore);
        return 'success';
      } catch (err) {
        return 'Some Error Occurred';
      }
    }


    pickOrder(bool fromCamera) async {
      if (fromCamera) {
        _cameraImage.value = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );

        final cameraImage = this.cameraImage;
        if (cameraImage != null) {
          print("Camera image path: ${cameraImage.path}");
          return File(cameraImage.path);
        }
        else {}
      } else {
        _result.value = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'png', 'jpg'],
        );

        print('FilePickerResult: $result');

        if (result?.files?.isNotEmpty ?? false) {
          return File(result?.files.first.path ?? '');
        }
      }

      print("No Images Selected");
      return null;
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
  }
