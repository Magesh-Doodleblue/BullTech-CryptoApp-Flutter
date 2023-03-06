import 'dart:async';
import 'package:flutter/material.dart';

import 'opening_splash_screen.dart';
import '../../widgets/opening_loading_widget.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 6),
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
        body: loadingWidget(myHeight, myWidth),
      ),
    );
  }

}
