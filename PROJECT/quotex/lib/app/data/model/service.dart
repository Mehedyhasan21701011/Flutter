import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quotex/app/data/model/candlemodel.dart';

class TradingApiService {
  static const String baseUrl =
      'https://api.example.com'; // Replace with your API

  Future<List<CandleModel>> fetchCandles({
    required String symbol,
    required String interval,
    int limit = 100,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/klines?symbol=$symbol&interval=$interval&limit=$limit',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Process candles with proper linking
        List<CandleModel> candles = [];
        CandleModel? previousCandle;

        for (int i = 0; i < data.length; i++) {
          final candleData = data[i];
          CandleModel candle;

          if (i == 0) {
            // First candle - no previous candle
            candle = CandleModel.fromJson(candleData);
          } else {
            // Subsequent candles - ensure open = previous close
            candle = CandleModel.createFromPrevious(
              time: DateTime.fromMillisecondsSinceEpoch(
                candleData['timestamp'] * 1000,
              ),
              high: double.parse(candleData['high'].toString()),
              low: double.parse(candleData['low'].toString()),
              close: double.parse(candleData['close'].toString()),
              volume: double.parse(candleData['volume'].toString()),
              previousCandle: previousCandle!,
            );
          }

          candles.add(candle);
          previousCandle = candle;
        }

        return candles;
      } else {
        throw Exception('Failed to load candles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }

  // WebSocket connection for real-time data
  void subscribeToTicker(
    String symbol,
    Function(Map<String, dynamic>) onUpdate,
  ) {
    // WebSocket implementation here
    // When new tick data comes in, you'll need to update the current candle
    // or create a new one if the time interval has passed
  }
}
