import 'package:flutter/material.dart';

class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;
  final VoidCallback? onTitleTap;

  const ModernAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 0,
    this.onTitleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        boxShadow: elevation > 0
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ]
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/logo/img.png"),
                ),
                  const SizedBox(width: 8),
                  if (!centerTitle)
                    GestureDetector(
                      onTap: onTitleTap,
                      child: _buildTitle(),
                    ),
                ],
              ),
              if (centerTitle)
                GestureDetector(
                  onTap: onTitleTap,
                  child: _buildTitle(),
                ),
              Row(
                children: actions ??
                    [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xFF4304cb),
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                    ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor ?? const Color(0xFF333333),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          height: 2,
          width: 30,
          decoration: BoxDecoration(
            color: const Color(0xFF4304cb),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

