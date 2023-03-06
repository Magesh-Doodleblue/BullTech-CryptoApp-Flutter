
  import 'package:flutter/material.dart';

SizedBox loadingWidget(double myHeight, double myWidth) {
    return SizedBox(
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
      );
  }