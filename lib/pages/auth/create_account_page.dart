import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../apps/const/value.dart';
import '../../provider/firebase_provider.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/input_field_widget.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _obscureText = true;
  ButtonState stateOnlyText = ButtonState.idle;
  bool isSignUpProcessing = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //controller
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool acceptTerms = false;
  void onAcceptTermsChanged(newValue) => setState(() {
        setState(() {
          acceptTerms = newValue;
        });
      });
  void onTapRegister() async {
    try {
      setState(() {
        stateOnlyText = ButtonState.loading;
        isSignUpProcessing = true;
      });
      FirebaseProvider()
          .createUser(emailController.text, passwordController.text,
              displayNameController.text)
          .onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: error.toString(), //"Please select avatar image",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }).then((user) async {
        if (user != null) {
          setState(() {
            stateOnlyText = ButtonState.idle;
            isSignUpProcessing = false;
          });
          await Fluttertoast.showToast(
              msg: textSuccess, //"Please select avatar image",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);

          Navigator.pop(context);
        }
      });
      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          stateOnlyText = ButtonState.idle;
        });
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isSignUpProcessing = false;
        });
      });
      if (!mounted) return;
    } on Exception catch (ex) {
      print('-----------EX:$ex.toString()');
    }
  }

  void onTapSignIn() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color? color;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.2,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      textGroceryApp,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                constraints: BoxConstraints(minHeight: height * 0.8),
                decoration: BoxDecoration(
                  color: color ?? Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        textCreateAccountCreateYourAccount,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        textCreateAccountMessage,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: const Color(0xff7D8FAB),
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      controller: displayNameController,
                      hintText: textUserNameHint,
                      labelText: textUserNameLabel,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    InputField(
                      controller: emailController,
                      hintText: textEmailHint,
                      labelText: textEmailLabel,
                      prefixIcon: const Icon(Icons.mail),
                    ),
                    InputField(
                      controller: passwordController,
                      hintText: textPasswordHint,
                      labelText: textPasswordLabel,
                      prefixIcon: const Icon(Icons.lock),
                      isSecure: true,
                    ),
                    AbsorbPointer(
                      absorbing: !acceptTerms,
                      child: !acceptTerms
                          ? ButtonWidget(
                              title: textSignInSignUp,
                              onTap: onTapRegister,
                              enable: acceptTerms,
                            )
                          : AbsorbPointer(
                              absorbing: isSignUpProcessing,
                              child: ProgressButton(
                                progressIndicatorAlignment:
                                    MainAxisAlignment.center,
                                stateWidgets: const {
                                  ButtonState.idle: Text(
                                    textSignInSignUp,
                                    style: TextStyle(
                                        color: Colors.white,
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
                                onPressed: onTapRegister,
                                state: stateOnlyText,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: -5,
                            children: [
                              Checkbox(
                                value: acceptTerms,
                                // checkColor: Colors.amber,
                                activeColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                      width: 2.0,
                                      color: Theme.of(context).primaryColor),
                                ),
                                onChanged: (value) {
                                  onAcceptTermsChanged(value);
                                },
                              ),
                              RichText(
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                text: TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF7D8FAB),
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: textCreateByTappingSignUp),
                                    TextSpan(
                                      text: '\n$textCreateTerms',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    const TextSpan(text: textCreateAnd),
                                    TextSpan(
                                      text: textCreateCondition,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      textCreateAccountAlreadyHaveAccount,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: const Color(0xFF7D8FAB),
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        title: textSignInButton,
                        onTap: onTapSignIn,
                        isFill: false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
