import 'package:flutter/material.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:provider/provider.dart';
import '../../apps/const/value.dart';
import '../../provider/data_provider.dart';
import '../../widgets/input_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //controller
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
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
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(20.0),
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
                        textTitleLogin,
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
                        textMessageLogin,
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
                      hintText: textUserNameLabel,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    InputField(
                      controller: passwordController,
                      hintText: textPasswordLabel,
                      prefixIcon: const Icon(Icons.lock),
                      isSecure: true,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 12,
                              offset: const Offset(0, 10),
                            )
                          ]),
                      child: const Center(
                        child: Text(
                          textLoginButton,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {}, // needed
                      child: Ink(
                        // use Ink
                        width: 200,
                        height: 200,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButton: DraggableFab(
          child: Consumer<DataProvider>(
            builder: (context, dataProvider, child) => FloatingActionButton(
              backgroundColor: Colors.green,
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
