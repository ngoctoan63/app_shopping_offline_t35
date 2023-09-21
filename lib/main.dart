import 'package:flutter/material.dart';
import 'package:denshihanbai/apps/my_app.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
// import 'dart:async';

// import 'package:after_layout/after_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       color: Colors.blue,
//       home: Splash(),
//     );
//   }
// }

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   SplashState createState() => SplashState();
// }

// class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
//   Future checkFirstSeen() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool seen = (prefs.getBool('seen') ?? false);

//     if (seen) {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const Home()));
//     } else {
//       await prefs.setBool('seen', true);
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const IntroScreen()));
//     }
//   }

//   @override
//   void afterFirstLayout(BuildContext context) => checkFirstSeen();

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Loading...'),
//       ),
//     );
//   }
// }

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hello'),
//       ),
//       body: const Center(
//         child: Text('This is the second page'),
//       ),
//     );
//   }
// }

// class IntroScreen extends StatelessWidget {
//   const IntroScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('IntroScreen'),
//       ),
//       body: const Center(
//         child: Text('This is the IntroScreen'),
//       ),
//     );
//   }
// }
