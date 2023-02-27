// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../coin_details.dart';
import '../coin_page.dart';
import '../models/coin_model.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Coin> coinList = [];
  bool isLoading = false;
  DateTime? currentBackPressTime;

  // int _backButtonCounter = 0;

  // Future<bool> _onWillPop() async {
  //   _backButtonCounter++;
  //   if (_backButtonCounter == 2) {
  //     return true;
  //   }
  //   Fluttertoast.showToast(
  //     msg: 'Press back again to exit',
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 2,
  //     backgroundColor: Colors.grey[600],
  //     textColor: Colors.white,
  //   );
  //   await Future.delayed(const Duration(seconds: 2));
  //   _backButtonCounter--;
  //   return false;
  // }

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

  Future<List<Coin>> fetchCoin() async {
    final response = await http.get(
      Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false"),
    );
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        coinList = [];
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
      }
      setState(() {
        isLoading = false;
      });
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    super.initState();
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    await fetchCoin();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        // backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('BULL CURRENCY'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Text("Logout"),
              Material(
                child: GestureDetector(
                  child: const Icon(Icons.logout),
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isLoggedIn', false);
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LoginScreenPage()),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ]),
          ],
        ),
        drawer: const NavDrawer(),

        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Please wait..."),
                    ],
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: coinList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CoinDetailsPage(
                              name: coinList[index].name,
                              symbol: coinList[index].symbol,
                              imageUrl: coinList[index].imageUrl,
                              price: coinList[index].price.toDouble(),
                            ),
                          ),
                        );
                      },
                      child: CoinPage(
                        name: coinList[index].name,
                        symbol: coinList[index].symbol,
                        imageUrl: coinList[index].imageUrl,
                        price: coinList[index].price.toDouble(),
                        change: coinList[index].change.toDouble(),
                        changePercentage:
                            coinList[index].changePercentage.toDouble(),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Do something
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Do something
            },
          ),
        ],
      ),
    );
  }
}
