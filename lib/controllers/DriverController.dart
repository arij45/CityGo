
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// register and sign in methods

class DriverController {


  Uint8List? _profileImage;
  Uint8List? _identityCardImage;
  Uint8List? _licencetypeImage;

  late final FirebaseAuth _auth;
  late final FirebaseStorage _storage;
  late final FirebaseFirestore _firestore;
  late final StateSetter setState;


  DriverController({required this.setState}) {
    // Perform any additional initialization here if needed
    _auth = FirebaseAuth.instance;
    _storage = FirebaseStorage.instance;
    _firestore = FirebaseFirestore.instance;
  }
  void setFirestore(FirebaseFirestore firestore) {
    this._firestore = firestore;
  }

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(
          msg: 'The password provided is too weak',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(
          msg: 'No user found for that email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        Fluttertoast.showToast(
          msg: 'Wrong password provided',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        );
      }
    }
    return user;
  }

  // delete methods

  Future<void> deleteUserAccount() async {
    final _user = _auth.currentUser;
    if (_user != null) {
      try {
        // Delete user from Firebase Authentication
        await _user.delete();

        print('User account deleted successfully');
      } catch (e) {
        print('Error deleting user account: $e');
      }
    }
  }
  Future<void> fetchAndDeleteDocument(int identitycard) async {

    QuerySnapshot querySnapshot = await _firestore
        .collection('notiNewDrivers')
        .where('identityNumber', isEqualTo: identitycard)
        .get();

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      // Delete the document
      documentSnapshot.reference.delete();
    }
  }
  Future<void> deleteImages(int identitycard) async {
    try {
      String identityImageName = 'identityfile_$identitycard';
      String profileImageName = 'profilefile_$identitycard';

      await _storage.ref().child(identityImageName).delete();
      await _storage.ref().child(profileImageName).delete();

      print('Images deleted successfully');
    } catch (e) {
      print('Error deleting images: $e');
    }
  }

  // validate methods

  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }

    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }
    return null;
  }
  static String? validatelastName({required String? lastname}) {
    if (lastname == null) {
      return null;
    }
    if (lastname.isEmpty) {
      return 'Last Name can\'t be empty';
    }
    return null;
  }
  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }
  static String? validatePhoneNumber({required String? phoneNumber}) {
    if (phoneNumber == null) {
      return null;
    }

    RegExp phoneRegExp = RegExp(r"^\+?[0-9]{1,3}-?[0-9]{4,14}$");

    if (phoneNumber.isEmpty) {
      return 'Phone number can\'t be empty';
    } else if (!phoneRegExp.hasMatch(phoneNumber)) {
      return 'Enter a valid phone number';
    }

    return null;
  }
  static String? validateIdentitycard({required String? Identitycard}) {
    if (Identitycard == null) {
      return null;
    }

    RegExp phoneRegExp = RegExp(r"^\+?[0-9]{1,3}-?[0-9]{4,14}$");

    if (Identitycard.isEmpty) {
      return 'identity card can\'t be empty';
    } else if (!phoneRegExp.hasMatch(Identitycard)) {
      return 'Enter a valid identity card';
    }

    return null;
  }


}


