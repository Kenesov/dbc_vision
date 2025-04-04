import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class DateVisitsChart extends StatelessWidget {
  const DateVisitsChart({super.key}); // Updated to use super parameter

  @override
  Widget build(BuildContext context) {
    // Sample data for date visits (30 days)
    final List<FlSpot> spots = List.generate(30, (index) {
      double baseValue = 150;
      double variation = 100 * (index % 7 == 0 || index % 7 == 6 ? 0.5 : 1.0); // Weekend effect
      double randomFactor = (index % 3 == 0) ? 1.5 : ((index % 5 == 0) ? 0.7 : 1.0); // Some days have patterns
      double value = baseValue + (math.sin(index * 0.5) * variation * randomFactor);
      return FlSpot(index.toDouble(), value.clamp(20, 350));
    });

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 50,
          verticalInterval: 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Color(Colors.grey.value).withAlpha(0x4D), // Convert MaterialColor to Color and set alpha
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Color(Colors.grey.value).withAlpha(0x4D), // Convert MaterialColor to Color and set alpha
              strokeWidth: 1,
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
          border: Border.all(color: Color(Colors.grey.value).withAlpha(0x80)), // Convert MaterialColor to Color and set alpha
        ),
        minX: 0,
        maxX: 29,
        minY: 0,
        maxY: 350,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
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
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFF44336).withAlpha(0x4D), // Use withAlpha for Color objects
                  const Color(0xFFB71C1C).withAlpha(0x00), // Use withAlpha for Color objects
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (LineBarSpot spot) => Colors.redAccent,
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
                  ),
                  children: [
                    TextSpan(
                      text: '${barSpot.y.toInt()} посещений',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}