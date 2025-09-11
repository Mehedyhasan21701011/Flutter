class VolumeProfileModel {
  final double price;
  final double volume;
  final double buyVolume; // Volume from bullish candles
  final double sellVolume; // Volume from bearish candles

  VolumeProfileModel({
    required this.price,
    required this.volume,
    required this.buyVolume,
    required this.sellVolume,
  });

  double get buyVolumePercent => volume > 0 ? (buyVolume / volume) * 100 : 0;
  double get sellVolumePercent => volume > 0 ? (sellVolume / volume) * 100 : 0;
  bool get isBuyDominant => buyVolume > sellVolume;
}
