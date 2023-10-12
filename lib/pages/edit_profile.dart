import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_number/phone_number.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';

import '../apps/const/value.dart';
import '../apps/routers/router_name.dart';
import '../provider/firebase_provider.dart';
import '../utilities/store.dart';
import '../utilities/utilities_function.dart';
import '../widgets/zip_text_form_field.dart';
import 'home/home_page.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  final store = Store(PhoneNumberUtil());
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Uint8List? _image;
  bool isSaveProcessing = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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

    String displayName = displayNameController.text;
    String phoneNumber = phoneNumberController.text;
    String resp = await FirebaseProvider().saveProfile(
      displayName: displayName,
      phoneNumber: phoneNumber,
      image: _image,
    );

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
    // Navigator.pop(context);

    Navigator.pushReplacementNamed(context, RouterName.homePage);
    setState(() {
      stateOnlyText = ButtonState.idle;
    });
  }

  void handleOnTapPhone() {
    setState(() {
      phoneNumberController = PhoneNumberEditingController.fromValue(
        widget.store.plugin,
        phoneNumberController.value,
        regionCode: 'VN',
        behavior: PhoneInputBehavior.strict,
      );
    });
  }

  @override
  void initState() {
    emailController.text = context.read<FirebaseProvider>().userModel.email;
    String img = context.read<FirebaseProvider>().userModel.imgURL;
    displayNameController.text =
        context.read<FirebaseProvider>().userModel.displayName;
    super.initState();
  }

  @override
  void dispose() {
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () =>
                // Navigator.pushReplacementNamed(context, RouterName.homePage),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => HomePage(
                          showDrawer: true,
                        ))),
          ),
          title: const Text(textProfile),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Consumer<FirebaseProvider>(
                        builder: (context, value, child) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouterName.editProfile);
                          },
                          child: _image == null
                              ? CircleAvatar(
                                  radius: 75,
                                  child: CachedNetworkImage(
                                    imageUrl: value.userModel.imgURL,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 75,
                                  backgroundImage: MemoryImage(_image!),
                                ),
                        ),
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
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ZipTextFormField(
                            controller: displayNameController,
                            labelText: textDisplayName,
                            hintText: textDisplayNameHint,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ZipTextFormField(
                            onTap: () {
                              handleOnTapPhone();
                            },
                            controller: phoneNumberController,
                            labelText: textPhone,
                            hintText: textPhoneHint,
                            textInputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ZipTextFormField(
                            controller: emailController,
                            labelText: 'E-mail',
                            readonly: true,
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
                                ButtonState.idle:
                                    Theme.of(context).primaryColor,
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
