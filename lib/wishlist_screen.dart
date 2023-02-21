// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'models/wishlist_singleton.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late List<String> _coins;

  @override
  void initState() {
    super.initState();
    _coins =
        Wishlist.instance.getCoins(); // get the list of coins from the Wishlist
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: GridView.builder(
        itemCount: _coins.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          final coin = _coins[index];
          return Card(
            child: Center(
              child: Text(
                coin,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Wishlist.instance.clearCoins();
          setState(() {
            _coins = Wishlist.instance.getCoins();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wishlist cleared'),
            ),
          );
        },
        tooltip: 'Clear wishlist',
        child: const Icon(Icons.clear),
      ),
    );
  }
}
