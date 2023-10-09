import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/firebase_provider.dart';
import '../utilities/utilities_function.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Uint8List? _image;
  bool isSaveProcessing = false;
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    if (isSaveProcessing) return;
    isSaveProcessing = true;
    if (_image == null) {
      Fluttertoast.showToast(
          msg: "Please select avatar image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    String lastName = lastNameController.text;
    String fistName = firstNameController.text;
    String resp = await FirebaseProvider().saveProfile(
      lastName: lastName,
      firstName: fistName,
      image: _image!,
    );
    Fluttertoast.showToast(
        msg: "Profile saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        // backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    isSaveProcessing = false;
  }

  @override
  void initState() {
    emailController.text = email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 75,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 75,
                          backgroundImage: NetworkImage(
                              'https://m.media-amazon.com/images/M/MV5BMzdjNjExMTgtZGFmNS00ZWRjLWJmNjAtOTliYzJjYjcxMWFhXkEyXkFqcGdeQXVyMjYwNDA2MDE@._V1_.jpg'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 100,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter last name',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter fist name',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                readOnly: true,
                controller: emailController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: saveProfile, child: const Text('Save Profile')),
            ],
          ),
        ),
      ),
    );
  }
}
