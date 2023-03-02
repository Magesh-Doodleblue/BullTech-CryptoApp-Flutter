// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:bulltech/screens/accounts_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../screens/chart_details.dart';
import '../models/coinModel.dart';
import '../models/coin_model.dart';
import 'chat_bot_new.dart';
import 'currency_converter.dart';
import 'investment_calculator.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Coin> coinList = [];
  bool isLoading = false;
  late ZoomDrawerController _drawerController;

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
    getCoinMarket();
    _drawerController = ZoomDrawerController();
    super.initState();
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    await fetchCoin();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: ZoomDrawer(
        controller: _drawerController,
        menuScreen: MenuScreen(controller: _drawerController),
        mainScreen: Scaffold(
          appBar: AppBar(
            title: const Text('BULL CURRENCY'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _drawerController.toggle!();
              },
            ),
          ),
          body: buildBody(),
        ),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        menuBackgroundColor: Colors.blue,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }

  RefreshIndicator buildBody() {
    return RefreshIndicator(
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
              itemCount: coinMarket!.length,
              itemBuilder: (context, index) {
                return Item2(
                  item: coinMarket![index],
                );
              },
            ),
    );
  }

  bool isRefreshing = true;

  List? coinMarket = [];
  var coinMarketList;
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
      coinMarketList = coinModelFromJson(x);
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
}

class MenuScreen extends StatelessWidget {
  final ZoomDrawerController controller;

  const MenuScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60.0, left: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Menu',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.double_arrow_outlined)
            ],
          ),
          const SizedBox(height: 6.0),
          const Divider(
            thickness: 3,
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ChatScreens()),
              );
            },
            child: const Text(
              'AI ChatBot',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const CurrencyConverterPage()),
              );
            },
            child: const Text(
              'Currency Converter',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const InvestmentCalculator()),
              );
            },
            child: const Text(
              'Investment Calculator',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AccountPage()),
              );
            },
            child: const Text(
              'Profile',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20.0),
          InkWell(
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
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  var item;
  Item2({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: myWidth * 0.01, vertical: myHeight * 0.02),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (contest) => SelectCoin(
                          selectItem: item,
                        )));
          },
          child: Container(
            padding: EdgeInsets.only(
              left: myWidth * 0.03,
              right: myWidth * 0.06,
              top: myHeight * 0.02,
              bottom: myHeight * 0.02,
            ),
            height: 116,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 66,
                      height: 66,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Image.network(
                          item.image,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.08,
                      width: myWidth * 0.03,
                    ),
                    Column(
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.symbol,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: myHeight * 0.01,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '\$${item.currentPrice}'.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              item.priceChange24H.toString().contains('-')
                                  ? "-\$${item.priceChange24H.toStringAsFixed(3).toString().replaceAll('-', '')}"
                                  : "\$" +
                                      item.priceChange24H.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              width: myWidth * 0.03,
                            ),
                            Text(
                              item.marketCapChangePercentage24H
                                      .toStringAsFixed(2) +
                                  '%',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  color: item.marketCapChangePercentage24H >= 0
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
