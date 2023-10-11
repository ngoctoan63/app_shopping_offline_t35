import 'package:flutter/material.dart';

import '../../apps/const/value.dart';

class BottomNavigate extends StatefulWidget {
  const BottomNavigate({
    super.key,
  });

  @override
  State<BottomNavigate> createState() => _BottomNavigateState();
}

class _BottomNavigateState extends State<BottomNavigate> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 4) {
      Scaffold.of(context).openDrawer();
      selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.repeat_on_rounded),
          label: 'Change',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.shopify),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 20,
            // backgroundImage: imgURL == ''
            backgroundImage: '' == ''
                ? const NetworkImage(textDefaultAva)
                : FadeInImage.assetNetwork(
                    placeholder: 'assets/Spinner-5.gif',
                    // image: imgURL,
                    image: '',
                    fit: BoxFit.cover,
                  ).image,
          ),
          label: 'Profile',
        ),
      ],
      iconSize: 30,
      currentIndex: selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (value) {
        _onItemTapped(value);
      },
    );
  }
}
