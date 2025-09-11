import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quotex/app/data/model/candlemodel.dart';
import 'package:quotex/app/data/model/profile.dart';
import 'package:quotex/app/data/model/service.dart';

class TradingController extends GetxController {
  final TradingApiService _apiService = TradingApiService();

  // Observable variables
  final RxList<CandleModel> candles = <CandleModel>[].obs;
  final RxList<VolumeProfileModel> volumeProfile = <VolumeProfileModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedSymbol = 'USDBDT'.obs;
  final RxString selectedInterval = '5m'.obs;
  final RxString selectedMetric = 'candlePower'.obs;
  final RxDouble priceStep = 0.05.obs;

  // Calculated observables
  Rx<VolumeProfileModel?> poc = Rx<VolumeProfileModel?>(null);
  RxDouble totalVolume = 0.0.obs;
  RxDouble totalMoneyFlow = 0.0.obs;
  RxDouble maxCandlePower = 0.0.obs;
  RxInt bullishCandles = 0.obs;
  RxInt bearishCandles = 0.obs;
  RxDouble avgCandleSize = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCandleData();

    // Listen to symbol/interval changes
    ever(selectedSymbol, (_) => fetchCandleData());
    ever(selectedInterval, (_) => fetchCandleData());
  }

  Future<void> fetchCandleData() async {
    try {
      isLoading.value = true;

      final fetchedCandles = await _apiService.fetchCandles(
        symbol: selectedSymbol.value,
        interval: selectedInterval.value,
      );

      candles.assignAll(fetchedCandles);
      calculateVolumeProfile();
      calculateStatistics();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void calculateVolumeProfile() {
    if (candles.isEmpty) return;

    Map<double, VolumeData> priceVolumeMap = {};

    for (var candle in candles) {
      // Distribute volume across the price range of each candle
      double volumePerPrice =
          candle.volume /
          ((candle.high - candle.low) / priceStep.value).ceil().clamp(
            1,
            double.infinity,
          );

      // Determine if this is buy or sell volume based on candle color
      double buyVol = candle.isBullish ? volumePerPrice : 0;
      double sellVol = candle.isBearish ? volumePerPrice : 0;

      // Create price levels within the candle's range
      for (
        double price = candle.low;
        price <= candle.high;
        price += priceStep.value
      ) {
        double roundedPrice = (price * 100).round() / 100;

        if (!priceVolumeMap.containsKey(roundedPrice)) {
          priceVolumeMap[roundedPrice] = VolumeData();
        }

        priceVolumeMap[roundedPrice]!.totalVolume += volumePerPrice;
        priceVolumeMap[roundedPrice]!.buyVolume += buyVol;
        priceVolumeMap[roundedPrice]!.sellVolume += sellVol;
      }
    }

    // Convert to list and sort by price
    List<VolumeProfileModel> profile =
        priceVolumeMap.entries
            .map(
              (entry) => VolumeProfileModel(
                price: entry.key,
                volume: entry.value.totalVolume,
                buyVolume: entry.value.buyVolume,
                sellVolume: entry.value.sellVolume,
              ),
            )
            .toList()
          ..sort((a, b) => a.price.compareTo(b.price));

    volumeProfile.assignAll(profile);

    // Find Point of Control (highest volume price)
    if (profile.isNotEmpty) {
      poc.value = profile.reduce(
        (max, current) => current.volume > max.volume ? current : max,
      );
    }
  }

  void calculateStatistics() {
    if (candles.isEmpty) return;

    totalVolume.value = candles.fold(0.0, (sum, candle) => sum + candle.volume);
    totalMoneyFlow.value = candles.fold(
      0.0,
      (sum, candle) => sum + candle.moneyFlow,
    );
    maxCandlePower.value = candles
        .map((c) => c.candlePower)
        .reduce((a, b) => a > b ? a : b);
    bullishCandles.value = candles.where((c) => c.isBullish).length;
    bearishCandles.value = candles.where((c) => c.isBearish).length;
    avgCandleSize.value =
        candles.fold(0.0, (sum, candle) => sum + candle.bodySize) /
        candles.length;
  }

  // Update current candle with new tick data
  void updateCurrentCandle(Map<String, dynamic> tickData) {
    if (candles.isEmpty) return;

    final currentCandle = candles.last;
    final newPrice = double.parse(tickData['price'].toString());
    final newVolume = double.parse(tickData['volume'].toString());

    // Update current candle
    final updatedCandle = CandleModel(
      time: currentCandle.time,
      open: currentCandle.open, // Open never changes for current candle
      high: newPrice > currentCandle.high ? newPrice : currentCandle.high,
      low: newPrice < currentCandle.low ? newPrice : currentCandle.low,
      close: newPrice,
      volume: currentCandle.volume + newVolume,
      previousCandle: currentCandle.previousCandle,
    );

    candles[candles.length - 1] = updatedCandle;

    // Recalculate volume profile and statistics
    calculateVolumeProfile();
    calculateStatistics();
  }

  // Create new candle when time interval changes
  void createNewCandle(Map<String, dynamic> newCandleData) {
    final previousCandle = candles.isNotEmpty ? candles.last : null;

    final newCandle = CandleModel.createFromPrevious(
      time: DateTime.fromMillisecondsSinceEpoch(
        newCandleData['timestamp'] * 1000,
      ),
      high: double.parse(newCandleData['high'].toString()),
      low: double.parse(newCandleData['low'].toString()),
      close: double.parse(newCandleData['close'].toString()),
      volume: double.parse(newCandleData['volume'].toString()),
      previousCandle: previousCandle!,
    );

    candles.add(newCandle);
    calculateVolumeProfile();
    calculateStatistics();
  }

  void updateSymbol(String symbol) {
    selectedSymbol.value = symbol;
  }

  void updateInterval(String interval) {
    selectedInterval.value = interval;
  }

  void updateMetric(String metric) {
    selectedMetric.value = metric;
  }

  void updatePriceStep(double step) {
    priceStep.value = step;
    calculateVolumeProfile();
  }

  // Get metric value for a candle
  double getCandleMetric(CandleModel candle) {
    switch (selectedMetric.value) {
      case 'candlePower':
        return candle.candlePower;
      case 'moneyFlow':
        return candle.moneyFlow / 1000000; // Normalized
      case 'volume':
        return candle.volume / 1000000; // Normalized
      case 'bodySize':
        return candle.bodySize;
      case 'volumeChange':
        return candle.volumeChangePercent;
      case 'priceChange':
        return candle.priceChangePercent;
      default:
        return candle.candlePower;
    }
  }

  // Detect patterns in recent candles
  List<String> getRecentPatterns() {
    if (candles.length < 2) return [];

    List<String> patterns = [];
    final recent = candles.length > 5
        ? candles.sublist(candles.length - 5)
        : candles;

    for (var candle in recent) {
      if (candle.isHammer) patterns.add('Hammer');
      if (candle.isShootingStar) patterns.add('Shooting Star');
      if (candle.isEngulfing) patterns.add('Engulfing');
      if (candle.isDoji) patterns.add('Doji');
    }

    return patterns.toSet().toList(); // Remove duplicates
  }
}

// Helper class for volume calculations
class VolumeData {
  double totalVolume = 0.0;
  double buyVolume = 0.0;
  double sellVolume = 0.0;
}
