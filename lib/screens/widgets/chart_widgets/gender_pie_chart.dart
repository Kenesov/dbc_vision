import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GenderPieChart extends StatefulWidget {
  const GenderPieChart({Key? key}) : super(key: key);

  @override
  _GenderPieChartState createState() => _GenderPieChartState();
}

class _GenderPieChartState extends State<GenderPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Legend on the left
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Indicator(color: Colors.blue, text: 'Мужчины'),
              const SizedBox(height: 4), // Increased spacing from 2 to 4
              const _Indicator(color: Colors.pink, text: 'Женщины'),
            ],
          ),
        ),
        // Chart centered on the right
        Expanded(
          flex: 3,
          child: Center(
            child: _GenderChart(),
          ),
        ),
      ],
    );
  }
}

// Separate widget for the indicator to make it const
class _Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const _Indicator({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10, // Increased size from 8 to 10
          height: 10, // Increased size from 8 to 10
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6), // Increased spacing from 4 to 6
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12, // Increased font size from 10 to 12
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// Separate widget for the chart to isolate state
class _GenderChart extends StatefulWidget {
  const _GenderChart();

  @override
  __GenderChartState createState() => __GenderChartState();
}

class __GenderChartState extends State<_GenderChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 30, // Increased from 20 to 30
        sections: showingSections(),
        startDegreeOffset: 0,
      ),
      swapAnimationDuration: const Duration(milliseconds: 0),
      swapAnimationCurve: Curves.linear,
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 14.0 : 12.0; // Increased font size from 10/8 to 14/12
      final radius = isTouched ? 50.0 : 40.0; // Increased radius from 40/30 to 50/40

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 74.5,
            title: '74.5%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.pink,
            value: 25.5,
            title: '25.5%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}