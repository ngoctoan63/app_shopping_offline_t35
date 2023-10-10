import 'dart:typed_data';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_state_button/progress_button.dart';

import '../apps/const/value.dart';
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
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  ButtonState stateOnlyText = ButtonState.idle;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    setState(() {
      stateOnlyText = ButtonState.loading;
      isSaveProcessing = true;
    });
    String lastName = lastNameController.text;
    String fistName = firstNameController.text;
    displayName = displayNameController.text;
    if (_image == null) {
      String resp = await FirebaseProvider().saveProfile(
        lastName: lastName,
        firstName: fistName,
        // _image!?image: _image!,
      );
    } else {
      String resp = await FirebaseProvider().saveProfile(
        lastName: lastName,
        firstName: fistName,
        image: _image!,
      );
    }
    Fluttertoast.showToast(
        msg: textProfileSaved,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      stateOnlyText = ButtonState.idle;
      isSaveProcessing = false;
    });
    Navigator.pop(context);
    setState(() {
      stateOnlyText = ButtonState.idle;
    });
  }

  @override
  void initState() {
    emailController.text = email;
    displayNameController.text = displayName;
    String a = imgURL;
    super.initState();
  }

  @override
  void dispose() {
    lastNameController.dispose();
    firstNameController.dispose();
    emailController.dispose();
    displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(textProfile),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
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
                        : CircleAvatar(
                            radius: 75,
                            backgroundImage: imgURL == ''
                                ? const NetworkImage(textDefaultAva)
                                // : NetworkImage(imgURL),
                                : FadeInImage.assetNetwork(
                                    placeholder: 'assets/Spinner-5.gif',
                                    image: imgURL,
                                    fit: BoxFit.cover,
                                  ).image,
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
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'Enter last name',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            hintText: 'Enter fist name',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          controller: displayNameController,
                          decoration: const InputDecoration(
                            labelText: 'Display Name',
                            hintText: textDisplayNameHint,
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          readOnly: true,
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        const SizedBox(height: 20),
                        AbsorbPointer(
                          absorbing: isSaveProcessing,
                          child: ProgressButton(
                            progressIndicatorAlignment:
                                MainAxisAlignment.center,
                            stateWidgets: const {
                              ButtonState.idle: Text(
                                textSaveProfile,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              ButtonState.loading: Text(
                                '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              ButtonState.fail: Text(
                                textFail,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              ButtonState.success: Text(
                                textSuccess,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )
                            },
                            stateColors: {
                              ButtonState.idle: Theme.of(context).primaryColor,
                              ButtonState.loading: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              ButtonState.fail: Colors.red.shade300,
                              ButtonState.success: Colors.green.shade400,
                            },
                            // onPressed: saveProfile,
                            onPressed: () async {
                              if (await confirm(
                                context,
                                content: Text(
                                  textArrYouSure,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                textOK: Text(
                                  textConfirmOK,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                                textCancel: Text(
                                  textConfirmCancel,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                              )) {
                                print('pressedOK');
                                saveProfile();
                              }
                              return print('pressedCancel');
                            },
                            state: stateOnlyText,
                          ),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
