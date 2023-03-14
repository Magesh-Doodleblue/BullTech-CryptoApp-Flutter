// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class wishlistWidget extends StatelessWidget {
  const wishlistWidget({
    super.key,
    required List<String> coins,
  }) : _coins = coins;

  final List<String> _coins;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }
}
