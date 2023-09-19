import 'package:flutter/material.dart';

import '../../apps/const/value.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                textGroceryApp,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ));
  }
}
