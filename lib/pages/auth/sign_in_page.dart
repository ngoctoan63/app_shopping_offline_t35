import 'package:flutter/material.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../apps/const/value.dart';
import '../../apps/routers/router_name.dart';
import '../../provider/data_provider.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/input_field_widget.dart';
import '../home/home_page.dart';
import 'create_account_page.dart';

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
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool keepSignIn = false;
  void _onRememberMeChanged(newValue) => setState(() {
        keepSignIn = newValue;

        if (keepSignIn) {
        } else {}
      });
  void onTapSignIn() {
    print("tapped on sign in");
  }

  void onTapCreateAccount() {
    print("tapped on  Create Account");
    // PageTransition(child: createAccountPage, type: PageTransitionType.fade);
    // Navigator.pushNamed(createAccountPage);
    Navigator.pushReplacementNamed(context, RouterName.createAccountPage);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
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
                                  color: Colors.black,
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
                      controller: userNameController,
                      // hintText: textUserNameLabel,
                      labelText: textUserNameLabel,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    InputField(
                      controller: passwordController,
                      // hintText: textPasswordLabel,
                      labelText: textPasswordLabel,
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
                                  _onRememberMeChanged(value);
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
              child: const Icon(Icons.navigation),
            ),
          ),
        ),
      ),
    );
  }
}
