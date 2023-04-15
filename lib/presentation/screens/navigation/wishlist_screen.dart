// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, unnecessary_null_comparison, use_build_context_synchronously

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
            child: const Text(
              'No',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 66, 66),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 66, 66),
              ),
            ),
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
          stream: firestore.collection('wishlist').orderBy("time").snapshots(),
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

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Dismissible(
                    key: Key(documents[index].id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm'),
                            content: const Text(
                                'Are you sure you wish to delete this item?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text(
                                  'CANCEL',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 66, 66),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text(
                                  'DELETE',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 66, 66),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) async {
                      String documentID = documents[index].id;
                      await firestore
                          .collection('wishlist')
                          .doc(documentID)
                          .delete();
                    },
                    background: Container(
                      color: const Color.fromARGB(255, 255, 66, 66),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Release to delete",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.delete_outline_sharp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        data['name'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        'Current Price: \$${data['currentPrice'].toString()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: Image.network(
                        data['image'],
                        height: 90,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline_sharp),
                        onPressed: () {
                          String documentID = documents[index].id;
                          FirebaseFirestore.instance
                              .collection('wishlist')
                              .doc(documentID)
                              .delete();
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 255, 66, 66),
          onPressed: () async {
            // Show an alert dialog to confirm the user's action
            bool confirm = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // title: const Text('Clear Wishlist'),
                  title: const Text('Clear Wishlist',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      )),
                  content: const Text(
                      'Are you sure you want to clear your Wishlist?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 66, 66),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'CLEAR',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 66, 66),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );

            if (confirm == true) {
              QuerySnapshot<Map<String, dynamic>> snapshot =
                  await firestore.collection('wishlist').get();
              List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                  snapshot.docs;
              for (var document in documents) {
                document.reference.delete();
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Wishlist cleared'),
                ),
              );
            }
          },
          tooltip: 'Clear wishlist',
          child: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
