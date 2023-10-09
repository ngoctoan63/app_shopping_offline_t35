import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apps/const/value.dart';
import '../../apps/routers/router_name.dart';
import '../../provider/data_provider.dart';
import '../../provider/firebase_provider.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/input_field_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPagePageState();
}

class _SignInPagePageState extends State<SignInPage> {
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

  Future<void> onTapSignIn() async {
    print("tapped on sign in");
    try {
      FirebaseProvider()
          .signInEmailPass(emailController.text, passwordController.text)
          .onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: error.toString(), //"Please select avatar image",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            // backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
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
                    ButtonWidget(
                      title: textSignInButton,
                      onTap: onTapSignIn,
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
        floatingActionButton: DraggableFab(
          child: Consumer<DataProvider>(
            builder: (context, dataProvider, child) => FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              onPressed: () =>
                  {dataProvider.setMode(!dataProvider.isLightMode)},
              child: const Icon(
                Icons.change_circle,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
