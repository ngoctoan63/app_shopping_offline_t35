import 'package:denshihanbai/provider/auth_provider.dart';
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

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //controller
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool AcceptTerms = false;
  void onAcceptTermsChanged(newValue) => setState(() {
        setState(() {
          AcceptTerms = newValue;
        });
      });
  void onTapRegister() {
    try {
      context
          .read<AuthProvider>()
          .createUser(context, emailController.text, passwordController.text);
    } on Exception catch (ex) {
      print('-----------EX:$ex.toString()');
    }
  }

  void onTapSignIn() {
    Navigator.pushReplacementNamed(context, RouterName.signInPage);
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
                      controller: userNameController,
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
                      absorbing: !AcceptTerms,
                      child: ButtonWidget(
                        title: textSignInSignUp,
                        onTap: onTapRegister,
                        enable: AcceptTerms,
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
                                value: AcceptTerms,
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
