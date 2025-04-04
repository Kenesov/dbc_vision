import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AgePieChart extends StatefulWidget {
  const AgePieChart({Key? key}) : super(key: key);

  @override
  _AgePieChartState createState() => _AgePieChartState();
}

class _AgePieChartState extends State<AgePieChart> {
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
              const _Indicator(color: Colors.blue, text: '1-17: 19'),
              const SizedBox(height: 4), // Increased spacing from 2 to 4
              const _Indicator(color: Colors.green, text: '18-30: 1262'),
              const SizedBox(height: 4), // Increased spacing from 2 to 4
              const _Indicator(color: Colors.yellow, text: '41-54: 738'),
              const SizedBox(height: 4), // Increased spacing from 2 to 4
              const _Indicator(color: Colors.orange, text: '55-99: 452'),
            ],
          ),
        ),
        // Chart centered on the right
        Expanded(
          flex: 3,
          child: Center(
            child: _AgeChart(),
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
      mainAxisSize: MainAxisSize.min,
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
class _AgeChart extends StatefulWidget {
  const _AgeChart();

  @override
  __AgeChartState createState() => __AgeChartState();
}

class __AgeChartState extends State<_AgeChart> {
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
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 14.0 : 12.0; // Increased font size from 10/8 to 14/12
      final radius = isTouched ? 50.0 : 40.0; // Increased radius from 40/30 to 50/40

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 33.2,
            title: '33.2%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: 35.0,
            title: '35.0%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 19.4,
            title: '19.4%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: 11.9,
            title: '11.9%',
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