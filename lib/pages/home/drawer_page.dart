import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apps/const/value.dart';
import '../../apps/routers/router_name.dart';
import '../../provider/data_provider.dart';
import '../../provider/firebase_provider.dart';
import 'list_title_item.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({super.key});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
          ),
          child: ListView(
            // Remove padding
            padding: EdgeInsets.zero,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<FirebaseProvider>(
                        builder: (context, value, child) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouterName.editProfile);
                          },
                          child: CircleAvatar(
                            radius: 50,
                            child: CachedNetworkImage(
                              imageUrl: value.userModel.imgURL,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                // width: 60.0,
                                // height: 60.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouterName.editProfile);
                        },
                        child: Text(
                          'Edit Profile',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: ListTitleItem(
                  title: textVoucherDiscount,
                  prefixIcon: Icons.discount,
                  onTap: () {},
                ),
              ),
              ListTile(
                title: ListTitleItem(
                  title: textCoffeyPoint,
                  prefixIcon: Icons.point_of_sale,
                  onTap: () {},
                ),
              ),
              ListTile(
                title: ListTitleItem(
                  title: textCoffeyRewards,
                  prefixIcon: Icons.reviews,
                  onTap: () {},
                ),
              ),
              ListTile(
                title: ListTitleItem(
                  title: textFavoriteCoffee,
                  prefixIcon: Icons.coffee,
                  onTap: () {},
                ),
              ),
              ListTile(
                title: ListTitleItem(
                  title: textSavedAddress,
                  prefixIcon: Icons.contacts,
                  onTap: () {},
                ),
              ),
              ListTile(
                title: ListTitleItem(
                  title: textPaymentMethods,
                  prefixIcon: Icons.payment,
                  onTap: () {},
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    const Icon(Icons.remove_red_eye),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        textDarkMode,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                    Consumer<DataProvider>(
                      builder: (context, data, child) => Switch(
                          // This bool value toggles the switch.
                          value: !data.isLightMode,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (bool value) {
                            data.setMode(!value);
                          }),
                    )
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                },
                title: const Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "close",
                          style: TextStyle(fontSize: 28, color: Colors.amber),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
