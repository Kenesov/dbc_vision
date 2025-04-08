import 'package:flutter/material.dart';

class ExpandableChartCard extends StatelessWidget {
  final String title;
  final Widget chart;
  final double height;
  final bool isLoading;
  final Color accentColor;

  const ExpandableChartCard({
    Key? key,
    required this.title,
    required this.chart,
    required this.height,
    this.isLoading = false,
    this.accentColor = const Color(0xFF4304cb),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: accentColor.withOpacity(0.05),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                accentColor.withOpacity(0.03),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF333333),
                            letterSpacing: 0.4,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 0.5,
                                offset: const Offset(0, 0.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accentColor.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                isLoading
                    ? _buildLoadingState(height)
                    : SizedBox(
                  height: height,
                  child: chart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(double height) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                backgroundColor: accentColor.withOpacity(0.1),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Загрузка данных...',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: accentColor.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

