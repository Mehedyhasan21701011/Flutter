import 'package:flutter/material.dart';
class CandleModel {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final CandleModel? previousCandle;

  CandleModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    this.previousCandle,
  });

  factory CandleModel.fromJson(
    Map<String, dynamic> json, {
    CandleModel? previousCandle,
  }) {
    return CandleModel(
      time: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] * 1000),
      open: double.parse(json['open'].toString()),
      high: double.parse(json['high'].toString()),
      low: double.parse(json['low'].toString()),
      close: double.parse(json['close'].toString()),
      volume: double.parse(json['volume'].toString()),
      previousCandle: previousCandle,
    );
  }

  // Factory constructor that ensures proper candle formation
  factory CandleModel.createFromPrevious({
    required DateTime time,
    required double high,
    required double low,
    required double close,
    required double volume,
    required CandleModel previousCandle,
  }) {
    return CandleModel(
      time: time,
      open: previousCandle
          .close, // Current candle opens at previous candle's close
      high: high,
      low: low,
      close: close,
      volume: volume,
      previousCandle: previousCandle,
    );
  }

  // Calculated properties
  double get typicalPrice => (high + low + close) / 3;
  double get moneyFlow => typicalPrice * volume;
  double get bodySize => (close - open).abs();
  double get range => high - low;
  double get upperShadow => high - (close > open ? close : open);
  double get lowerShadow => (close < open ? close : open) - low;

  // Candle color determination
  bool get isBullish => close > open;
  bool get isBearish => close < open;
  bool get isDoji =>
      (close - open).abs() < (range * 0.1); // Doji if body < 10% of range

  // Enhanced candle power calculation considering previous candle
  double get candlePower {
    double basePower = (bodySize * volume) / 1000000;

    // Boost power if candle breaks previous high/low
    if (previousCandle != null) {
      if (high > previousCandle!.high || low < previousCandle!.low) {
        basePower *= 1.5; // Breakout boost
      }

      // Boost power for gap candles
      if ((open - previousCandle!.close).abs() >
          (previousCandle!.range * 0.01)) {
        basePower *= 1.3; // Gap boost
      }
    }

    return basePower;
  }

  // Price change from previous candle
  double get priceChange =>
      previousCandle != null ? close - previousCandle!.close : 0.0;
  double get priceChangePercent =>
      previousCandle != null && previousCandle!.close != 0
      ? (priceChange / previousCandle!.close) * 100
      : 0.0;

  // Volume comparison with previous candle
  double get volumeChange =>
      previousCandle != null ? volume - previousCandle!.volume : 0.0;
  double get volumeChangePercent =>
      previousCandle != null && previousCandle!.volume != 0
      ? (volumeChange / previousCandle!.volume) * 100
      : 0.0;

  // Candle pattern detection
  bool get isHammer =>
      lowerShadow > (bodySize * 2) && upperShadow < (bodySize * 0.5);
  bool get isShootingStar =>
      upperShadow > (bodySize * 2) && lowerShadow < (bodySize * 0.5);
  bool get isEngulfing =>
      previousCandle != null &&
      ((isBullish &&
              previousCandle!.isBearish &&
              open < previousCandle!.close &&
              close > previousCandle!.open) ||
          (isBearish &&
              previousCandle!.isBullish &&
              open > previousCandle!.close &&
              close < previousCandle!.open));

  // Color for UI
  Color get candleColor {
    if (isDoji) return Colors.grey;
    return isBullish ? Colors.green : Colors.red;
  }

  Color get wickColor => Colors.grey;
}
