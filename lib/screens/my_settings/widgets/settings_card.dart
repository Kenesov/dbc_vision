import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final List<Widget> children;
  final Color backgroundColor;
  final double elevation;
  final BorderRadius borderRadius;

  const SettingsCard({
    super.key,
    required this.children,
    this.backgroundColor = Colors.white,
    this.elevation = 2,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
