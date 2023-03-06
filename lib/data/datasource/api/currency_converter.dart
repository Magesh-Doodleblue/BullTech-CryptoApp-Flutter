
import 'dart:convert';
import 'package:http/http.dart' as http;


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
