// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CurrencyConverter {
  final String apiKey = 'bUGqzktr0Dlx6jM8EP8MOCAyrp5aOy2q';

  Future<double> convert(String from, String to, double amount) async {
    final response = await http.get(
      Uri.parse(
          'https://api.apilayer.com/exchangerates_data/convert?from=$from&to=$to&amount=$amount'),
      headers: {'apikey': apiKey},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final conversionRate = jsonResponse['result'];
      return conversionRate;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

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
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _fromController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText:
                    'Enter amount in USD', // Replace with desired currency
              ),
            ),
            const SizedBox(
              height: 50,
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
            // ElevatedButton(
            //   onPressed: _convertCurrency,
            //   child: const Text('Convert'),
            // ),
            OutlinedButton(
              onPressed: _convertCurrency,
              child: const Text("CONVERT"),
            ),
          ],
        ),
      ),
    );
  }
}
