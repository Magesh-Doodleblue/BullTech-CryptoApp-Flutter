import 'package:flutter/material.dart';
import 'accounts_screen.dart';
import 'newspaper_screen.dart';
import 'wishlist_screen.dart';
import 'homepage_screen.dart';

class NavigationButton extends StatefulWidget {
  const NavigationButton({super.key});

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
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
              color: Colors.white,
            ),
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.abc_outlined,
              // Image.asset("assets/wishlist.png"),
              color: Colors.white,
            ),
            icon: Icon(
              Icons.data_exploration,
              color: Colors.grey,
            ),
            label: 'Wish',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.newspaper,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.newspaper,
              color: Colors.grey,
            ),
            label: 'News',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            label: 'You',
          ),
        ],
      ),
    );
  }
}
