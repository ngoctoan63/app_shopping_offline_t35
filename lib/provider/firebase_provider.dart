import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../apps/const/value.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
String displayName = "";
String userId = "";
String email = "xxx@yyy.com";
User? user;

class FirebaseProvider with ChangeNotifier {
  StreamController<String> emailStreamController =
      StreamController<String>.broadcast();
  Stream<String> get emailStream => emailStreamController.stream;
  Future<String> upLoadImageToStorage(String path, Uint8List image) async {
    Reference ref = _storage.ref().child(path);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> saveProfile({
    required String firstName,
    required String lastName,
    required Uint8List image,
  }) async {
    String resp = 'Errors!';
    try {
      String imgUrl =
          await upLoadImageToStorage('/profile_image/$userId', image);
      // await _firestore.collection('userABC').add({
      //   'lastName': lastName,
      //   'firstName': firstName,
      //   'imaUrl': imgUrl,
      // });
      resp = 'Success!';
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }

  Future<void> signInEmailPass(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = FirebaseAuth.instance.currentUser;
      userId = user!.uid;
      if (user!.displayName != null) {
        displayName = user!.displayName!;
      }
      email = user!.email!;
      emailStreamController.add(email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'INVALID_LOGIN_CREDENTIALS':
          throw textInvalidLoginCredentials;
        case 'user-not-found':
          throw textMailNotExits;
        case 'wrong-password':
          throw textWrongPass;
        default:
          throw textLoginFailed;
      }
    } catch (e) {
      print('sign in exception:$e');
    }
  }
}
