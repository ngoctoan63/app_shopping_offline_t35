import 'package:flutter/material.dart';

import '../../apps/routers/router_name.dart';

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
      // Scaffold.of(context).openDrawer();
      Navigator.pushNamed(context, RouterName.userPage);
      selectedIndex = 0;
    } else if (index == 3) {
      // context.read<FirebaseProvider>().addUser('Toan', 'GPN', '40');
    } else if (index == 2) {
      // Navigator.of(context)
      // .push(MaterialPageRoute(builder: (_) => const UserInformation()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.repeat_on_rounded),
          label: 'Change',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopify),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Favorite',
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
