// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoPrice {
  final DateTime date;
  final double price;

  CryptoPrice(this.date, this.price);
}

class CryptoChart extends StatefulWidget {
  final String coinName;

  CryptoChart({required this.coinName});

  @override
  _CryptoChartState createState() => _CryptoChartState();
}

class _CryptoChartState extends State<CryptoChart> {
  List<CryptoPrice> _data = [];
  Future<void> _fetchData() async {
    // Make API call to get the price data
    final response = await http.get(
      Uri.parse(
          'https://api.coingecko.com/api/v3/coins/${widget.coinName}/market_chart?vs_currency=usd&days=30'),
    );

    // Parse the response and add the price data to the list
    final jsonData = jsonDecode(response.body);
    final prices = jsonData['prices'];
    _data = List<CryptoPrice>.from(prices.map((price) {
      final date = DateTime.fromMillisecondsSinceEpoch(price[0]);
      final priceValue = price[1];
      return CryptoPrice(date, priceValue);
    }));

    // Update the state to re-build the chart
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: _data.isNotEmpty
            ? _buildChart()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _buildChart() {
    List<charts.Series<CryptoPrice, DateTime>> seriesList = [
      charts.Series<CryptoPrice, DateTime>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (CryptoPrice price, _) => price.date,
        measureFn: (CryptoPrice price, _) => price.price,
        data: _data,
      )
    ];

    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

class CandleData {
  final DateTime x;
  final double low;
  final double high;
  final double open;
  final double close;

  CandleData({
    required this.high,
    required this.open,
    required this.close,
    required this.x,
    required this.low,
  });
}
