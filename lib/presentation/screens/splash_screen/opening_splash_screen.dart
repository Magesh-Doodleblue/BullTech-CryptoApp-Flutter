// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../screens/authentication/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return const Scaffold(
        // body: splashWidgetScreen(myHeight: myHeight, myWidth: myWidth),
        );
  }
}

class splashWidgetScreen extends StatelessWidget {
  const splashWidgetScreen({
    Key? key,
    required this.myHeight,
    required this.myWidth,
  }) : super(key: key);

  final double myHeight;
  final double myWidth;
  // double currectPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: myHeight,
      width: myWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //
          //
          Lottie.asset(
            'assets/growth.json',
            repeat: true,
            width: MediaQuery.of(context).size.width * 0.94,
            height: MediaQuery.of(context).size.height * 0.4,
            reverse: true,
            animate: true,
          ),
          //
          //
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'The Future',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 39, right: 23),
                child: Text(
                  'Learn more about cryptocurrency, look to the future in BULL CURRENCY',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[500]),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: myWidth * 0.14),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreenPage()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 66, 66),
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.05, vertical: myHeight * 0.013),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Explore Crypto',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(310 / 360),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
