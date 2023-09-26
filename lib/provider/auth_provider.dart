import 'package:denshihanbai/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apps/const/value.dart';
import '../apps/routers/router_name.dart';

class AuthProvider with ChangeNotifier {
  String displayName = "";
  String email = "xxx@yyy.com";
  User? user;
  bool isCreateUserSuccess = false;
  bool keepSignIn = false;
  void createUser(context, String emailAddress, String password,
      [String displayName = '']) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      user = FirebaseAuth.instance.currentUser;

      await user?.updateDisplayName(displayName);
      isCreateUserSuccess = true;
      // await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, RouterName.signInPage);
    } on FirebaseAuthException catch (e) {
      isCreateUserSuccess = false;
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        throw Exception(e);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // return Future.error('ccc');
        throw Exception(e);
      }
    } catch (e) {
      print(e);
    }
  }

  void signIn(context, String emailAddress, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // displayName = name!;
        final eMail = user!.email;
        displayName = email = eMail!;
        if (user!.displayName != null) displayName = (user!.displayName)!;
      }
      Navigator.pushReplacementNamed(context, RouterName.homePage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void signOut(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(prefsKeepSignIn);
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, RouterName.signInPage);
    } on FirebaseAuthException catch (e) {
      print('Exception on sign out!!!!');
      print(e.message);
    }
  }
}
