import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apps/const/value.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
String displayName = "";
String userId = "";
String email = "xxx@yyy.com";
String imgURL = '';
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
    Uint8List? image,
  }) async {
    String resp = 'Errors!';
    try {
      if (image != null) {
        imgURL = await upLoadImageToStorage('/profile_image/$userId', image);
        await user?.updatePhotoURL(imgURL);
      }
      await user?.updateDisplayName(displayName);
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

  bool keepSignIn = false;
  Future<User?> createUser(String emailAddress, String password,
      [String displayName = '']) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      user = FirebaseAuth.instance.currentUser;
      userId = user!.uid;
      await user?.updateDisplayName(displayName);

      await FirebaseAuth.instance.signOut();
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw textPasswordTooWeak;
      } else if (e.code == 'email-already-in-use') {
        throw textAccountExists;
      }
      throw textCreateError;
    } catch (e) {
      print('----ccc--createUser exception:$e');
    }
    return null;
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
      if (user?.email! != null) {
        email = user!.email!;
      }

      if (user?.photoURL != null) {
        imgURL = user!.photoURL!;
      }
      if (user?.uid != null) {
        userId = user!.uid;
      }
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

  void signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(prefsKeepSignIn);
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print('Exception on sign out!!!!');
      print(e.message);
    }
  }
}
