import 'package:flutter/material.dart';
import '../account/accounts_screen.dart';
import '../newspaper/newspaper_screen.dart';

import 'homepage_screen.dart';
import 'wishlist_screen.dart';

class NavigationButton extends StatefulWidget {
  const NavigationButton({super.key});

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  int pageIndex = 0;
  List<Widget> bodybar = [
    const HomePage(),
    const WishListScreen(),
    const NewsScreen(),
    const AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: bodybar[pageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            pageIndex = newIndex;
            // debugPrint(pageIndex as String?);
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 255, 119, 119),
            ),
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.list_alt,
              // Image.asset("assets/wishlist.png"),
              color: Color.fromARGB(255, 255, 119, 119),
            ),
            icon: Icon(
              Icons.list_alt,
              color: Colors.black,
            ),
            label: 'Wish',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.newspaper,
              color: Color.fromARGB(255, 255, 119, 119),
            ),
            icon: Icon(
              Icons.newspaper,
              color: Colors.black,
            ),
            label: 'News',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: Color.fromARGB(255, 255, 119, 119),
            ),
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'You',
          ),
        ],
      ),
    );
  }
}
