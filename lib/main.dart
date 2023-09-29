import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:denshihanbai/apps/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
// import 'package:fluttertoast_example/toast_context.dart';
// import 'package:fluttertoast_example/toast_no_context.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/material.dart';

// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// void main() => runApp(
//       MaterialApp(
//         builder: FToastBuilder(),
//         home: const MyApp(),
//         navigatorKey: navigatorKey,
//       ),
//     );

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Toast"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => ToastNoContext(),
//               ));
//             },
//             child: const Text("Flutter Toast No Context"),
//           ),
//           const SizedBox(
//             height: 24.0,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => ToastContext(),
//               ));
//             },
//             child: const Text("Flutter Toast Context"),
//           ),
//         ],
//       ),
//     );
//   }
// }
