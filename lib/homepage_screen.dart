// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'coin_details.dart';
import 'coin_page.dart';
import 'models/coin_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Coin> coinList = [];
  bool isLoading = false;
  DateTime? currentBackPressTime;

  Future<List<Coin>> fetchCoin() async {
    final response = await http.get(
      Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false"),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: WillPopScope(
        onWillPop: () async {
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            // Show a toast to inform the user to press again to exit
            currentBackPressTime = DateTime.now();
            Fluttertoast.showToast(
              msg: "Press back again to exit",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            return false;
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            backgroundColor: Colors.grey[300],
            title: Text(
              ' BULL TECH',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
      ),
    );
  }
}
