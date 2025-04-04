import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HourlyVisitsChart extends StatelessWidget {
  const HourlyVisitsChart({super.key}); // Updated to use super parameter

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [
      FlSpot(0, 136), FlSpot(1, 98), FlSpot(2, 65), FlSpot(3, 42),
      FlSpot(4, 35), FlSpot(5, 28), FlSpot(6, 45), FlSpot(7, 102),
      FlSpot(8, 245), FlSpot(9, 320), FlSpot(10, 380), FlSpot(11, 410),
      FlSpot(12, 450), FlSpot(13, 520), FlSpot(14, 780), FlSpot(15, 950),
      FlSpot(16, 1230), FlSpot(17, 1150), FlSpot(18, 920), FlSpot(19, 720),
      FlSpot(20, 510), FlSpot(21, 380), FlSpot(22, 250), FlSpot(23, 180),
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 200,
          verticalInterval: 2,
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
              interval: 4,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 8.0,
                  child: Text(
                    '${value.toInt()}:00',
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
              interval: 200,
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
        maxX: 23,
        minY: 0,
        maxY: 1400,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2196F3),
                Color(0xFF0D47A1),
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
                  strokeColor: const Color(0xFF2196F3),
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2196F3).withAlpha(0x4D), // Use withAlpha for Color objects
                  const Color(0xFF0D47A1).withAlpha(0x00), // Use withAlpha for Color objects
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (LineBarSpot spot) => Colors.blueAccent,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final hour = barSpot.x.toInt();
                return LineTooltipItem(
                  '${hour}:00\n',
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