import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance
          .collection('user_profiles')
          .doc('uid')
          .snapshots();

  @override
  Widget build(BuildContext context) {
    print('---------build user_info screen');
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _usersStream,
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        String fullName = '';
        if (snapshot.data != null) {
          fullName = snapshot.data!['full_name'];
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return SafeArea(
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: 200,
              color: Colors.amber,
              child: Text(
                fullName,
                style: const TextStyle(color: Colors.green, fontSize: 30),
              ),
            ),
          ),
        );
      },
    );
  }
}
