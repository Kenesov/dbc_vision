import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color textColor;
  final Color? subtitleColor;

  const SettingsTile({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xFF4355B9),
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
    required this.textColor,
    this.subtitleColor,
    this.iconBackgroundColor = const Color(0x1A4355B9), // 10% opacity
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle!,
        style: TextStyle(
          color: subtitleColor ?? textColor.withOpacity(0.7),
        ),
      )
          : null,
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: iconColor,
          ),
      onTap: onTap,
    );
  }
}
