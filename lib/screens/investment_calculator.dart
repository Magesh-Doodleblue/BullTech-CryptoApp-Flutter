// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:math';

class InvestmentCalculator extends StatefulWidget {
  const InvestmentCalculator({super.key});

  @override
  _InvestmentCalculatorState createState() => _InvestmentCalculatorState();
}

class _InvestmentCalculatorState extends State<InvestmentCalculator> {
  double _principal = 1000;
  double _rate = 5;
  int _years = 1;

  double calculateTotal(double principal, double rate, int years) {
    double total = principal * pow(1 + rate / 100, years);
    return double.parse(total.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Principal Amount: \$${_principal.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 20),
          ),
          Slider(
            value: _principal,
            min: 1000,
            max: 100000,
            divisions: 50,
            label: _principal.round().toString(),
            onChanged: (double value) {
              setState(() {
                _principal = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Interest Rate: ${_rate.toStringAsFixed(1)}%',
            style: const TextStyle(fontSize: 20),
          ),
          Slider(
            value: _rate,
            min: 1,
            max: 10,
            divisions: 90,
            label: _rate.round().toString(),
            onChanged: (double value) {
              setState(() {
                _rate = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Number of Years: $_years',
            style: const TextStyle(fontSize: 20),
          ),
          Slider(
            value: _years.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            label: _years.toString(),
            onChanged: (double value) {
              setState(() {
                _years = value.toInt();
              });
            },
          ),
          const SizedBox(height: 40),
          Text(
            'Total Amount: \$${calculateTotal(_principal, _rate, _years).toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
