import 'package:denshihanbai/provider/auth_provider.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apps/const/value.dart';
import '../../provider/data_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int currentHour = DateTime.now().hour;
    String greet;
    switch (currentHour) {
      case < 12:
        greet = textMainGoodMorning;
        break;
      case > 18:
        greet = textMainGoodEvening;
        break;
      default:
        greet = textMainGoodAfternoon;
    }
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<AuthProvider>(
              builder: (context, value, child) => Container(
                    padding:
                        EdgeInsets.only(left: 25, right: 25, top: height * .01),
                    height: 100,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              greet,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                            Text(
                              value.email,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: -50,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEDEDED),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(60.0),
                                ),
                              ),
                              width: 90,
                              height: 45,
                              child: Text(
                                context
                                    .read<DataProvider>()
                                    .notifyCount
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100.0),
                                ),
                              ),
                              child: const Icon(
                                Icons.circle_notifications,
                                color: Color(0xFFC29C1D),
                                size: 56,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
        ],
      ),
      floatingActionButton: DraggableFab(
        child: Consumer<DataProvider>(
          builder: (context, dataProvider, child) => FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            onPressed: () => {dataProvider.setMode(!dataProvider.isLightMode)},
            child: const Icon(
              Icons.change_circle,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
