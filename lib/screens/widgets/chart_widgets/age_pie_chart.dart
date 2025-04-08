import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AgePieChart extends StatefulWidget {
  final bool isLoading;

  const AgePieChart({
    Key? key,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _AgePieChartState createState() => _AgePieChartState();
}

class _AgePieChartState extends State<AgePieChart> with SingleTickerProviderStateMixin {
  int touchedIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
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
              const _Indicator(
                color: Color(0xFF42A5F5),
                text: '1-17',
                value: '19 (11.9%)',
              ),
              const SizedBox(height: 10),
              const _Indicator(
                color: Color(0xFF66BB6A),
                text: '18-30',
                value: '1262 (35.0%)',
              ),
              const SizedBox(height: 10),
              const _Indicator(
                color: Color(0xFFFFD54F),
                text: '41-54',
                value: '738 (19.4%)',
              ),
              const SizedBox(height: 10),
              const _Indicator(
                color: Color(0xFFFF7043),
                text: '55-99',
                value: '452 (33.2%)',
              ),
            ],
          ),
        ),
        // Chart centered on the right
        Expanded(
          flex: 3,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: _AgeChart(
                  animationValue: _animation.value,
                ),
              );
            },
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
  final String value;

  const _Indicator({
    required this.color,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF555555),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Separate widget for the chart to isolate state
class _AgeChart extends StatefulWidget {
  final double animationValue;

  const _AgeChart({
    required this.animationValue,
  });

  @override
  __AgeChartState createState() => __AgeChartState();
}

class __AgeChartState extends State<_AgeChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
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
              sectionsSpace: 2,
              centerSpaceRadius: 35,
              sections: showingSections(),
              startDegreeOffset: 180,
            ),
            swapAnimationDuration: const Duration(milliseconds: 800),
            swapAnimationCurve: Curves.easeInOutQuart,
          ),
        ),
        // Center text
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Всего',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '2471',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;

      // Apply animation value to radius
      final animatedRadius = radius * widget.animationValue;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFF42A5F5),
            value: 33.2,
            title: '33.2%',
            radius: animatedRadius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFF66BB6A),
            value: 35.0,
            title: '35.0%',
            radius: animatedRadius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFFFFD54F),
            value: 19.4,
            title: '19.4%',
            radius: animatedRadius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xFFFF7043),
            value: 11.9,
            title: '11.9%',
            radius: animatedRadius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

