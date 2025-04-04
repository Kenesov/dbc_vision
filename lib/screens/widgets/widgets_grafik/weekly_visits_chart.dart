import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyVisitsChart extends StatelessWidget {
  const WeeklyVisitsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [
      FlSpot(0, 620), // Sunday
      FlSpot(1, 1850), // Monday
      FlSpot(2, 1420), // Tuesday
      FlSpot(3, 1020), // Wednesday
      FlSpot(4, 1340), // Thursday
      FlSpot(5, 1410), // Friday
      FlSpot(6, 1020), // Saturday
    ];

    final List<String> weekDays = [
      'Воскресенье',
      'Понедельник',
      'Вторник',
      'Среда',
      'Четверг',
      'Пятница',
      'Суббота',
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 200,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Color(Colors.grey.value).withAlpha(0x4D),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Color(Colors.grey.value).withAlpha(0x4D),
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
              interval: 1,
              getTitlesWidget: (value, meta) { // Added meta parameter
                final index = value.toInt();
                String text = '';
                if (index >= 0 && index < weekDays.length) {
                  text = weekDays[index].substring(0, 3);
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide, // Use meta.axisSide
                  space: 8.0,
                  child: Text(
                    text,
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
              interval: 400,
              getTitlesWidget: (value, meta) { // Added meta parameter
                return SideTitleWidget(
                  axisSide: meta.axisSide, // Use meta.axisSide
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
          border: Border.all(color: Color(Colors.grey.value).withAlpha(0x80)),
        ),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 2000,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4CAF50),
                Color(0xFF1B5E20),
              ],
            ),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 6,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: const Color(0xFF4CAF50),
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4CAF50).withAlpha(0x4D),
                  const Color(0xFF1B5E20).withAlpha(0x00),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (LineBarSpot spot) => Colors.green,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final dayIndex = barSpot.x.toInt();
                String dayName = '';
                if (dayIndex >= 0 && dayIndex < weekDays.length) {
                  dayName = weekDays[dayIndex];
                }
                return LineTooltipItem(
                  '$dayName\n',
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