import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ClientDonutChart extends StatefulWidget {
  const ClientDonutChart({Key? key}) : super(key: key);

  @override
  _ClientDonutChartState createState() => _ClientDonutChartState();
}

class _ClientDonutChartState extends State<ClientDonutChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Chart centered with a defined height
        Expanded(
          flex: 2,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _Indicator(color: Colors.blue, text: 'Новые клиенты: 3171'),
              const SizedBox(height: 4),
              const _Indicator(color: Colors.teal, text: 'Постоянные клиенты: 632'),
            ],
          ),
    ),

          Expanded(
          flex: 3,
          child: _ClientChart(),
          )
        // Legend below the chart
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
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
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
class _ClientChart extends StatefulWidget {
  const _ClientChart();

  @override
  __ClientChartState createState() => __ClientChartState();
}

class __ClientChartState extends State<_ClientChart> {
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
        centerSpaceRadius: 30, // Increased from 20 to 30 for better centering
        sections: showingSections(),
        startDegreeOffset: 0,
      ),
      swapAnimationDuration: const Duration(milliseconds: 0),
      swapAnimationCurve: Curves.linear,
    );
  }

  List<PieChartSectionData> showingSections() {
    const double newClients = 3171;
    const double regularClients = 632;
    final double total = newClients + regularClients;
    final double newClientsPercentage = (newClients / total) * 100;
    final double regularClientsPercentage = (regularClients / total) * 100;

    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 14.0 : 12.0;
      final radius = isTouched ? 50.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: newClients,
            title: '${newClientsPercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.teal,
            value: regularClients,
            title: '${regularClientsPercentage.toStringAsFixed(1)}%',
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