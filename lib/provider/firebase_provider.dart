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

  // final Stream<DocumentSnapshot<Map<String, dynamic>>> usersStream =
  //     FirebaseFirestore.instance
  //         .collection('user_profiles')
  //         .doc('uid')
  //         .snapshots();

  late Stream<DocumentSnapshot<Map<String, dynamic>>> usersStream;

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
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userModel.email = user.email!;
        String uId = userModel.userId = user.uid;
        userModel.displayName = displayName;
        userModel.phoneNumber = phoneNumber;
        if (image != null) {
          userModel.imgURL = '';
          userModel.imgURL =
              await upLoadImageToStorage('/profile_image/$uId', image);
        }
        await _firestore.collection('user_profiles').doc(userModel.userId).set({
          'displayName': userModel.displayName,
          'email': userModel.email,
          'phoneNumber': userModel.phoneNumber,
          'imgURL': userModel.imgURL,
        });
        await CachedNetworkImage.evictFromCache(userModel.imgURL);
        resp = 'Success!';
        notifyListeners();
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

      notifyListeners();
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

    notifyListeners();
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

  void cleanUserInfo() {
    userModel = UserModel(userId: 'userId', email: 'email');
    print('User info cleaned!');

    notifyListeners();
  }

  Future<void> addUser(fullName, company, age) {
    DocumentReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('user_profiles').doc('uid');
    // Call the user's CollectionReference to add a new user
    return users
        .set({
          'full_name': fullName, // John Doe
          'company': company, // Stokes and Sons
          'age': age // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void getUserInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      usersStream = FirebaseFirestore.instance
          .collection('user_profiles')
          .doc(uid)
          .snapshots();
      print(usersStream);
    }
  }
}
