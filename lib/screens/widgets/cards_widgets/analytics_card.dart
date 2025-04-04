import 'package:flutter/material.dart';
import 'package:dbc_vision/screens/widgets/chart_widgets/gender_pie_chart.dart';
import 'package:dbc_vision/screens/widgets/chart_widgets/age_pie_chart.dart';
import 'package:dbc_vision/screens/widgets/chart_widgets/client_donut_chart.dart';

class AnalyticsCard extends StatefulWidget {
  final bool isChartsVisible;
  final VoidCallback onToggle;
  final GlobalKey cardKey;

  const AnalyticsCard({
    Key? key,
    required this.isChartsVisible,
    required this.onToggle,
    required this.cardKey,
  }) : super(key: key);

  @override
  _AnalyticsCardState createState() => _AnalyticsCardState();
}

class _AnalyticsCardState extends State<AnalyticsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onToggle,
      child: Card(
        key: widget.cardKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Increased padding from 12 to 16
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Аналитика',
                    style: TextStyle(
                      fontSize: 16, // Increased font size from 14 to 16
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65209),
                    ),
                  ),
                  Icon(
                    widget.isChartsVisible
                        ? Icons.arrow_drop_down
                        : Icons.arrow_drop_up,
                    color: const Color(0xFFE65209),
                    size: 24, // Increased icon size from 20 to 24
                  ),
                ],
              ),
              const SizedBox(height: 8), // Increased spacing from 6 to 8
              if (widget.isChartsVisible) ...[
                // Gender Chart
                const Text(
                  'Входящие клиенты',
                  style: TextStyle(
                    fontSize: 14, // Increased font size from 12 to 14
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4), // Increased spacing from 2 to 4
                SizedBox(
                  height: 150, // Increased height from 100 to 150
                  child: GenderPieChart(),
                ),
                const SizedBox(height: 12), // Increased spacing from 8 to 12
                // Age Chart
                const Text(
                  'Возраст клиентов',
                  style: TextStyle(
                    fontSize: 14, // Increased font size from 12 to 14
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4), // Increased spacing from 2 to 4
                SizedBox(
                  height: 150, // Increased height from 100 to 150
                  child: AgePieChart(),
                ),
                const SizedBox(height: 12), // Increased spacing from 8 to 12
                // Client Type Chart
                const Text(
                  'Входящие клиенты',
                  style: TextStyle(
                    fontSize: 14, // Increased font size from 12 to 14
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4), // Increased spacing from 2 to 4
                SizedBox(
                  height: 150, // Reduced height from 160 to 150 for consistency
                  child: ClientDonutChart(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}