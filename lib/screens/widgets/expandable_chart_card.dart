import 'package:flutter/material.dart';

class ExpandableChartCard extends StatefulWidget {
  final String title;
  final Widget chart;
  final double height;

  const ExpandableChartCard({
    Key? key,
    required this.title,
    required this.chart,
    required this.height,
  }) : super(key: key);

  @override
  _ExpandableChartCardState createState() => _ExpandableChartCardState();
}

class _ExpandableChartCardState extends State<ExpandableChartCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65209),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    color: const Color(0xFFE65209),
                    size: 24,
                  ),
                ],
              ),
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 4),
              SizedBox(
                height: widget.height,
                child: widget.chart,
              ),
            ],
          ],
        ),
      ),
    );
  }
}