import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'chart_details.dart';
import 'models/chart_in_scndpage.dart';
import 'models/wishlist_singleton.dart';

class CoinDetailsPage extends StatelessWidget {
  final String name;
  final String symbol;
  final String imageUrl;
  final double price;

  const CoinDetailsPage({
    Key? key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TextEditingController days = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              imageUrl,
              width: 36,
              height: 36,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    price.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 500,
                    child: SelectCoin(),
                    // CryptoChart(
                    //     coinName: symbol)), //chart section in another page
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Wishlist.instance.addCoin(name);
                          Fluttertoast.showToast(
                            msg: '$name added to wishlist',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text(
                          'Add to Wishlist',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final coins = Wishlist.instance.getCoins();
                          Fluttertoast.showToast(
                            msg: 'Coins in the wishlist: ${coins.join(', ')}',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text(
                          'Show Wishlist',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
