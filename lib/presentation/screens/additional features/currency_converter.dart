// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../data/datasource/api/currency_converter.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  double _convertedAmount = 0.0;
  final CurrencyConverter _converter = CurrencyConverter();

  void _convertCurrency() async {
    double amount = double.parse(_fromController.text);
    double convertedAmount = await _converter.convert(
        'USD', 'INR', amount); // Replace with desired currencies
    setState(() {
      _convertedAmount = convertedAmount;
      _toController.text = _convertedAmount.toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: currencyConverterWidget(),
    );
  }

  Padding currencyConverterWidget() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "USD / Dollars",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _fromController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter amount in USD', // Replace with desired currency
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "INR / Rupees",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _toController,
            enabled: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Converted amount in INR',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                _convertCurrency();
                const CircularProgressIndicator();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 66, 66),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "CONVERT",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
