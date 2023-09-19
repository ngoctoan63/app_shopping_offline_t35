import 'package:flutter/material.dart';
import 'package:denshihanbai/apps/const/value.dart';
import 'package:denshihanbai/apps/routers/router_name.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Page Error'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, RouterName.rootPage);
            },
            child: const Text(textButtonError),
          )
        ],
      )),
    );
  }
}
