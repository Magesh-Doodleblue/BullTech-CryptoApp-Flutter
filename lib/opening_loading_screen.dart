import 'dart:async';
import 'package:flutter/material.dart';

import 'screens/opening_splash_screen.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Splash()));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 237, 167),
        body: SizedBox(
          height: myHeight,
          width: myWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: myHeight * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'BULL CRYPTO',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Created by Magesh K',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          width: myWidth * 0.02,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: myHeight * 0.005,
                    ),
                    Image.asset(
                      'assets/circle-loading-spin.gif',
                      height: myHeight * 0.015,
                      color: Colors.black,
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
