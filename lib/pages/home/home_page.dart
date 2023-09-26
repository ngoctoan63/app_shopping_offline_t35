import 'package:carousel_slider/carousel_slider.dart';
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
    Color? color;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<AuthProvider>(
              builder: (context, value, child) => Container(
                    padding:
                        EdgeInsets.only(left: 25, right: 25, top: height * .04),
                    height: 100,
                    // width: double.infinity,
                    color: Theme.of(context).primaryColorLight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              greet,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: 16,
                                      color:
                                          Theme.of(context).primaryColorDark),
                            ),
                            Text(
                              value.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 16,
                                      color:
                                          Theme.of(context).primaryColorDark),
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
                              child: InkWell(
                                onTap: () {
                                  context.read<AuthProvider>().signOut(context);
                                },
                                child: const Icon(
                                  Icons.circle_notifications,
                                  color: Color(0xFFC29C1D),
                                  size: 56,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
          InkWell(
            // onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: const Color(0xffE8EFF3), width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Color(0xff7D8FAB),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Search beverages or foods",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          letterSpacing: 0.0,
                          color: Color(0xff7D8FAB),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 220,
            color: Theme.of(context).primaryColorLight,
            child: ListView(children: [
              CarouselSlider(
                items: [
                  Container(
                    margin: const EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/1322277517/vi/anh/c%E1%BB%8F-d%E1%BA%A1i-tr%C3%AAn-n%C3%BAi-l%C3%BAc-ho%C3%A0ng-h%C3%B4n.jpg?s=612x612&w=0&k=20&c=ng_7l3FyBObY5ZJq2BgWCkOKct9Qk6ITFnCC2r55IKQ="),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/1322277517/vi/anh/c%E1%BB%8F-d%E1%BA%A1i-tr%C3%AAn-n%C3%BAi-l%C3%BAc-ho%C3%A0ng-h%C3%B4n.jpg?s=612x612&w=0&k=20&c=ng_7l3FyBObY5ZJq2BgWCkOKct9Qk6ITFnCC2r55IKQ="),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/1322277517/vi/anh/c%E1%BB%8F-d%E1%BA%A1i-tr%C3%AAn-n%C3%BAi-l%C3%BAc-ho%C3%A0ng-h%C3%B4n.jpg?s=612x612&w=0&k=20&c=ng_7l3FyBObY5ZJq2BgWCkOKct9Qk6ITFnCC2r55IKQ="),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 168.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
            ]),
          ),
          Container(
            height: 140,
            width: double.infinity,
            color: Theme.of(context).primaryColorLight,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          textCategories,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xff7D8FAB),
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Consumer<DataProvider>(
                  //     builder: (_, data, __) => Expanded(
                  //       child: ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount: data.categoriesList.length,
                  //           itemBuilder: (context, index) {
                  //             return SizedBox(
                  //               height: width / 4 + 4,
                  //               width: width / 4,
                  //               child: Card(
                  //                 color: Colors.amber,
                  //                 child: Text(
                  //                   data.categoriesList[index],
                  //                   style: const TextStyle(color: Colors.white),
                  //                 ),
                  //               ),
                  //             );
                  //           }),
                  //     ),
                  //   ),
                  // )
                ]),
          ),
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
