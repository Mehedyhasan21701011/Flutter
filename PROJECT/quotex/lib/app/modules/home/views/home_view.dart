import 'package:fl_chart/fl_chart.dart' show FlTitlesData, LineChart, AxisTitles, FlDotData, FlLine, FlGridData, SideTitles, FlBorderData, FlSpot, LineChartBarData, FlDotCirclePainter, LineChartData;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:quotex/app/modules/home/controllers/home_controller.dart';

class TradingChartView extends StatelessWidget {
  const TradingChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TradingController>(
      init: TradingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF1F2937),
          appBar: AppBar(
            backgroundColor: const Color(0xFF111827),
            title: Obx(() => Text(
              '${controller.selectedSymbol.value} - ${controller.selectedInterval.value}',
              style: const TextStyle(color: Colors.green),
            )),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.green),
                onPressed: () => controller.fetchCandleData(),
              ),
              // Pattern indicator
              Obx(() {
                final patterns = controller.getRecentPatterns();
                return patterns.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              patterns.first,
                              style: const TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            }

            return Column(
              children: [
                // Controls
                _buildControls(controller),
                
                // Charts
                Expanded(
                  child: Row(
                    children: [
                      // Main Chart (70% width)
                      Expanded(
                        flex: 7,
                        child: _buildCandlestickChart(controller),
                      ),
                      
                      // Volume Profile (30% width)
                      Expanded(
                        flex: 3,
                        child: _buildVolumeProfile(controller),
                      ),
                    ],
                  ),
                ),
                
                // Statistics
                _buildStatistics(controller),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _buildControls(TradingController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF374151),
        border: Border(bottom: BorderSide(color: Color(0xFF4B5563))),
      ),
      child: Row(
        children: [
          // Symbol Selector
          Expanded(
            child: DropdownButtonFormField<String>(
              value: controller.selectedSymbol.value,
              decoration: const InputDecoration(
                labelText: 'Symbol',
                labelStyle: TextStyle(color: Colors.green),
                border: OutlineInputBorder(),
              ),
              dropdownColor: const Color(0xFF374151),
              style: const TextStyle(color: Colors.white),
              items: ['USDBDT', 'EURUSD', 'GBPUSD', 'AUDUSD']
                  .map((symbol) => DropdownMenuItem(
                        value: symbol,
                        child: Text(symbol),
                      ))
                  .toList(),
              onChanged: (value) => controller.updateSymbol(value!),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Interval Selector
          Expanded(
            child: DropdownButtonFormField<String>(
              value: controller.selectedInterval.value,
              decoration: const InputDecoration(
                labelText: 'Interval',
                labelStyle: TextStyle(color: Colors.green),
                border: OutlineInputBorder(),
              ),
              dropdownColor: const Color(0xFF374151),
              style: const TextStyle(color: Colors.white),
              items: ['1m', '5m', '15m', '1h', '4h', '1d']
                  .map((interval) => DropdownMenuItem(
                        value: interval,
                        child: Text(interval),
                      ))
                  .toList(),
              onChanged: (value) => controller.updateInterval(value!),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Metric Selector
          Expanded(
            child: DropdownButtonFormField<String>(
              value: controller.selectedMetric.value,
              decoration: const InputDecoration(
                labelText: 'Metric',
                labelStyle: TextStyle(color: Colors.green),
                border: OutlineInputBorder(),
              ),
              dropdownColor: const Color(0xFF374151),
              style: const TextStyle(color: Colors.white),
              items: [
                const DropdownMenuItem(value: 'candlePower', child: Text('Candle Power')),
                const DropdownMenuItem(value: 'moneyFlow', child: Text('Money Flow')),
                const DropdownMenuItem(value: 'volume', child: Text('Volume')),
                const DropdownMenuItem(value: 'bodySize', child: Text('Body Size')),
                const DropdownMenuItem(value: 'volumeChange', child: Text('Volume Change %')),
                const DropdownMenuItem(value: 'priceChange', child: Text('Price Change %')),
              ],
              onChanged: (value) => controller.updateMetric(value!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCandlestickChart(TradingController controller) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Candlestick Chart & ${controller.selectedMetric.value}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Obx(() => Text(
                'Bull: ${controller.bullishCandles.value} | Bear: ${controller.bearishCandles.value}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              )),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                backgroundColor: const Color(0xFF374151),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF4B5563),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF4B5563),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.green, fontSize: 10),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(2),
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < controller.candles.length) {
                          final candle = controller.candles[value.toInt()];
                          return Text(
                            DateFormat('HH:mm').format(candle.time),
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xFF4B5563)),
                ),
                lineBarsData: [
                  // High-Low lines (wicks)
                  LineChartBarData(
                    spots: controller.candles
                        .asMap()
                        .entries
                        .map((entry) => FlSpot(
                              entry.key.toDouble(),
                              entry.value.high,
                            ))
                        .toList(),
                    isCurved: false,
                    color: Colors.grey,
                    barWidth: 1,
                    dotData: const FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: controller.candles
                        .asMap()
                        .entries
                        .map((entry) => FlSpot(
                              entry.key.toDouble(),
                              entry.value.low,
                            ))
                        .toList(),
                    isCurved: false,
                    color: Colors.grey,
                    barWidth: 1,
                    dotData: const FlDotData(show: false),
                  ),
                  // Close line (with color based on candle type)
                  LineChartBarData(
                    spots: controller.candles
                        .asMap()
                        .entries
                        .map((entry) => FlSpot(
                              entry.key.toDouble(),
                              entry.value.close,
                            ))
                        .toList(),
                    isCurved: false,
                    color: Colors.white,
                    barWidth: 2,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        final candle = controller.candles[index];
                        return FlDotCirclePainter(
                          radius: 3,
                          color: candle.candleColor,
                          strokeWidth: 1,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeProfile(TradingController controller) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Volume Profile',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          if (controller.poc.value != null) ...[
            Text(
              'POC: \$${controller.poc.value!.price.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.yellow, fontSize: 12),
            ),
            Text(
              'Vol: ${(controller.poc.value!.volume / 1000000).toStringAsFixed(1)}M',
              style: const TextStyle(color: Colors.green, fontSize: 12),
            ),
            Text(
              'Buy: ${controller.poc.value!.buyVolumePercent.toStringAsFixed(0)}%',
              style: const TextStyle(color: Colors.green, fontSize: 10),
            ),
          ],
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: controller.volumeProfile.length,
              itemBuilder: (context, index) {
                final profile = controller.volumeProfile[index];
                final maxVolume = controller.volumeProfile.isEmpty 
                    ? 1.0 
                    : controller.volumeProfile
                        .map((v) => v.volume)
                        .reduce((a, b) => a > b ? a : b);
                
                final widthPercent = (profile.volume / maxVolume) * 100;
                final isPOC = profile == controller.poc.value;
                
                return Container(
                  height: 20,
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    children: [
                      // Price label
                      SizedBox(
                        width: 60,
                        child: Text(
                          '\$${profile.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: isPOC ? Colors.yellow : Colors.white,
                            fontSize: 10,
                            fontWeight: isPOC ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      // Volume bar with buy/sell split
                      Expanded(
                        child: Stack(
                          children: [
                            // Total volume bar
                            Container(
                              height: 16,
                              width: widthPercent,
                              decoration: BoxDecoration(
                                color: isPOC ? Colors.yellow.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            // Buy volume (green part)
                            Container(
                              height: 16,
                              width: widthPercent * (profile.buyVolumePercent / 100),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            // Sell volume (red part) - positioned at the end
                            Positioned(
                              right: 0,
                              child: Container(
                                height: 16,
                                width: widthPercent * (profile.sellVolumePercent / 100),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Volume amount
                      SizedBox(
                        width: 40,
                        child: Text(
                          '${(profile.volume / 1000000).toStringAsFixed(1)}M',
                          style: const TextStyle(color: Colors.white, fontSize: 8),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(TradingController controller) {
    if (controller.candles.isEmpty) return const SizedBox.shrink();
    
    final latestCandle = controller.candles.last;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF374151),
        border: Border(top: BorderSide(color: Color(0xFF4B5563))),
      ),
      child: Column(
        children: [
          // Main statistics row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard(
                'Current Price',
                '\${latestCandle.close.toStringAsFixed(4)}',
                '${latestCandle.isBullish ? '↗' : latestCandle.isBearish ? '↘' : '→'} ${latestCandle.priceChangePercent.toStringAsFixed(2)}%',
                latestCandle.candleColor,
              ),
              _buildStatCard(
                'Candle Body',
                latestCandle.bodySize.toStringAsFixed(4),
                '${latestCandle.isDoji ? 'Doji' : latestCandle.isBullish ? 'Bull' : 'Bear'}',
                latestCandle.candleColor,
              ),
              _buildStatCard(
                'Volume',
                '${(latestCandle.volume / 1000000).toStringAsFixed(1)}M',
                '${latestCandle.volumeChangePercent >= 0 ? '+' : ''}${latestCandle.volumeChangePercent.toStringAsFixed(1)}%',
                latestCandle.volumeChangePercent >= 0 ? Colors.green : Colors.red,
              ),
              _buildStatCard(
                'Candle Power',
                latestCandle.candlePower.toStringAsFixed(1),
                'Enhanced: ${latestCandle.candlePower > latestCandle.bodySize * latestCandle.volume / 1000000 ? 'Yes' : 'No'}',
                Colors.orange,
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Secondary statistics row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard(
                'Avg Body Size',
                controller.avgCandleSize.value.toStringAsFixed(4),
                'Over ${controller.candles.length} candles',
                Colors.blue,
              ),
              _buildStatCard(
                'POC Price',
                controller.poc.value != null 
                    ? '\${controller.poc.value!.price.toStringAsFixed(4)}'
                    : 'N/A',
                controller.poc.value != null 
                    ? '${controller.poc.value!.isBuyDominant ? 'Buy' : 'Sell'} Dom'
                    : '',
                Colors.yellow,
              ),
              _buildStatCard(
                'Total Volume',
                '${(controller.totalVolume.value / 1000000).toStringAsFixed(0)}M',
                'Bull/Bear: ${controller.bullishCandles.value}/${controller.bearishCandles.value}',
                Colors.purple,
              ),
              _buildStatCard(
                'Money Flow',
                '\${(controller.totalMoneyFlow.value / 1000000).toStringAsFixed(0)}M',
                'Total across candles',
                Colors.cyan,
              ),
            ],
          ),
          
          // Pattern detection row
          Obx(() {
            final patterns = controller.getRecentPatterns();
            if (patterns.isEmpty) return const SizedBox.shrink();
            
            return Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.pattern, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Detected Patterns: ',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      children: patterns.map((pattern) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          pattern,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 10),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(color: color.withOpacity(0.8), fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Enhanced WebSocket service for real-time updates
class WebSocketService extends GetxService {
  final TradingController _controller = Get.find<TradingController>();
  
  void connectToStream(String symbol) {
    // WebSocket connection implementation
    // Example structure for handling real-time data:
    /*
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://api.example.com/ws/$symbol'),
    );
    
    channel.stream.listen((data) {
      final tickData = json.decode(data);
      
      // Determine if we need to create a new candle or update existing one
      final now = DateTime.now();
      final lastCandleTime = _controller.candles.last.time;
      
      // Check if we need a new candle based on interval
      if (_shouldCreateNewCandle(now, lastCandleTime, _controller.selectedInterval.value)) {
        _controller.createNewCandle(tickData);
      } else {
        _controller.updateCurrentCandle(tickData);
      }
    });
    */
  }
  
  bool _shouldCreateNewCandle(DateTime now, DateTime lastCandleTime, String interval) {
    final Duration intervalDuration = _getIntervalDuration(interval);
    return now.difference(lastCandleTime) >= intervalDuration;
  }
  
  Duration _getIntervalDuration(String interval) {
    switch (interval) {
      case '1m': return const Duration(minutes: 1);
      case '5m': return const Duration(minutes: 5);
      case '15m': return const Duration(minutes: 15);
      case '1h': return const Duration(hours: 1);
      case '4h': return const Duration(hours: 4);
      case '1d': return const Duration(days: 1);
      default: return const Duration(minutes: 5);
    }
  }
}