import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadProfileImageToStorage(String childName, String profilefile) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putFile(File(profilefile));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  Future<String> uploadIdentityfile1ToStorage(String childName1, String identityfile1 ) async {
    Reference ref = _storage.ref().child(childName1);
    UploadTask uploadTask = ref.putFile(File(identityfile1));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> UploadIdentityfile2ToStorage(String childName2, String identityfile2) async {
    Reference ref = _storage.ref().child(childName2);
    UploadTask uploadTask = ref.putFile(File(identityfile2));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> Uploadlicencefile1ToStorage(String childName3, String licencefile1) async {
    Reference ref = _storage.ref().child(childName3);
    UploadTask uploadTask = ref.putFile(File(licencefile1));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> Uploadlicencefile2ToStorage(String childName4, String licencefile2) async {
    Reference ref = _storage.ref().child(childName4);
    UploadTask uploadTask = ref.putFile(File(licencefile2));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> Uploadmore1ToStorage(String childName5, String more1) async {
    Reference ref = _storage.ref().child(more1);
    UploadTask uploadTask = ref.putFile(File(more1));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<String> Uploadmore2ToStorage(String childName6, String more2) async {
    Reference ref = _storage.ref().child(more2);
    UploadTask uploadTask = ref.putFile(File(more2));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<String> Uploadmore3ToStorage(String childName7, String more3) async {
    Reference ref = _storage.ref().child(more3);
    UploadTask uploadTask = ref.putFile(File(more3));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }



  Future<String> saveData({
    required String? Firstname,
    required String? Lastname,
    required String? Birthdate,
    required int? Identitycard,
   // required String phonenumber,
    required int? Number,
    required String? licenceType,
    required String? email,
    required String? password,
    required String profilefile,
    required String identityfile1,
    required String identityfile2,
    required String licencefile1,
    required String licencefile2,
    required bool valide,
    required Timestamp submissionDate,
    required String? more1Data,
    required String? more2Data,
    required String? more3Data,

  }) async {
    try {
      if (Firstname!.isNotEmpty && email!.isNotEmpty && password!.isNotEmpty) {
        String childName = 'profilefile_' + profilefile.split('/').last;
        String childName1 = 'identityfileinter1_' + identityfile1.split('/').last;
        String childName2 = 'identityfileinter2_' + identityfile2.split('/').last;
        String childName3 = 'licencefileinter1_' + licencefile1.split('/').last;
        String childName4 = 'licencefileinter2_' + licencefile2.split('/').last;
        String imageUrlprofile = await uploadProfileImageToStorage(childName, profilefile);
        String imageUrlidentity1 = await uploadIdentityfile1ToStorage(childName1, identityfile1);
        String imageUrlidentity2 = await UploadIdentityfile2ToStorage(childName2, identityfile2);
        String imageUrllicence1 = await Uploadlicencefile1ToStorage(childName3, licencefile1);
        String imageUrllicence2 = await Uploadlicencefile2ToStorage(childName4, licencefile2);

        Map<String, dynamic> dataToStore = {
          'firstName': Firstname,
          'lastName': Lastname,
          'birthDate': Birthdate,
          'identityNumber': Identitycard,
          'phoneNumber': Number.toString(),
          'licenceType': licenceType,
          'email': email,
          'password': password,
          'driverImage': imageUrlprofile,
          'identityCardImageFace1': imageUrlidentity1,
          'identityCardImageFace2': imageUrlidentity2,
          'licenceImageFace1': imageUrllicence1,
          'licenceImageFace2': imageUrllicence2,
          'submissionDate': submissionDate,
          'valid': valide,
          'more1': more1Data ?? "",
          'more2': more2Data ?? "",
          'more3': more3Data ?? "",
        };
        if (more1Data != null) {
          String childName5 = 'more1' + more1Data.split('/').last;
          String more1 = await Uploadmore1ToStorage(childName5, more1Data);
          dataToStore['more1'] = more1;
        }

        if (more2Data != null) {
          String childName6 = 'more2' + more2Data.split('/').last;
          String more2 = await Uploadmore2ToStorage(childName6, more2Data);
          dataToStore['more2'] = more2;
        }

        if (more3Data != null) {
          String childName7 = 'more3' + more3Data.split('/').last;
          String more3 = await Uploadmore3ToStorage(childName7, more3Data);
          dataToStore['more3'] = more3;
        }

        await _firestore.collection('notiNewDrivers').add(dataToStore);

        return 'success';
      } else {
        return 'Missing required fields';
      }
    } catch (err) {
      return 'Some Error Occurred';
    }
  }
}


