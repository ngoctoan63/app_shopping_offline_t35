import 'package:carousel_slider/carousel_slider.dart';
import 'package:denshihanbai/pages/home/bottom_navigate.dart';
import 'package:denshihanbai/pages/home/categories.dart';
import 'package:denshihanbai/provider/auth_provider.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apps/const/value.dart';
import '../../provider/data_provider.dart';
import '../products.dart';
import 'drawer_page.dart';
import 'popular_deals.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColorLight,
      drawer: SizedBox(
        width: screenWidth,
        child: const Drawer(
          child: LeftDrawer(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).primaryColorLight,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                  height: 100,
                  color: Theme.of(context).primaryColorLight,
                  child: Consumer<AuthProvider>(
                      builder: (context, value, child) => Row(
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
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                  ),
                                  Text(
                                    value.displayName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .primaryColorDark),
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
                                        context
                                            .read<AuthProvider>()
                                            .signOut(context);
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
                          )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ProductPage(
                              categoryID: '0',
                              title: textAllCategories,
                            )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                            color: const Color(0xffE8EFF3), width: 1),
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
                              textSearchBeveragesOrFoods,
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
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                                "https://cdn.pixabay.com/photo/2023/03/28/07/51/trees-7882545_1280.jpg"),
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
                                "https://media.istockphoto.com/id/1176579445/vi/anh/m%E1%BA%B7t-tr%E1%BB%9Di-chi%E1%BA%BFu-qua-m%E1%BB%99t-c%C3%A1i-c%C3%A2y-trong-c%E1%BA%A3nh-quan-n%C3%B4ng-th%C3%B4n.jpg?s=2048x2048&w=is&k=20&c=9IXT11XeEmIPXu_mAhXlS1gbLzctGkL60IUUjNvlnj0="),
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
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                  const Categories(),
                  const PopularDeal(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigate(),
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
