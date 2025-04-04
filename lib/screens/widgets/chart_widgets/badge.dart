import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Badge extends StatelessWidget {
  const Badge(
      this.svgAsset, {
        required this.size,
        required this.borderColor,
        Key? key,
      }) : super(key: key);

  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Icon(
          svgAsset.contains('man') ? Icons.male : Icons.female,
          color: borderColor,
        ),
      ),
    );
  }
}