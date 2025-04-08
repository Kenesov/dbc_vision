import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyVisitsChart extends StatefulWidget {
  final bool isLoading;

  const WeeklyVisitsChart({
    super.key,
    this.isLoading = false,
  });

  @override
  State<WeeklyVisitsChart> createState() => _WeeklyVisitsChartState();
}

class _WeeklyVisitsChartState extends State<WeeklyVisitsChart> with SingleTickerProviderStateMixin {
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
    final List<FlSpot> spots = [
      FlSpot(0, 620 * animationValue), // Sunday
      FlSpot(1, 1850 * animationValue), // Monday
      FlSpot(2, 1420 * animationValue), // Tuesday
      FlSpot(3, 1020 * animationValue), // Wednesday
      FlSpot(4, 1340 * animationValue), // Thursday
      FlSpot(5, 1410 * animationValue), // Friday
      FlSpot(6, 1020 * animationValue), // Saturday
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

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 400,
            verticalInterval: 1,
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
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  String text = '';
                  if (index >= 0 && index < weekDays.length) {
                    text = weekDays[index].substring(0, 3);
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 8.0,
                    child: Text(
                      text,
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
                interval: 400,
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
          maxX: 6,
          minY: 0,
          maxY: 2000,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.3,
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
                    const Color(0xFF4CAF50).withOpacity(0.3),
                    const Color(0xFF1B5E20).withOpacity(0.05),
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

