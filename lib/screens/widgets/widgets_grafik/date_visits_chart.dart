import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class DateVisitsChart extends StatefulWidget {
  final bool isLoading;

  const DateVisitsChart({
    super.key,
    this.isLoading = false,
  });

  @override
  State<DateVisitsChart> createState() => _DateVisitsChartState();
}

class _DateVisitsChartState extends State<DateVisitsChart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return _buildChart(_animation.value);
      },
    );
  }

  Widget _buildChart(double animationValue) {
    // Sample data for date visits (30 days)
    final List<FlSpot> spots = List.generate(30, (index) {
      double baseValue = 150;
      double variation = 100 * (index % 7 == 0 || index % 7 == 6 ? 0.5 : 1.0); // Weekend effect
      double randomFactor = (index % 3 == 0) ? 1.5 : ((index % 5 == 0) ? 0.7 : 1.0); // Some days have patterns
      double value = baseValue + (math.sin(index * 0.5) * variation * randomFactor);
      return FlSpot(index.toDouble(), value.clamp(20, 350) * animationValue);
    });

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 50,
            verticalInterval: 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.shade200,
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey.shade200,
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  final day = value.toInt() + 1;
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 8.0,
                    child: Text(
                      '$day',
                      style: const TextStyle(
                        color: Color(0xFF555555),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 50,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 8.0,
                    child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        color: Color(0xFF555555),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
                reservedSize: 40,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              left: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          minX: 0,
          maxX: 29,
          minY: 0,
          maxY: 350,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.3,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF44336),
                  Color(0xFFB71C1C),
                ],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: const Color(0xFFF44336),
                  );
                },
                checkToShowDot: (spot, barData) {
                  // Show dots only at specific intervals to avoid clutter
                  return spot.x % 5 == 0 || spot.y > 280 * animationValue;
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFF44336).withOpacity(0.3),
                    const Color(0xFFB71C1C).withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (LineBarSpot barSpot) => const Color(0xFF2196F3),
              tooltipRoundedRadius: 12,
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  final day = barSpot.x.toInt() + 1;
                  final date = DateTime(2025, 3, day);
                  final formattedDate = DateFormat('dd.MM').format(date);
                  return LineTooltipItem(
                    '$formattedDate\n',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: '${barSpot.y.toInt()} посещений',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
            handleBuiltInTouches: true,
            touchSpotThreshold: 20,
          ),
        ),
      ),
    );
  }
}

