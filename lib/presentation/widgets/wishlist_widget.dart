// // ignore_for_file: camel_case_types

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../data/models/coinModel.dart';
// import '../screens/navigation/wish_to_chart.dart';

// class wishlistWidget extends StatefulWidget {
//   const wishlistWidget({
//     super.key,
//     required List<String> coins,
//   }) : _coins = coins;

//   final List<String> _coins;

//   @override
//   State<wishlistWidget> createState() => _wishlistWidgetState();
// }

// class _wishlistWidgetState extends State<wishlistWidget> {
//   bool isRefreshing = true;

//   List? coinMarket = [];
//   var coinMarketList;
//   Future<List<CoinModel>?> getCoinMarket() async {
//     const url =
//         'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

//     setState(() {
//       isRefreshing = true;
//     });
//     var response = await http.get(Uri.parse(url), headers: {
//       "Content-Type": "application/json",
//       "Accept": "application/json",
//     });
//     setState(() {
//       isRefreshing = false;
//     });
//     if (response.statusCode == 200) {
//       var x = response.body;
//       coinMarketList = coinModelFromJson(x);
//       setState(() {
//         coinMarket = coinMarketList;
//       });
//     } else {
//       if (kDebugMode) {
//         print(response.statusCode);
//       }
//     }
//     return null;
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCoinMarket();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       itemCount: widget._coins.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemBuilder: (BuildContext context, int index) {
//         final coin = widget._coins[index];
//         return Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: GestureDetector(
//             onTap: passingWidgets(
//               context,
//               coinMarket![index],
//             ),
//             child: Card(
//               child: Center(
//                 child: Text(
//                   coin,
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   passingWidgets(BuildContext context, String coin) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => WishSelectCoin(
//           wishedItemDetails: coin,
//         ),
//       ),
//     );
//   }
// }

