import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HourlyVisitsChart extends StatefulWidget {
  final bool isLoading;

  const HourlyVisitsChart({
    super.key,
    this.isLoading = false,
  });

  @override
  State<HourlyVisitsChart> createState() => _HourlyVisitsChartState();
}

class _HourlyVisitsChartState extends State<HourlyVisitsChart> with SingleTickerProviderStateMixin {
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
      FlSpot(0, 136 * animationValue),
      FlSpot(1, 98 * animationValue),
      FlSpot(2, 65 * animationValue),
      FlSpot(3, 42 * animationValue),
      FlSpot(4, 35 * animationValue),
      FlSpot(5, 28 * animationValue),
      FlSpot(6, 45 * animationValue),
      FlSpot(7, 102 * animationValue),
      FlSpot(8, 245 * animationValue),
      FlSpot(9, 320 * animationValue),
      FlSpot(10, 380 * animationValue),
      FlSpot(11, 410 * animationValue),
      FlSpot(12, 450 * animationValue),
      FlSpot(13, 520 * animationValue),
      FlSpot(14, 780 * animationValue),
      FlSpot(15, 950 * animationValue),
      FlSpot(16, 1230 * animationValue),
      FlSpot(17, 1150 * animationValue),
      FlSpot(18, 920 * animationValue),
      FlSpot(19, 720 * animationValue),
      FlSpot(20, 510 * animationValue),
      FlSpot(21, 380 * animationValue),
      FlSpot(22, 250 * animationValue),
      FlSpot(23, 180 * animationValue),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 200,
            verticalInterval: 4,
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
                interval: 4,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 8.0,
                    child: Text(
                      '${value.toInt()}:00',
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
                interval: 200,
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
          maxX: 23,
          minY: 0,
          maxY: 1400,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.3,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2196F3),
                  Color(0xFF0D47A1),
                ],
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 5,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: const Color(0xFF2196F3),
                  );
                },
                checkToShowDot: (spot, barData) {
                  // Show dots only at specific intervals to avoid clutter
                  return spot.x % 4 == 0 || spot.y > 1000;
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2196F3).withOpacity(0.3),
                    const Color(0xFF0D47A1).withOpacity(0.05),
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
                  final hour = barSpot.x.toInt();
                  return LineTooltipItem(
                    '${hour}:00\n',
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

