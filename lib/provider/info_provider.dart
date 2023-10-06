import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InfoProvider with ChangeNotifier {
  final picker = ImagePicker();
  String storedLink = '';
  // String profilePic = 'assets/images/default_avatar.png';
  String profilePic = '';
  // Future<String> url = Future.value("one");
  void getImage() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print(image?.path);
    if (image == null) return;
    String filePath = image.path;
    final storage = FirebaseStorage.instance;
    final file = File(filePath);

    final metadata = SettableMetadata(contentType: "image/jpeg");
    final storageRef = FirebaseStorage.instance.ref();

    final uploadTask = storageRef.child("images/$uid").putFile(file, metadata);
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          // ...
          // url = storageRef.getDownloadURL();
          break;
      }
    });
    uploadTask.then((res) async {
      var url = res.ref.getDownloadURL();
      profilePic = await url;
      print(profilePic);
    });
    notifyListeners();
  }
}

void pushToCloudFireStore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}
