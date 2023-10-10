import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apps/const/value.dart';
import '../../apps/routers/router_name.dart';
import '../../provider/firebase_provider.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/input_field_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPagePageState();
}

class _SignInPagePageState extends State<SignInPage> {
  ButtonState stateOnlyText = ButtonState.idle;

  bool isSignInProcessing = false;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool keepSignIn = false;
  void _onKeepSignInChanged(newValue) async {
    setState(() {
      keepSignIn = newValue;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (keepSignIn) {
      await prefs.setBool(prefsKeepSignIn, keepSignIn);
    } else {
      await prefs.remove(prefsKeepSignIn);
    }
  }

  void onTapSignIn() async {
    setState(() {
      stateOnlyText = ButtonState.loading;
      isSignInProcessing = true;
    });
    try {
      FirebaseProvider()
          .signInEmailPass(emailController.text, passwordController.text)
          .onError((error, stackTrace) {
        Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          // fontSize: 16.0,
        );
        // return null;
      });
      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          stateOnlyText = ButtonState.idle;
        });
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isSignInProcessing = false;
        });
      });
    } on Exception catch (ex) {
      print('-----------EX:$ex.toString()');
    }
  }

  void onTapCreateAccount() {
    print("tapped on  Create Account");
    // PageTransition(child: createAccountPage, type: PageTransitionType.fade);
    // Navigator.pushNamed(createAccountPage);
    Navigator.pushNamed(context, RouterName.createAccountPage);
  }

  @override
  void dispose() {
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
                height: height * 0.25,
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
                constraints: BoxConstraints(minHeight: height * 0.75),
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
                        textLoginWelcomeBack,
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
                        textLoginMessage,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: const Color(0xff7D8FAB),
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      controller: emailController,
                      hintText: textEmailHint,
                      // labelText: textEmailLabel,
                      prefixIcon: const Icon(Icons.mail),
                    ),
                    InputField(
                      controller: passwordController,
                      // hintText: textPasswordLabel,
                      hintText: textPasswordLabel,
                      prefixIcon: const Icon(Icons.lock),
                      isSecure: true,
                    ),
                    AbsorbPointer(
                      absorbing: isSignInProcessing,
                      child: ProgressButton(
                        progressIndicatorAlignment: MainAxisAlignment.center,
                        stateWidgets: const {
                          ButtonState.idle: Text(
                            textSignInButton,
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
                          ButtonState.idle: Theme.of(context).primaryColor,
                          ButtonState.loading:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          ButtonState.fail: Colors.red.shade300,
                          ButtonState.success: Colors.green.shade400,
                        },
                        onPressed: onTapSignIn,
                        state: stateOnlyText,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: -10,
                            children: [
                              Checkbox(
                                value: keepSignIn,
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
                                  _onKeepSignInChanged(value);
                                },
                              ),
                              Text(
                                textSignInKeepSignIn,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              textSignInForgotPassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ]),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      textSignInDoNotHaveAnAccount,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: const Color(0xFF7D8FAB),
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        title: textSignInDoNotCreateAnAccount,
                        onTap: onTapCreateAccount,
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
