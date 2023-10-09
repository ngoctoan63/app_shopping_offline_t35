import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apps/const/value.dart';

class AuthProvider with ChangeNotifier {
  String displayName = "";
  String userId = "";
  String email = "xxx@yyy.com";
  User? user;
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
      throw Exception(e);
    } catch (e) {
      print('createUser exception:$e');
    }
    return null;
  }

  Future<User?> signIn(String emailAddress, String password) async {
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
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'INVALID_LOGIN_CREDENTIALS':
          throw textInvalidLoginCredentials;
        default:
          throw textLoginFailed;
      }
    } catch (e) {
      print('sign in exception:$e');
    }
    return null;
  }

  void signOut(context) async {
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
