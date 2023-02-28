// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CurrencyConverter {
  final String apiKey =
      'bUGqzktr0Dlx6jM8EP8MOCAyrp5aOy2q'; // Replace with your API key

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
      _toController.text = _convertedAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class CurrencyConverter extends StatefulWidget {
//   const CurrencyConverter({super.key});

//   @override
//   State<CurrencyConverter> createState() => _CurrencyConverterState();
// }

// class _CurrencyConverterState extends State<CurrencyConverter> {
//   Map<String, dynamic> _exchangeRates = {};
//   double _amount = 0;
//   String _fromCurrency = 'USD';
//   String _toCurrency = 'EUR';

//   @override
//   void initState() {
//     super.initState();

//     getExchangeRates().then((exchangeRates) {
//       setState(() {
//         _exchangeRates = exchangeRates;
//       });
//     });
//   }

//   Future<Map<String, dynamic>> getExchangeRates() async {
//     final url = 'https://api.exchangeratesapi.io/latest';

//     final response = await http.get(Uri.parse(url));
// //api key bUGqzktr0Dlx6jM8EP8MOCAyrp5aOy2q   for above api
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body)['rates'];
//     } else {
//       throw Exception('Failed to load exchange rates');
//     }
//   }

//   double convertCurrency(
//       double amount, String fromCurrency, String toCurrency) {
//     final fromRate = _exchangeRates[fromCurrency];
//     final toRate = _exchangeRates[toCurrency];

//     if (fromRate != null && toRate != null) {
//       return amount * (toRate / fromRate);
//     } else {
//       throw Exception('Invalid currency code');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Currency Converter'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     _amount = double.tryParse(value) ?? 0;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButton<String>(
//                       value: _fromCurrency,
//                       onChanged: (value) {
//                         setState(() {
//                           _fromCurrency = value!;
//                         });
//                       },
//                       items: _exchangeRates.keys
//                           .map<DropdownMenuItem<String>>(
//                               (currencyCode) => DropdownMenuItem<String>(
//                                     value: currencyCode,
//                                     child: Text(currencyCode),
//                                   ))
//                           .toList(),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: DropdownButton<String>(
//                       value: _toCurrency,
//                       onChanged: (value) {
//                         setState(() {
//                           _toCurrency = value!;
//                         });
//                       },
//                       items: _exchangeRates.keys
//                           .map<DropdownMenuItem<String>>(
//                               (currencyCode) => DropdownMenuItem<String>(
//                                     value: currencyCode,
//                                     child: Text(currencyCode),
//                                   ))
//                           .toList(),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               _exchangeRates.isNotEmpty &&
//                       _exchangeRates.containsKey(_fromCurrency) &&
//                       _exchangeRates.containsKey(_toCurrency)
//                   ? Text(
//                       '${convertCurrency(_amount, _fromCurrency, _toCurrency).toStringAsFixed(2)} $_toCurrency',
//                       style: const TextStyle(fontSize: 24),
//                     )
//                   : const SizedBox(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
