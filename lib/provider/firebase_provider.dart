import 'dart:async';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apps/const/value.dart';
import '../model/user_model.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirebaseProvider with ChangeNotifier {
  UserModel userModel = UserModel(userId: 'userId', email: 'email');
  Future<String> upLoadImageToStorage(String path, Uint8List image) async {
    Reference ref = _storage.ref().child(path);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> saveProfile({
    String displayName = '',
    String phoneNumber = '',
    Uint8List? image,
  }) async {
    String resp = 'Errors!';
    try {
      userModel.displayName = displayName;
      userModel.phoneNumber = phoneNumber;
      User? user = FirebaseAuth.instance.currentUser;
      getFirebaseUserInfo();
      String uId = userModel.userId;
      if (user != null) {
        if (image != null) {
          userModel.imgURL = '';
          userModel.imgURL =
              await upLoadImageToStorage('/profile_image/$uId', image);
          await user.updatePhotoURL(userModel.imgURL);
        }
        await user.updateDisplayName(userModel.displayName);

        await _firestore.collection('user_profile').doc(uId).set({
          'displayName': userModel.displayName,
          'phoneNumber': userModel.phoneNumber,
          'imgURL': userModel.imgURL,
        });
        await CachedNetworkImage.evictFromCache(userModel.imgURL);
        resp = 'Success!';
      }
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }

  bool keepSignIn = false;
  Future<UserCredential?> register(
      String email, String password, String displayName) async {
    UserCredential userCredential;
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password);
      await app.delete();
      return Future.sync(() => userCredential);
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

  Future<void> signInEmailPass(String mail, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
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

  void getFirebaseUserInfo() {
    String temp = 'xzy@mail.com';
    User? user = FirebaseAuth.instance.currentUser;
    userModel.userId = user!.uid;
    if (user.email != null) {
      temp = userModel.email = user.email!;
    }
    if ((user.displayName?.isNotEmpty ?? false)) {
      userModel.displayName = user.displayName!;
    } else {
      userModel.displayName = temp.substring(0, temp.indexOf('@'));
    }
    if ((user.photoURL?.isNotEmpty ?? false)) {
      userModel.imgURL = user.photoURL!;
    } else {
      userModel.imgURL = textDefaultAva;
    }
  }

  void cleanUserInfo() {
    userModel = UserModel(userId: 'userId', email: 'email');
    print('User info cleaned!');
  }
}
