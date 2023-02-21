// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceHistoryChart extends StatefulWidget {
  final String coinName;

  const PriceHistoryChart({Key? key, required this.coinName}) : super(key: key);

  @override
  _PriceHistoryChartState createState() => _PriceHistoryChartState();
}

class _PriceHistoryChartState extends State<PriceHistoryChart> {
  Future<List<CandleData>>? _future;

  @override
  void initState() {
    super.initState();
    _future = fetchCoinPriceHistory(widget.coinName);
  }

  Future<List<CandleData>> fetchCoinPriceHistory(String coinName) async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/$coinName/market_chart?vs_currency=usd&days=30'));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> prices = data['prices'];
      final candleData = prices
          .map((price) => CandleData(
              x: DateTime.fromMillisecondsSinceEpoch(price[0].toInt()),
              low: price[1].toDouble(),
              high: price[1].toDouble(),
              open: price[1].toDouble(),
              close: price[1].toDouble()))
          .toList();
      return candleData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 500,
              child: Center(
                child: FutureBuilder<List<CandleData>>(
                  future: _future,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CandleData>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final candleData = snapshot.data!;
                      return SfCartesianChart(
                        primaryXAxis: DateTimeAxis(),
                        series: <CandleSeries>[
                          CandleSeries<CandleData, DateTime>(
                            dataSource: candleData,
                            xValueMapper: (CandleData data, _) => data.x,
                            lowValueMapper: (CandleData data, _) => data.low,
                            highValueMapper: (CandleData data, _) => data.high,
                            openValueMapper: (CandleData data, _) => data.open,
                            closeValueMapper: (CandleData data, _) =>
                                data.close,
                          ),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator(
                        color: Colors.black,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
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
