// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/push/constants.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import '../models/wishlist_singleton.dart';

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
        automaticallyImplyLeading: false, // remove back button

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
//
// void initSubscription() async {
//   //The method which “sends” the token to the Quickblox server is initSubscription.
//   FirebaseMessaging.instance.getToken().then((token) {
//     QB.subscriptions.create(token!, QBPushChannelNames.GCM);
//   });
//
//   try {
//     FirebaseMessaging.onMessage.listen((message) {
//       showNotification(message);
//     });
//   } on PlatformException catch (e) {
//     //some error occurred
//   }
// }
//
// void showNotification(RemoteMessage message) {
//   AndroidNotificationChannel channel = const AndroidNotificationChannel(
//       'channel_id', 'some_title', 'some_description',
//       importance: Importance.high);
//
//   AndroidNotificationDetails details = AndroidNotificationDetails(
//       channel.id, channel.name, channel.description,
//       icon: 'launch_background');
//
//   FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
//   int id = message.hashCode;
//   String title = "some message title";
//   String body = message.data["message"];
//
//   plugin.show(id, title, body, NotificationDetails(android: details));
// }
