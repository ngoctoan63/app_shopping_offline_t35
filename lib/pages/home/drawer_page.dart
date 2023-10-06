import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apps/const/value.dart';
import '../../provider/data_provider.dart';
import '../../provider/info_provider.dart';
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
              Consumer<InfoProvider>(
                builder: (context, value, child) => Container(
                  width: double.infinity,
                  height: 130,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            context.read<InfoProvider>().getImage();
                          },
                          child: value.profilePic != ''
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      // image: AssetImage(value.profilePic),
                                      image: NetworkImage(value.profilePic),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  // child: Image.network(
                                  //   value.profilePic, // this image doesn't exist
                                  //   fit: BoxFit.cover,
                                  //   errorBuilder: (context, error, stackTrace) {
                                  //     return Image(
                                  //         image: AssetImage(value.profilePic));
                                  //   },
                                  // ),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/default_avatar.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
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
