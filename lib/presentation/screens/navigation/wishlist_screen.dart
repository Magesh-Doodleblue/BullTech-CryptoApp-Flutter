// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/coinModel.dart';
import '../../../data/models/wishlist_singleton.dart';
import 'package:http/http.dart' as http;

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late List<String> _coins;
  bool isRefreshing = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<CoinModel>? coinMarket = [];
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isRefreshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      var coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getCoinMarket();
    _coins =
        Wishlist.instance.getCoins(); // get the list of coins from the Wishlist
  }

  Future<bool> _onWillPop() async {
    bool closeApp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the App?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    if (closeApp == true) {
      SystemNavigator.pop();
    }

    return closeApp;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wishlist',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 66, 66),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        // body: GridView.builder(
        //   itemCount: _coins.length,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 10,
        //     mainAxisSpacing: 10,
        //   ),
        //   itemBuilder: (BuildContext context, int index) {
        //     final coin = _coins[index];
        //     return Padding(
        //       padding: const EdgeInsets.all(18.0),
        //       child: Card(
        //         child: Center(
        //           child: Column(
        //             children: [
        //
        //               Text(
        //                 coin,
        //                 style: Theme.of(context).textTheme.headlineSmall,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('wishlist').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data!.docs;

            if (documents.isEmpty) {
              return Center(
                child: SizedBox(
                  height: 500,
                  child: Column(
                    children: [
                      Image.asset("assets/empty.gif"),
                      const Text(
                        "You forgot to add something",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic>? data = documents[index].data();
                if (data == null) {
                  return const SizedBox();
                }
                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['currentPrice'].toString()),
                  leading: Image.network(data['image']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      String documentID = documents[index].id;
                      FirebaseFirestore.instance
                          .collection('wishlist')
                          .doc(documentID)
                          .delete();
                    },
                  ),
                );
              },
            );
          },
        ),

        // body: WishlistWidget(coins: _coins),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Wishlist.instance.clearCoins();
            setState(() {
              _coins = Wishlist.instance.getCoins();
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                elevation: 20,
                content: Text('Wishlist cleared'),
              ),
            );
          },
          tooltip: 'Clear wishlist',
          child: const Icon(Icons.clear),
        ),
      ),
    );
  }
}

//sample response from above api
//{
// "id": "bitcoin",
// "symbol": "btc",
// "name": "Bitcoin",
// "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
// "current_price": 28035,
// "market_cap": 542314917536,
// "market_cap_rank": 1,
// "fully_diluted_valuation": 588907513262,
// "total_volume": 14596182230,
// "high_24h": 28609,
// "low_24h": 27884,
// "price_change_24h": -496.0509388735263,
// "price_change_percentage_24h": -1.73863,
// "market_cap_change_24h": -9197165014.045532,
// "market_cap_change_percentage_24h": -1.66763,
// "circulating_supply": 19338543.0,
// "total_supply": 21000000.0,
// "max_supply": 21000000.0,
// "ath": 69045,
// "ath_change_percentage": -59.35383,
// "ath_date": "2021-11-10T14:24:11.849Z",
// "atl": 67.81,
// "atl_change_percentage": 41286.91317,
// "atl_date": "2013-07-06T00:00:00.000Z",
// "roi": null,
// "last_updated": "2023-04-06T07:37:26.894Z",
//}
